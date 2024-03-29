IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.NovaUspCheckingMemDup') AND sysstat & 0xf = 4)
	drop procedure dbo.NovaUspCheckingMemDup
GO

CREATE PROCEDURE dbo.NovaUspCheckingMemDup
(	
	@form_system_id		VARCHAR(10),
	@request_no			VARCHAR(30)
) AS
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	NovaUspCheckingMemDup.SQL - Prepare TPOLPDTCOM table for TPOLPDTCOM_NOVA letter
        
        PROCESSING DETAILS:
        Prepare TPOLPDTCOM table for TPOLPDTCOM_NOVA letter
			
	AUTHOR      :     Sting Wu
	DATE	    :     02/15/2015
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        5.0	  NOVA		Sting Wu				02/15/2015	Initial Version
********************************************************************/
/*error handling variable section*/
BEGIN

SET NOCOUNT ON

declare @sql	nvarchar(3000)
declare	@cMsg	nvarchar(3000)

delete from TNovaProcessMsg where Request_No = @request_no and MsgReadIND = 'N' and ISNULL(msgcode,'')<>''

if( @form_system_id='')
begin
	select @form_system_id = t1.form_system_id from teflow_wkf_define t1 
	inner join teflow_wkf_process t2 on  t2.request_no = @request_no
		and t1.flow_id = t2.flow_id
end

create table #temp_message (MSG nvarchar(3000) collate Chinese_PRC_CI_AS null , 
MsgCode varchar(50) collate Chinese_PRC_CI_AS null, 
MsgIndicator varchar(2) collate Chinese_PRC_CI_AS null)

set @sql = 'insert into #temp_message
select DISTINCT (N''人员信息中，身份证号码''+field_9_7
+N''在这张表单中重复了''+cast(countNo as nvarchar)+N''次'') as MSG,''E005'' as MsgCode, ''E'' as MsgIndicator
 from (select field_9_7,COUNT(1) as countNo 
from teflow_'+@form_system_id+'_9 where request_no = '''+@request_no+'''
group by field_9_7) T where countNo > 1'

exec sp_executesql @sql

set @sql = 'insert into #temp_message
select DISTINCT (N''人员信息中，被保险编号''+field_9_1
+N''在这张表单中重复了''+cast(countNo as nvarchar)+N''次'') as MSG,''E006'' as MsgCode, ''E'' as MsgIndicator
 from (select field_9_1,COUNT(1) as countNo 
from teflow_'+@form_system_id+'_9 where request_no = '''+@request_no+''' and isnull(field_9_1,'''') <> ''''
group by field_9_1) T where countNo > 1'

exec sp_executesql @sql

set @sql = 'insert into #temp_message
select (N''人员信息中，身份证号码'' + field_9_7 
+ N''在另外一张表单'' + request_no 
+ N''中重复了'') as MSG,''W001'' as MsgCode,''W'' as MsgIndicator
 from (select t1.request_no,t1.field_9_7,COUNT(1) as countNo 
from teflow_'+@form_system_id+'_9 t1 
inner join teflow_'+@form_system_id+'_9 t2 on t2.request_no = '''+@request_no+''' 
	and t1.field_9_7 = t2.field_9_7
	and t2.request_no <> t1.request_no
group by t1.request_no,t1.field_9_7) T where countNo >= 1'

exec sp_executesql @sql

if (@form_system_id = 20264)
begin
	set @sql = N'insert into #temp_message	
	SELECT DISTINCT N''人员 '' + t1.NAME + ''/''+ t1.MEMIDNO + N'' 在Nova表单(''+ t4.request_no +'')中存在重复投保'' AS MSG,
	''W002'' as MsgCode,
	''W'' as MsgIndicator	
	 FROM (select NAME = field_9_2, 
			MEMIDNO = field_9_7 , 
			PRODCODE = t2.PRODCODE 
		from teflow_'+@form_system_id+'_9 t1 
		inner join  TNovaProductMapping t2 on t1.MemProduct_id = t2.NOVA_PRODCODE
			and request_no = '''+@request_no+''') t1 
	inner join teflow_'+@form_system_id+'_9 t4 on t1.MEMIDNO = t4.field_9_7 and t4.request_no <> '''+@request_no+'''
	inner join teflow_wkf_process t3 on t4.request_no = t3.request_no 
		and t3.[status] <> ''04''
	inner join TNovaProductMapping t5 on t4.MemProduct_id = t5.NOVA_PRODCODE
		and t1.PRODCODE = t5.PRODCODE
		and not exists ( SELECT 1 FROM TNovaProductMapping WHERE PRODCODE = T5.PRODCODE 
				AND ((PRODCODE NOT IN (''CEB16'',''CEB17'',''CPA12'') 
				AND t1.PRODCODE = ''PACI2'') OR 
					(PRODCODE = ''PACI2''
				AND t1.PRODCODE NOT IN (''CEB16'',''CEB17'',''CPA12'') )))'
end

exec sp_executesql @sql

--declare cur_ReturnMsg cursor for
--	select MSG from #temp_message
--open cur_ReturnMsg

--FETCH NEXT FROM cur_ReturnMsg INTO @cMsg
--WHILE (@@FETCH_STATUS = 0)
--BEGIN
--	SELECT @cRETMESSAGE = @cRETMESSAGE+ CHAR(13)+@cMsg 

--FETCH NEXT FROM cur_ReturnMsg INTO @cMsg
--END

--CLOSE cur_ReturnMsg 
--DEALLOCATE cur_ReturnMsg

if exists (select 1 from #temp_message)
begin
	insert into TNovaProcessMsg (Request_No,MsgText,MsgCode,MsgIndicator,MsgReadIND)
	select distinct @request_no as Request_No,t1.MSG as MsgText,t1.MsgCode,t1.MsgIndicator,'N' as MsgReadIND 
	from #temp_message t1 
	left join  TNovaProcessMsg t2 on t2.Request_No = @request_no and MsgReadIND = 'N' and t1.MsgCode = t2.MsgCode
		and t1.MSG = t2.MsgText
	where t2.Request_No is null
end

select COUNT(1) as MSGNO from TNovaProcessMsg where Request_No = @request_no and MsgReadIND = 'N' and ISNULL(msgcode,'')<>''

drop table #temp_message


END

GO