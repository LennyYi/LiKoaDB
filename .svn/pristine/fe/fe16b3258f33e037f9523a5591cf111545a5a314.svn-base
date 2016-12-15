IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = object_id('dbo.NOVAUspSDLoadFieldLst') and sysstat & 0xf = 4)
	DROP PROCEDURE dbo.NOVAUspSDLoadFieldLst
GO

CREATE PROCEDURE dbo.NOVAUspSDLoadFieldLst
( 	
	@cPOLNO		char(10),
	@cBILLPRDFR	CHAR(10),
	@cNEWMEMDEF	CHAR(01)
)
AS
/*******************************************************************
	AIA CONFIDENTIAL MARCH 2000

	COMPASS 2000 USER STORED PROCEDURE

	STORED PROCEDURE USED FOR Load default header mapping
	
	AUTHOR		:	Hinson Liang
	DATE		:	01/15/2015
	
REVISION LOG:
PDCF		PROGRAMMER	DATE		CTRL No.	PURPOSE
------------------------------------------------------------------------------------------
			Hinson.L	01/15/2015				Initial
*********************************************************************/

SET NOCOUNT ON
/*
DECLARE @cPOLNO		char(10),
		@cBILLPRDFR	CHAR(10)

SELECT	@cPOLNO = '0000MP7009',@cBILLPRDFR = '07/01/2014'
*/

CREATE TABLE #ProdLst(
	PRODCODE	CHAR(05),
	[Status]	VARCHAR(10),
	PRODSHORT	VARCHAR(10),
	TermDate	DATETIME NULL
)

CREATE TABLE #DefMap(
	HDRNAME		varchar(100),
	FIELDNAME	varchar(100),
	PRODCODE	char(5)
)

declare @sql nvarchar(2000) 
declare @cCompassDB varchar(20)
SELECT @cCompassDB = RTRIM(param_value) FROM teflow_param_config WHERE param_code = 'CompassDB'

SELECT @sql = 'INSERT #ProdLst EXEC <Compass_DB>..UspGNOVASDLoadProdLst @cPOLNO,@cBILLPRDFR'
SELECT @sql = REPLACE(@sql,'<Compass_DB>',@cCompassDB)
exec sp_executesql @sql, N'@cPOLNO char(10),@cBILLPRDFR char(10)',@cPOLNO,@cBILLPRDFR


SELECT @sql = 'INSERT #DefMap EXEC <Compass_DB>..UspGNOVASDLoadDefHdrMap @cPOLNO'
SELECT @sql = REPLACE(@sql,'<Compass_DB>',@cCompassDB)
exec sp_executesql @sql, N'@cPOLNO char(10)',@cPOLNO

CREATE TABLE #FieldLst(
	FieldName	varchar(100),
	FieldDesc	varchar(100),
	OptionalInd	char(1),
	PRODCODE	CHAR(05),
	PRODDESC	VARCHAR(100),
	SortOrder	int
)

INSERT #FieldLst
SELECT FieldName,FieldDesc,OptionalInd,PRODCODE,PRODSHORT+'('+[Status]+')',SortOrder FROM TNovaSDFieldLst CROSS JOIN #ProdLst
WHERE SelProdInd = 'Y' AND NEWMEMDEF = @cNEWMEMDEF AND OptionalInd = 'N'
UNION
SELECT FieldName,FieldDesc,OptionalInd,'','',SortOrder FROM TNovaSDFieldLst
WHERE SelProdInd = 'N' AND NEWMEMDEF = @cNEWMEMDEF AND OptionalInd = 'N'

SELECT A.FieldName,A.FieldDesc,A.OptionalInd,A.PRODCODE,A.PRODDESC,A.SortOrder,B.HDRNAME FROM #FieldLst A LEFT JOIN #DefMap B
ON A.FieldName = B.FIELDNAME
AND A.PRODCODE = B.PRODCODE
ORDER BY SortOrder

DROP TABLE #ProdLst
DROP TABLE #DefMap

RETURN


