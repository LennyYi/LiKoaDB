if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[poef_wkf_getHomeSpanList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [dbo].[poef_wkf_getHomeSpanList]
GO
/*********************** REVISION LOG: ***********************************
Version			Date			Revised by				Remark
1.0				20150304		Sting Wu				initial
**************************************************************************/
CREATE PROCEDURE [dbo].[poef_wkf_getHomeSpanList]
(@staff_code varchar(10),
@PageIndex int,
@runTime varchar(19),
@status varchar(10)
)
AS
BEGIN
SET NOCOUNT ON

declare @exeValue nvarchar(500)

create table #tempTable (field_value varchar(400) collate Chinese_PRC_CI_AS null,
	request_no varchar(30) collate Chinese_PRC_CI_AS null)

declare cur_insTMPTable cursor for 

SELECT distinct 'insert into #tempTable select '+t5.field_id+' as field_value,request_no from '+t6.table_name + ' where request_no = ''' +a.request_no+''''
FROM teflow_wkf_process a 
INNER JOIN teflow_wkf_define b on a.flow_id = b.flow_id 
	and ((a.request_staff_code = @staff_code or a.submit_staff_code = @staff_code ) 
	or (','+rtrim(a.current_processor)+','  like '%'+@staff_code+'%' 
		or ','+rtrim(a.invited_expert)+',' like '%[,/]'+@staff_code+'[,/]%') 
   and (a.[status]<>'03' or (a.[status]='03' and a.node_id<>'0'))  and a.[status]<>'00')
INNER JOIN teflow_form c on b.form_system_id = c.form_system_id 
INNER JOIN teflow_wkf_detail d on a.flow_id = d.flow_id and a.node_id = d.node_id 
inner join teflow_form_special_field t5 on b.form_system_id = t5.form_system_id  and t5.field_type = 2 
inner join teflow_form_section t6 on t5.form_system_id = t6.form_system_id and t6.section_id = t5.section_id

open cur_insTMPTable	

FETCH NEXT FROM cur_insTMPTable INTO @exeValue
WHILE (@@FETCH_STATUS = 0)
BEGIN

	exec sp_executesql @exeValue


FETCH NEXT FROM cur_insTMPTable INTO @exeValue;
END

CLOSE cur_insTMPTable 
DEALLOCATE cur_insTMPTable 


SELECT a.request_staff_code,b.form_system_id, a.request_no, c.form_name, ISNULL(a.receiving_date,a.submission_date) AS receiving_date, a.[status], a.submission_date,
		a.submit_staff_code, a.previous_processor, a.current_processor,OPERATION = 'D',
		'1' as open_flag,a.urgent_level,isnull(a.inprocess, '0') as inprocess,a.invited_expert,a.is_deputy,
		(case a.invited_expert when '' then 'b' else 'a' end) as has_invited,a.node_id,a.origin_processor,
		(case when a.inprocess_staff_code=@staff_code then '0' 
			when ','+rtrim(a.invited_expert)+',' like '%[,/]' + @staff_code +'[,/]%' then '0' 
			when inprocess_staff_code<>'' then '2' 
			else '0' end) as somebody_locked into #tempTable2
FROM teflow_wkf_process a 
INNER JOIN teflow_wkf_define b on a.flow_id = b.flow_id 
	and (a.request_staff_code = @staff_code or a.submit_staff_code = @staff_code ) 
INNER JOIN teflow_form c on b.form_system_id = c.form_system_id 
INNER JOIN teflow_wkf_detail d on a.flow_id = d.flow_id and a.node_id = d.node_id 
UNION ALL
SELECT a.request_staff_code,b.form_system_id, a.request_no, c.form_name, ISNULL(a.receiving_date,a.submission_date) AS receiving_date, a.[status], a.submission_date, 
	a.submit_staff_code, a.previous_processor, a.current_processor, OPERATION = 'P',
	a.open_flag,a.urgent_level,isnull(a.inprocess, '0') as inprocess,a.invited_expert,a.is_deputy,
	(case a.invited_expert when '' then 'b' else 'a' end) as has_invited,a.node_id,a.origin_processor,
	(case when a.inprocess_staff_code=@staff_code then '0' 
		when ','+rtrim(a.invited_expert)+',' like '%[,/]' + @staff_code +'[,/]%' then '0' 
		when inprocess_staff_code<>'' then '2' 
		else '0' end) as somebody_locked
FROM teflow_wkf_process a 
INNER JOIN teflow_wkf_define b ON a.flow_id = b.flow_id and 
		(','+rtrim(a.current_processor)+','  like '%'+@staff_code+'%' 
		or ','+rtrim(a.invited_expert)+',' like '%[,/]'+@staff_code+'[,/]%') 
   and (a.[status]<>'03' or (a.[status]='03' and a.node_id<>'0'))  and a.[status]<>'00'
INNER JOIN teflow_form c ON b.form_system_id = c.form_system_id  
INNER JOIN teflow_wkf_detail d ON a.flow_id = d.flow_id AND a.node_id = d.node_id 

select t6.request_no,count(1) as CountNo into #tempTable3 from teflow_wkf_process_trace t6 
	inner join (select distinct request_no from #tempTable2) t7 
	on handle_type = '07' and t6.request_no = t7.request_no
    and handle_date >= (SELECT MAX(handle_date) FROM teflow_wkf_process_trace 
		WHERE (handle_type = '06') and request_no = t6.request_no)
	group by t6.request_no
	
declare @sql nvarchar(Max)

set @sql= N'select REQUESTNO = t1.request_no,  
	FORMNAME = t1.form_name,  
	CONTENT = isnull(t5.field_value,''''),
	[STATUS] = (case t1.[status] when ''00'' then ''DRAFT''
			when ''01'' then ''SUBMITTED''
			when ''02'' then ''INPROGRESS''
			when ''03'' then ''REJECTED''
			when ''04'' then ''COMPLETED''
			else '''' end),  
	SUBMISSIONDATE = submission_date, 
	SUBMITTEDBY = t2.Staff_name,  
	PREVIOUSPROCESSOR = t3.Staff_name,  
	CURRENTPROCESSOR = t4.Staff_name,
	OPERATION = OPERATION,
	OPENFLAG = t1.open_flag,
	FORMIMG = t7.Form_image,
	ADVISEEXPERT =(CASE WHEN (t1.invited_expert like ''%'' + RTRIM('''+@staff_code+N''') +''%'') 
					AND t1.current_processor <> '''+@staff_code+N'''
					THEN ''1'' ELSE ''0'' END),
	SYSFORMID = t1.form_system_id,
	VIEWFLAG = (CASE WHEN (t1.request_staff_code = '''+@staff_code+N''' OR t1.submit_staff_code = '''+@staff_code+N''') THEN ''0'' ELSE ''1'' END),
	TEMPSTATUS = (CASE WHEN t1.node_id <> ''0'' and t1.[status] = ''03'' THEN ''02'' ELSE t1.[status] END),
	receiving_date,
	t1.somebody_locked,
	t1.urgent_level
from #tempTable2 t1
left join #tempTable3 t6 on t1.request_no = t6.request_no 
left join teflow_user t2 on t1.submit_staff_code = t2.Staff_code
left join teflow_user t3 on t1.previous_processor = t3.Staff_code
left join teflow_user t4 on t1.current_processor = t4.Staff_code
left join #tempTable t5 on t1.request_no = t5.request_no
left join teflow_form t7 on t7.form_system_id = t1.form_system_id
where (t1.receiving_date < '''+ @runTime +''' or isnull('''+ @runTime +''','''') = '''')'

if (@status='02')
	set @sql = @sql +' and (t1.[status] in (''01'',''02''))'
else
	set @sql = @sql +' and (t1.[status] = '''+ @status +''' or isnull('''+ @status +''','''') = '''')'

exec poef_wkf_PagingQuery @sql,'','receiving_date desc, REQUESTNO desc, OPERATION desc, OPENFLAG, somebody_locked, urgent_level desc',6,@PageIndex
--order by receiving_date desc, t1.request_no desc, OPERATION desc, t1.open_flag,t1.somebody_locked, t1.urgent_level desc, 
--inprocess desc, t1.has_invited


DROP TABLE #tempTable
DROP TABLE #tempTable2
DROP TABLE #tempTable3

END

