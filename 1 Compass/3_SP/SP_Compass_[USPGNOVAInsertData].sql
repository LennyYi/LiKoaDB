IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.USPGNOVAInsertData') AND sysstat & 0xf = 4)
	drop procedure dbo.USPGNOVAInsertData
GO
SET ANSI_NULLS ON 
SET QUOTED_IDENTIFIER ON  
SET CONCAT_NULL_YIELDS_NULL ON 
SET ANSI_WARNINGS ON 
SET ANSI_PADDING ON 
GO
CREATE PROCEDURE dbo.USPGNOVAInsertData
(	@cTRANDATE		CHAR(10), 
	@request_no		VARCHAR(30),
	@staff_code		VARCHAR(10),
	@cUSERID		CHAR(8),
	@cCALLTYPE		CHAR(1),	 --	O - Online, B -- Batch
	@cRETCODE		CHAR(4) OUTPUT,
	@cRETMESSAGE	NVARCHAR(MAX) OUTPUT
) AS
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	USPGNOVAInsertData.SQL - Prepare TPOLPDTCOM table for TPOLPDTCOM_NOVA letter
        
        PROCESSING DETAILS:
        Prepare TPOLPDTCOM table for TPOLPDTCOM_NOVA letter
			
	AUTHOR      :     Issca Zhu
	DATE	    :     11/06/2014
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        5.0	  NOVA		Issca Zhu				11/06/2014	Initial Version
********************************************************************/
/*error handling variable section */
BEGIN

DECLARE @ErrFrom	CHAR(20)
DECLARE @cErrorMsg	varchar(3000) 
DECLARE @ErrData	CHAR(45)
DECLARE @ErrCode        INT
DECLARE @StoreProcInd   CHAR(1)
DECLARE	@cMSGID		CHAR(5)
/*DECLARE VARIABLES AND CONSTANTS*/
DECLARE	@cACTIVE	CHAR(1)
DECLARE	@cDELETED	CHAR(1)
DECLARE	@cYES		CHAR(1)
DECLARE	@cNO		CHAR(1)
DECLARE @cProgramID VARCHAR(60)
DECLARE	@form_id	decimal(9,0)
DECLARE	@cERRORCODE	CHAR(4)

SELECT @cACTIVE = 'A' , @cRETCODE = '0000', @cProgramID = 'dbo.USPGNOVAInsertData'

declare @XML XML

SET ANSI_NULLS ON 
SET QUOTED_IDENTIFIER ON  
SET CONCAT_NULL_YIELDS_NULL ON 
SET ANSI_WARNINGS ON 
SET ANSI_PADDING ON 

SELECT @cERRORCODE = RTRIM(error_code)  FROM T_Nova_CompassProcess WHERE process_sp  = 'USPGNOVAInsertData'

INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
VALUES(@request_no,@cProgramID,'Insert Begin',@cUSERID,GETDATE())

SELECT @XML = NovaXML FROM T_Nova_TXMLConvert where request_no = @request_no --'NBForm_11112014_02'

select @form_id = T.N.value('@form_system_id','decimal(9,0)') From @XML.nodes('form') T(N)

select DISTINCT upper(T.N.value('local-name(.)','varchar(20)')) AS TABLENAME 
into #temp1
from @XML.nodes('/form/*') T(N)

SELECT @ErrCode = @@error
IF @ErrCode <> 0
BEGIN
	SELECT @cRETCODE = @cERRORCODE
	
	INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
	VALUES(@request_no,@cProgramID,'insert temp table #temp1 error',@cUSERID,GETDATE())
	
	GOTO EXIT_WINDOW
END	

select DISTINCT TABLENAME,
	COLNAME2 = T2.N2.value('local-name(.)','nvarchar(20)')
into #temp2 
from #temp1 TT 
cross apply @XML.nodes('/form/*[upper-case(local-name(.))=sql:column("TT.TABLENAME")]/*/*') T2(N2)
where isnull(T2.N2.value('@key','nvarchar(20)'),'') = ''


SELECT @ErrCode = @@error
IF @ErrCode <> 0
BEGIN
	SELECT @cRETCODE = @cERRORCODE
	
	INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
	VALUES(@request_no,@cProgramID,'insert temp table #temp2 error',@cUSERID,GETDATE())
	
	GOTO EXIT_WINDOW
END	

select DISTINCT TABLENAME,
COLNAME2 = T2.N2.value('local-name(.)','nvarchar(20)'),
MAPKEY = T2.N2.value('@key','nvarchar(20)'),
KEYVALUE = T2.N2.value('(.)[1]','varchar(1000)')
into #temp3 
from #temp1 TT 
cross apply @XML.nodes('/form/*[upper-case(local-name(.))=sql:column("TT.TABLENAME")]/*/*') T2(N2) 
where isnull(T2.N2.value('@key','nvarchar(20)'),'') <> ''

SELECT @ErrCode = @@error
IF @ErrCode <> 0
BEGIN
	SELECT @cRETCODE = @cERRORCODE
	
	INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
	VALUES(@request_no,@cProgramID,'insert temp table #temp3 error',@cUSERID,GETDATE())
	
	GOTO EXIT_WINDOW
END	


select tableName,(select ' AND ' + MAPKEY + '= ''' + KEYVALUE  + ''''
		from #temp3 where TABLENAME = t5.TABLENAME for xml path('')) key_join
into #temp4  
from #temp3 T5 group by tableName

SELECT @ErrCode = @@error
IF @ErrCode <> 0
BEGIN
	SELECT @cRETCODE = @cERRORCODE
	
	INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
	VALUES(@request_no,@cProgramID,'insert temp table #temp4 error',@cUSERID,GETDATE())
	
	GOTO EXIT_WINDOW
END	

select tableName = T.N.value('local-name(.)','varchar(20)'),
	insertScript = 'SELECT ' + 
			stuff((
				select ',Tbl.Col.value(''' + t4.COLNAME2 + '[1]'','''+
				--type case
				(CASE WHEN T3.name IN ('NCHAR','NVARCHAR') then T3.name + '(' + IIF(t2.max_length = -1,'MAX',CAST(t2.max_length/2 AS VARCHAR)) + ')' 
					WHEN T3.name IN ('CHAR','VARCHAR') then T3.name + '(' + IIF(t2.max_length = -1,'MAX',CAST(t2.max_length AS VARCHAR)) + ')'
					WHEN T3.name = 'DECIMAL'  then T3.name + '(' + CAST(t2.[precision] AS varchar) + ',' + CAST(t2.[scale] AS varchar) + ')'
					ELSE T3.name END) + ''') AS ' + t2.name 
					from SYS.COLUMNS T2 
					INNER JOIN SYS.TYPES T3 
								ON T2.system_type_id = T3.system_type_id  
								AND T2.user_type_id = T3.user_type_id  
								AND object_id(T.N.value('local-name(.)','varchar(20)')) = T2.OBJECT_ID
					LEFT JOIN #temp3 T5 ON T2.OBJECT_ID = object_id(T5.TABLENAME) AND T5.COLNAME2 = T2.NAME
					INNER JOIN #temp2 T4 
								ON T.N.value('local-name(.)','varchar(20)') = t4.TABLENAME 
									AND T2.NAME = t4.COLNAME2
									and T5.COLNAME2 is null
					ORDER BY T.N.value('local-name(.)','varchar(20)'), column_id
			for xml path('')),1,1,'' ) 
		+ CHAR(13) + 
		' FROM @xml2.nodes(''/form/'+T.N.value('local-name(.)','varchar(20)')+'/item'') Tbl(Col) '  
		into #temp5
from @XML.nodes('/form/*') T(N)

SELECT @ErrCode = @@error
IF @ErrCode <> 0
BEGIN
	SELECT @cRETCODE = @cERRORCODE
	
	INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
	VALUES(@request_no,@cProgramID,'insert temp table #temp5 error',@cUSERID,GETDATE())
	
	GOTO EXIT_WINDOW
END	


SELECT t2.tableName,
insert_Script = (CASE WHEN ISNULL(t1.key_join,'') <> '' THEN
			N'insert into ' + t2.tableName + char(13) +
			N'SELECT DISTINCT ' + char(13) +
				stuff((select
				case when ttm.COLNAME2 is null then N',T1.' + tc.name 
				else N',T2.' + tc.NAME end
				from sys.columns tc 
				left join #temp2 ttm on ttm.tableName = t2.tableName and tc.name = ttm.COLNAME2
				where OBJECT_ID= OBJECT_ID('NOVA.' +t2.tableName + '_TEMPLATE') AND name not in ('form_system_id','PKGPRDCD')
				order by column_id for xml path('')),1,1,'' ) + char(13) +
			N'FROM ( ' + t2.insertScript + N' ) T2 '+ char(13) +
			N'cross join (select * from NOVA.' + t2.tableName + N'_TEMPLATE where Form_system_ID = CASE WHEN (SELECT DISTINCT 1 FROM NOVA.' + t2.tableName + N'_TEMPLATE WHERE FORM_SYSTEM_ID=' + CONVERT(VARCHAR(9),@form_id) +
			') = 1 THEN ' + CONVERT(VARCHAR(9),@form_id)+ ' ELSE 0 END'+char(13)+'and 1=1 ' + char(13)+ t1.key_join + ') T1;'
		ELSE
			N'insert into ' + t2.tableName + char(13) +
			N'SELECT DISTINCT ' + char(13) +
				stuff((select
				case when ttm.COLNAME2 is null then N',T1.' + tc.name 
				else N',T2.' + tc.NAME end
				from sys.columns tc 
				left join #temp2 ttm on ttm.tableName = t2.tableName and tc.name = ttm.COLNAME2
				where OBJECT_ID= OBJECT_ID('NOVA.' + t2.tableName + '_TEMPLATE') AND name not in ('form_system_id','PKGPRDCD')
				order by column_id for xml path('')),1,1,'' ) + char(13) +
			N'FROM ( ' + t2.insertScript + N' ) T2 '+ char(13) +
			N'cross join (select * from NOVA.' + t2.tableName + N'_TEMPLATE where Form_system_ID =  CASE WHEN (SELECT DISTINCT 1 FROM NOVA.' + t2.tableName + N'_TEMPLATE WHERE FORM_SYSTEM_ID=' + CONVERT(VARCHAR(9),@form_id) +
			') = 1 THEN ' + CONVERT(VARCHAR(9),@form_id) +' ELSE 0 END'+') T1 ;' 
		END)  
into #temp6
from #temp5 t2
left join #temp4 t1 on t1.tableName = t2.tableName

SELECT @ErrCode = @@error
IF @ErrCode <> 0
BEGIN
	SELECT @cRETCODE = @cERRORCODE
	
	INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
	VALUES(@request_no,@cProgramID,'insert temp table #temp6 error',@cUSERID,GETDATE())
	
	GOTO EXIT_WINDOW
END	

IF EXISTS (SELECT 1 FROM #temp6 WHERE insert_Script is null)
BEGIN
	SELECT @cRETCODE = @cERRORCODE
	select top 1 @cErrorMsg = 'generate script error for table: ' + tableName from #temp6 WHERE insert_Script is null

	INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
	VALUES(@request_no,@cProgramID,@cErrorMsg,@cUSERID,GETDATE())
	
	GOTO EXIT_WINDOW
END

drop table #temp1
drop table #temp2
drop table #temp3
drop table #temp4
drop table #temp5

delete from T_Nova_InsertCheck where request_no = @request_no

insert into T_Nova_InsertCheck
select tableName,insert_Script,@request_no as request_no from #temp6

declare @exeValue nvarchar(4000),@exeDeclare nvarchar(200)

set @exeDeclare = N'declare @xml2 xml;' + CHAR(13) +
				  N'SELECT @xml2 = NovaXML FROM T_Nova_TXMLConvert where request_no = ''' + @request_no + ''';'


INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
VALUES(@request_no,@cProgramID,'start insert main table script',@cUSERID,GETDATE())

begin try
	begin tran

	If Cursor_Status('global','cur_insertTable')>=-1 
	BEGIN
		DEALLOCATE cur_insertTable
	End
	
	declare cur_insertTable cursor for
		select insert_Script from #temp6
		
	open cur_insertTable	

	FETCH NEXT FROM cur_insertTable INTO @exeValue
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		set @exeValue =  @exeDeclare + CHAR(13) + @exeValue;
		
		exec sp_executesql @exeValue
		
	FETCH NEXT FROM cur_insertTable INTO @exeValue
	END

	CLOSE cur_insertTable 
	DEALLOCATE cur_insertTable
		
	INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
	VALUES(@request_no,@cProgramID,'start insert sub table script',@cUSERID,GETDATE())

	If Cursor_Status('global','cur_insertSubTable')>=-1 
	BEGIN
		DEALLOCATE cur_insertSubTable
	End

	declare cur_insertSubTable cursor for
		select VALUEUSAGE from TSYSPARMH where PARMDESC='NOVASP' AND PARMTYPE = CONVERT(VARCHAR(9),@form_id) ORDER BY PARMVALUE
	open cur_insertSubTable

	FETCH NEXT FROM cur_insertSubTable INTO @exeValue
	WHILE (@@FETCH_STATUS = 0)
	BEGIN

		set @exeValue = Cast('exec ' + @exeValue + ' ''' + @request_no + '''' as nvarchar(300))

		exec sp_executesql @exeValue
		
	FETCH NEXT FROM cur_insertSubTable INTO @exeValue
	END

	CLOSE cur_insertSubTable 
	DEALLOCATE cur_insertSubTable
	
	commit tran
end try
begin catch

	if @@trancount > 0
		rollback tran
	
	If Cursor_Status('global','cur_insertTable')>=-1 
	BEGIN
		DEALLOCATE cur_insertTable
	End
	If Cursor_Status('global','cur_insertSubTable')>=-1 
	BEGIN
		DEALLOCATE cur_insertSubTable
	End
	
	DECLARE @ErrorMessage NVARCHAR(4000);  
	DECLARE @ErrorSeverity INT;  
	DECLARE @ErrorState INT;  
	  
	SELECT @ErrorMessage = ERROR_MESSAGE(),  
	@ErrorSeverity = ERROR_SEVERITY(),  
	@ErrorState = ERROR_STATE();  

	
	SELECT @cRETCODE = @cERRORCODE
	Set @cErrorMsg = @ErrorMessage

	INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
	VALUES(@request_no,@cProgramID,@cErrorMsg+char(13)+'*****'+ char(13)+ @exeValue,@cUSERID,GETDATE())

	GOTO EXIT_WINDOW
end catch


INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
VALUES(@request_no,@cProgramID,'Insert Successful',@cUSERID,GETDATE())

EXIT_WINDOW:

SET ANSI_NULLS OFF 
SET QUOTED_IDENTIFIER OFF  
SET CONCAT_NULL_YIELDS_NULL OFF 
SET ANSI_WARNINGS OFF 
SET ANSI_PADDING OFF 

	RETURN

END

SET ANSI_NULLS OFF 
SET QUOTED_IDENTIFIER OFF  
SET CONCAT_NULL_YIELDS_NULL OFF 
SET ANSI_WARNINGS OFF 
SET ANSI_PADDING OFF 
go
