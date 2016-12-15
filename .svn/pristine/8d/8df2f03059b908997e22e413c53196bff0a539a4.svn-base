IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.USPGNOVAAnalyseXML') AND sysstat & 0xf = 4)
	drop procedure dbo.USPGNOVAAnalyseXML
GO
SET ANSI_NULLS ON 
SET QUOTED_IDENTIFIER ON  
SET CONCAT_NULL_YIELDS_NULL ON 
SET ANSI_WARNINGS ON 
SET ANSI_PADDING ON 
GO

CREATE PROCEDURE dbo.USPGNOVAAnalyseXML
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

	USPGNOVAAnalyseXML.SQL - Analyse XML to dispatch the record 
        
        PROCESSING DETAILS:
        Analyse XML to dispatch the record
			
	AUTHOR      :     Keith He
	DATE	    :     12/12/2014
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        5.0	  NOVA		Keith He				12/12/2014	Initial Version
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
DECLARE @nCurCount	INT
DECLARE @nTotalCount	INT
DECLARE @cTableName	VARCHAR(20)
DECLARE @xmlRecord	XML
DECLARE @nOrder_Idx	INT
DECLARE @cExitSQL	NVARCHAR(MAX)
DECLARE @nExist		INT
DECLARE @nIdx		INT
DECLARE @cSqlStatement	NVARCHAR(MAX)

SELECT @cACTIVE = 'A' , @cRETCODE = '0000', @cProgramID = 'dbo.USPGNOVAAnalyseXML'

declare @XML XML

SET ANSI_NULLS ON 
SET QUOTED_IDENTIFIER ON  
SET CONCAT_NULL_YIELDS_NULL ON 
SET ANSI_WARNINGS ON 
SET ANSI_PADDING ON 

create table #temp1
(
	order_idx		int				null,
	tablename		varchar(20)		null
)

create table #temprecorxml
(
	idx				int				identity(1,1),
	order_idx		int				null,
	tablename		varchar(20)		null,
	recordxml		xml				null,
	sqlstatement	nvarchar(max)	null
)

INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
VALUES(@request_no,@cProgramID,'Analyse XML Begin',@cUSERID,GETDATE())

--Retrieve the form XML
SELECT @XML = NovaXML FROM T_Nova_TXMLConvert where request_no = @request_no --'NBForm_11112014_02'

--Retrieve the form ID from XML
select @form_id = T.N.value('@form_system_id','decimal(9,0)') From @XML.nodes('form') T(N)

SELECT @cERRORCODE = RTRIM(error_code)  FROM T_Nova_CompassProcess WHERE process_sp  = 'USPGNOVAAnalyseXML' AND (form_system_id = @form_id OR form_system_id =0)

--Retrieve distinct table name from XML in sequence
select @nTotalCount = @XML.value('count(/form/*)','int')
select @nCurCount = 0

while @nCurCount <= @nTotalCount
begin
	select @cTableName = T.a.value('upper-case(local-name(.))','varchar(20)')
	from @XML.nodes('/form/*[position()=sql:variable("@nCurCount")]') T(a)

	insert into #temp1 (order_idx, tablename) values(@nCurCount, @cTableName)

	SELECT @ErrCode = @@error
	IF @ErrCode <> 0
	BEGIN
		SELECT @cRETCODE = @cERRORCODE
	
		INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
		VALUES(@request_no,@cProgramID,'insert temp table #temp1 error',@cUSERID,GETDATE())
	
		GOTO EXIT_WINDOW
	END	

	select @nCurCount = @nCurCount + 1
end

--Separate XML into record level
insert into #temprecorxml(order_idx, tablename, recordxml)
select t1.order_idx, t1.TABLENAME, convert(XML, '<form><' + t1.TABLENAME + '>' + convert(nvarchar(max), t.a.query('.')) + '</' + t1.TABLENAME + '></form>') as recordxml
--into #temprecorxml
from #temp1 t1
cross apply 
@XML.nodes('/form/*[upper-case(local-name(.))=sql:column("t1.TABLENAME")]/item') t(a)


--Loop record XML
declare cur_recordxml cursor for
select t1.idx, t1.order_idx, t1.tablename, t1.recordxml
from #temprecorxml T1
order by t1.order_idx, t1.idx

open cur_recordxml
fetch next from cur_recordxml into @nIdx, @nOrder_Idx, @cTableName, @xmlRecord

while @@fetch_status = 0
begin
	select @nExist = 0

	if exists (select 1 from sys.sysobjects where xtype = 'PK' and parent_obj = object_id(@cTableName))
	begin
			select @cExitSQL = 'select @nExist = 1' + char(13) + 'from ' + @cTableName + ' t1' + char(13) + 
							'cross apply @xmlJudge.nodes(''/form/*[upper-case(local-name(.))=sql:variable("@cTableNameJudge")]/item'') Tbl(Col)' + char(13) +
							'where ' + 
							stuff((select ',t1.' + t3.name + ' = ' + 'Tbl.Col.value(''' + t3.name + '[1]''' + '|!|''' + 
											(CASE 
												WHEN t4.name IN ('NCHAR','NVARCHAR')	then t4.name + '(' + IIF(t3.max_length = -1,'MAX',CAST(t3.max_length/2 AS VARCHAR)) + ')' 
												WHEN t4.name IN ('CHAR','VARCHAR')		then t4.name + '(' + IIF(t3.max_length = -1,'MAX',CAST(t3.max_length AS VARCHAR)) + ')'
												WHEN t4.name = 'DECIMAL'				then t4.name + '(' + CAST(t3.[precision] AS varchar) + ',' + CAST(t3.[scale] AS varchar) + ')'
												ELSE t4.name  END
											) + ''')'
											from sys.sysobjects t0
											INNER JOIN sys.sysindexes t1
												ON t0.name = t1.name
											INNER JOIN sys.sysindexkeys t2
												ON t2.indid = t1.indid
											INNER JOIN SYS.COLUMNS t3
												ON t3.OBJECT_ID = OBJECT_ID(@cTableName)
												and t3.name = col_name(object_id(@cTableName), t2.colid)
											INNER JOIN SYS.TYPES t4
												ON t4.system_type_id = T3.system_type_id  
												and t4.user_type_id = T3.user_type_id
											cross apply @xmlRecord.nodes('/form/*[upper-case(local-name(.))=sql:variable("@cTableName")]/item/*[upper-case(local-name(.))=upper-case(sql:column("t3.name"))]') Tbl(Col)
											where t0.xtype = 'PK'
											and t0.parent_obj = object_id(@cTableName)
											and t2.id = object_id(@cTableName)
											for xml path('')
									),1,1,''
								   )

			select @cExitSQL = replace(@cExitSQL, ',', ' and ')
			select @cExitSQL = replace(@cExitSQL, '|!|', ',')
			select @cExitSQL = replace(@cExitSQL, '4 and 0', ' 4,0 ')

			select @cExitSQL = 'declare @xmlJudge xml, @cTableNameJudge varchar(20);' + CHAR(13) +
							   'SELECT @xmlJudge = convert(xml, ''' + convert(nvarchar(max), @xmlRecord) + ''');' + CHAR(13) +
							   'SELECT @cTableNameJudge = ''' + @cTableName + ''';' + CHAR(13) +
							   @cExitSQL

			begin try
					exec sp_executesql @cExitSQL, N'@nExist int output', @nExist output
			end try
			begin catch
					SELECT @ErrCode = @@error
					IF @ErrCode <> 0
					BEGIN
							SELECT @cRETCODE = @cERRORCODE
	
							INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
							VALUES(@request_no,@cProgramID,'judge record existence error',@cUSERID,GETDATE())
	
							close cur_recordxml
							deallocate cur_recordxml

							GOTO EXIT_WINDOW
					END	
			end catch
	end

	--If not exist, call insert logic, else call update logic
	if @nExist = 1
	begin
			--call update logic
			exec UspGNOVAPrepareUpdateStatement @cTRANDATE, @request_no, @xmlRecord, @cUSERID, @cCALLTYPE, @form_id, @cRETCODE output, @cSqlStatement output

			if @cRETCODE <> '0000'
			begin
					INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
					VALUES(@request_no,@cProgramID,'calling prepare update statement SP error',@cUSERID,GETDATE())

					close cur_recordxml
					deallocate cur_recordxml
					GOTO EXIT_WINDOW
			end
	end
	else
	begin
			--call insert logic
			exec UspGNOVAPrepareInsertStatement @cTRANDATE, @request_no, @xmlRecord, @cUSERID, @cCALLTYPE, @form_id, @cRETCODE output, @cSqlStatement output

			if @cRETCODE <> '0000'
			begin
					INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
					VALUES(@request_no,@cProgramID,'calling prepare insert statement SP error',@cUSERID,GETDATE())

					close cur_recordxml
					deallocate cur_recordxml
					GOTO EXIT_WINDOW
			end
	end

	--Update insert/update statement back to temp table
	update #temprecorxml set sqlstatement = @cSqlStatement where idx = @nIdx and order_idx = @nOrder_Idx and tablename = @cTableName

	SELECT @ErrCode = @@error
	IF @ErrCode <> 0
	BEGIN
			SELECT @cRETCODE = @cERRORCODE
	
			INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
			VALUES(@request_no,@cProgramID,'update insert/update statement back to temp table error',@cUSERID,GETDATE())
	
			close cur_recordxml
			deallocate cur_recordxml
			GOTO EXIT_WINDOW
	END	

	fetch next from cur_recordxml into @nIdx, @nOrder_Idx, @cTableName, @xmlRecord
end
close cur_recordxml
deallocate cur_recordxml

delete from T_Nova_InsertCheck where request_no = @request_no

insert into T_Nova_InsertCheck
select tableName,sqlstatement,@request_no as request_no,order_idx as orderby from #temprecorxml

drop table #temp1
--select * from #temprecorxml

INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
VALUES(@request_no,@cProgramID,'start processing insert/update script',@cUSERID,GETDATE())

begin try
	begin tran
	
		If Cursor_Status('global','cur_sqlstatement')>=-1 
		BEGIN
			DEALLOCATE cur_sqlstatement
		End
	
		declare cur_sqlstatement cursor for
			select sqlstatement from #temprecorxml where sqlstatement is not null order by order_idx, idx
		
		open cur_sqlstatement	

		FETCH NEXT FROM cur_sqlstatement INTO @cSqlStatement
		WHILE (@@FETCH_STATUS = 0)
		BEGIN		
			exec sp_executesql @cSqlStatement
		
		FETCH NEXT FROM cur_sqlstatement INTO @cSqlStatement
		END
		CLOSE cur_sqlstatement 
		DEALLOCATE cur_sqlstatement
		
		INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
		VALUES(@request_no,@cProgramID,'start insert sub table script',@cUSERID,GETDATE())
		
		If Cursor_Status('global','cur_insertSubTable')>=-1 
		BEGIN
			DEALLOCATE cur_insertSubTable
		End

		declare cur_insertSubTable cursor for
			select VALUEUSAGE from TSYSPARMH where PARMDESC='NOVASP' 
			AND PARMTYPE = CASE WHEN (SELECT DISTINCT 1 FROM TSYSPARMH WHERE  PARMDESC='NOVASP' AND PARMTYPE=CONVERT(VARCHAR(9),@form_id)) = 1 THEN CONVERT(VARCHAR(9),@form_id)  ELSE '0' END
			ORDER BY PARMVALUE
		open cur_insertSubTable

		FETCH NEXT FROM cur_insertSubTable INTO @cSqlStatement
		WHILE (@@FETCH_STATUS = 0)
		BEGIN

			set @cSqlStatement = Cast('exec ' + @cSqlStatement + ' ''' + @request_no + '''' as nvarchar(300))

			exec sp_executesql @cSqlStatement
				

		FETCH NEXT FROM cur_insertSubTable INTO @cSqlStatement
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
	VALUES(@request_no,@cProgramID,@cErrorMsg+char(13)+'*****'+ char(13)+ @cSqlStatement,@cUSERID,GETDATE())

	GOTO EXIT_WINDOW
end catch

INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
VALUES(@request_no,@cProgramID,'Analyse XML Successful',@cUSERID,GETDATE())

drop table #temprecorxml

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
GO