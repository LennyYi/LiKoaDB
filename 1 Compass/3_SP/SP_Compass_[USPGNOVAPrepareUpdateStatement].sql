IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.USPGNOVAPrepareUpdateStatement') AND sysstat & 0xf = 4)
	drop procedure dbo.USPGNOVAPrepareUpdateStatement
GO
SET ANSI_NULLS ON 
SET QUOTED_IDENTIFIER ON  
SET CONCAT_NULL_YIELDS_NULL ON 
SET ANSI_WARNINGS ON 
SET ANSI_PADDING ON 
GO
CREATE PROCEDURE dbo.USPGNOVAPrepareUpdateStatement
(	@cTRANDATE		CHAR(10), 
	@request_no		VARCHAR(30),
	@xmlRecord		XML,
	@cUSERID		CHAR(8),
	@cCALLTYPE		CHAR(1),	 --	O - Online, B -- Batch
	@form_id		decimal(9,0),
	@cRETCODE		CHAR(4) OUTPUT,
	@cSqlStatement	NVARCHAR(MAX) OUTPUT
) AS
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	USPGNOVAPrepareUpdateStatement.SQL - Prepare insert statement for each record
        
        PROCESSING DETAILS:
        Prepare insert statement for each record
			
	AUTHOR      :     Keith He
	DATE	    :     12/17/2014
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        5.0	  NOVA		Keith He				12/17/2014	Initial Version
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
DECLARE	@cERRORCODE	CHAR(4)
DECLARE @cTableName	VARCHAR(20)
DECLARE @cUpdateSQL		NVARCHAR(MAX)
DECLARE @cUpdateCONT	NVARCHAR(MAX)

SELECT @cACTIVE = 'A' , @cRETCODE = '0000', @cProgramID = 'dbo.USPGNOVAPrepareUpdateStatement'

SET ANSI_NULLS ON 
SET QUOTED_IDENTIFIER ON  
SET CONCAT_NULL_YIELDS_NULL ON 
SET ANSI_WARNINGS ON 
SET ANSI_PADDING ON 

SELECT @cERRORCODE = RTRIM(error_code)  FROM T_Nova_CompassProcess WHERE process_sp  = 'USPGNOVAAnalyseXML'


INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
VALUES(@request_no,@cProgramID,'Prepare Update statement Begin',@cUSERID,GETDATE())

--Retrieve table name
select @cTableName = upper(T.N.value('local-name(.)','varchar(20)'))
from @xmlRecord.nodes('/form/*') T(N)

--Retrieve table field name
select DISTINCT @cTableName as TABLENAME,
	COLNAME2 = T2.N2.value('local-name(.)','nvarchar(20)')
into #temp2 
from @xmlRecord.nodes('/form/*[upper-case(local-name(.))=sql:variable("@cTableName")]/*/*') T2(N2)

SELECT @ErrCode = @@error
IF @ErrCode <> 0
BEGIN
	SELECT @cRETCODE = @cERRORCODE
	
	INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
	VALUES(@request_no,@cProgramID,'insert temp table #temp2 error',@cUSERID,GETDATE())
	
	GOTO EXIT_WINDOW
END	

if exists (select 1 from sys.sysobjects where xtype = 'PK' and parent_obj = object_id(@cTableName))
begin
	--Prepare update statement
	select @cUpdateSQL = 'update t1' + char(13) + 
						  'set ' + 
							stuff((select ', t1.' + t4.COLNAME2 + ' = ' + 'NOVA.funXMLReplaceSpecNRevert(Tbl.Col.value(''' + t4.COLNAME2 + '[1]''' + '|!|''' + 
											(CASE WHEN t3.name IN ('NCHAR','NVARCHAR')	then t3.name + '(' + IIF(t2.max_length = -1,'MAX',CAST(t2.max_length/2 AS VARCHAR)) + ')' 
												WHEN t3.name IN ('CHAR','VARCHAR')		then t3.name + '(' + IIF(t2.max_length = -1,'MAX',CAST(t2.max_length AS VARCHAR)) + ')'
												WHEN t3.name = 'DECIMAL'				then t3.name + '(' + CAST(t2.[precision] AS varchar) + ',' + CAST(t2.[scale] AS varchar) + ')'
												ELSE t3.name END) + '''))'
									from SYS.COLUMNS T2 
									INNER JOIN SYS.TYPES T3 
										ON T2.system_type_id = T3.system_type_id  
										AND T2.user_type_id = T3.user_type_id  
										AND object_id(@cTableName) = T2.OBJECT_ID
									INNER JOIN #temp2 T4 
										ON t4.TABLENAME = @cTableName
										AND T2.NAME = t4.COLNAME2
									cross apply @xmlRecord.nodes('/form/*[upper-case(local-name(.))=sql:variable("@cTableName")]/item/*[upper-case(local-name(.))=upper-case(sql:column("t2.name"))]') Tbl(Col)
									for xml path('')
									),1,1,''
								  ) 
						  + char(13) +
						 'from ' + @cTableName + ' t1 ' + char(13) +
						 'cross apply @xml2.nodes(''/form/'+@cTableName+'/item'') Tbl(Col) '

	select @cUpdateSQL = replace(@cUpdateSQL, '|!|', ',')

	--Prepare update condition
	select @cUpdateCONT = 'where ' + 
						  stuff((select ' and t1.' + t3.name + ' = ' + 'NOVA.funXMLReplaceSpecNRevert(Tbl.Col.value(''' + t3.name + '[1]''' + '|!|''' + 
												(CASE 
													WHEN t4.name IN ('NCHAR','NVARCHAR')	then t4.name + '(' + IIF(t3.max_length = -1,'MAX',CAST(t3.max_length/2 AS VARCHAR)) + ')' 
													WHEN t4.name IN ('CHAR','VARCHAR')		then t4.name + '(' + IIF(t3.max_length = -1,'MAX',CAST(t3.max_length AS VARCHAR)) + ')'
													WHEN t4.name = 'DECIMAL'				then t4.name + '(' + CAST(t3.[precision] AS varchar) + ',' + CAST(t3.[scale] AS varchar) + ')'
													ELSE t4.name 
												 END
												) + '''))'
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
										),1,4,''
									   )

	select @cUpdateCONT = replace(@cUpdateCONT, '', ' and ')
	select @cUpdateCONT = replace(@cUpdateCONT, '|!|', ',')

	IF (@cUpdateSQL is NULL) or (@cUpdateCONT is NULL)
	BEGIN
		SELECT @cRETCODE = @cERRORCODE
		select @cErrorMsg = 'generate script error for table: ' + @cTableName

		INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
		VALUES(@request_no,@cProgramID,@cErrorMsg,@cUSERID,GETDATE())
	
		GOTO EXIT_WINDOW
	END

	select @cSqlStatement = N'declare @xml2 xml;' + CHAR(13) +
							N'SELECT @xml2 = N''' + convert(nvarchar(max), @xmlRecord) + ''';' + CHAR(13) + 
							+ @cUpdateSQL + char(13) + @cUpdateCONT + ';'
end
else
begin
	SELECT @cRETCODE = '0001'
	
	INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
	VALUES(@request_no,@cProgramID,'no primary key in table: ' + @cTableName,@cUSERID,GETDATE())
	
	GOTO EXIT_WINDOW
end

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


