
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = object_id('dbo.NOVAUspLoadNEL') and sysstat & 0xf = 4)
	DROP PROCEDURE dbo.NOVAUspLoadNEL
GO

CREATE PROCEDURE dbo.NOVAUspLoadNEL
( 	
	@rpt_request_no	varchar(30),
	@ReportType	char(10),
	@SectionID DECIMAL(20,0),
	@comp_code	char(7),
	@ver_no		char(1)	--'0021199' AND ver_no = 'Q'
)
AS

/*
DECLARE @rpt_request_no	varchar(30)
DECLARE @comp_code	char(7)
DECLARE @ver_no		char(1)
DECLARE @ReportType	char(10),	@SectionID DECIMAL(20,0)
SELECT @comp_code = '0021199'
SELECT @ver_no = 'Q'
SELECT @ReportType = 'PS_BS',@SectionID = '8023000000'

SELECT @comp_code = '0000497'
SELECT @ver_no = 'V'
SELECT @ReportType = 'PS_BS_NEL',@SectionID = '1'
*/

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

DECLARE @W_TYPE_HEADER INT
DECLARE @W_TYPE_ITEMTITLE1 INT
DECLARE @W_TYPE_ITEMTITLE2 INT
DECLARE @W_TYPE_ITEMVALUE1 INT
DECLARE @W_TYPE_ITEMVALUE2 INT

SELECT @W_TYPE_HEADER = 1		--Header
SELECT @W_TYPE_ITEMTITLE1 = 11	--Item title - level 1
SELECT @W_TYPE_ITEMTITLE2 = 12	--Item title - level 2
SELECT @W_TYPE_ITEMVALUE1 = 51	--level 1 title's value
SELECT @W_TYPE_ITEMVALUE2 = 52	--level 2 title's value

DECLARE @ItemType_Title	INT
DECLARE @ItemType_Value	INT

declare @sql nvarchar(max) 
declare @cGMPSDB varchar(20)
SELECT @cGMPSDB = RTRIM(param_value) FROM teflow_param_config WHERE param_code = 'GMPSDB'

CREATE TABLE #ReportTable(
	RowIdx	DECIMAL(20,0) NOT NULL,
	ColIdx	INT NOT NULL,
	Class		CHAR(10) NULL,
	ItemValue	NVARCHAR(500) NULL,
	ItemType	INT NOT NULL,	
	RemarkCode	VARCHAR(100) NULL,
	Editable	CHAR(01)	NULL,
	Mergeable	CHAR(01)	NULL
)




DECLARE @RowIdx DECIMAL(20,0)
DECLARE @ColIdx INT
DECLARE @DataSQLMain NVARCHAR(MAX)
DECLARE @DataSQL_Header NVARCHAR(200)
DECLARE @DataSQL_Item_Crt	NVARCHAR(1000)
DECLARE @ItemContent	NVARCHAR(1000)
DECLARE @ItemContent_Value NVARCHAR(500)
DECLARE @ItemContent_Class	VARCHAR(20)
DECLARE @ItemName	NVARCHAR(1000)
DECLARE @ItemName_Value	NVARCHAR(200)
DECLARE @ItemName_Class VARCHAR(20)

DECLARE @TitleColIdx INT
DECLARE @ItemContent_ValueColIdx INT

--Prepare item
DECLARE CUR_ItemValue CURSOR FOR	
	SELECT A.TitleColIdx,A.ValueColIdx,A.ItemID,ISNULL(A.ItemName_ENG,''),A.DataSQLMain,A.DataSQL_Header,A.DataSQL_Item_Crt,A.TitleClass,A.ValueClass,A.Value_ENG,@W_TYPE_ITEMTITLE1,@W_TYPE_ITEMVALUE1 FROM TNBBSMap A
	WHERE A.ReportType = @ReportType AND A.ParentID = @SectionID
	AND ISNULL(A.DataSQLMain,'') <> ''
	AND (TitleColIdx + ValueColIdx)<>0
	ORDER BY ItemID,TitleColIdx,ValueColIdx

OPEN CUR_ItemValue
FETCH NEXT FROM CUR_ItemValue INTO @TitleColIdx,@ItemContent_ValueColIdx,@RowIdx,@ItemName,@DataSQLMain,@DataSQL_Header,@DataSQL_Item_Crt,@ItemName_Class,@ItemContent_Class,@ItemContent,@ItemType_Title,@ItemType_Value


WHILE @@fetch_status=0
BEGIN
	SELECT @DataSQLMain = REPLACE(@DataSQLMain,'<GMPSDB>',@cGMPSDB)
	IF ISNULL(RTRIM(@DataSQL_Item_Crt),'') = ''
	BEGIN
		SELECT @DataSQL_Item_Crt = '1=1'
	END
	
	SELECT @ItemContent_Value = NULL
	SELECT @ItemName_Value = NULL

	SELECT @sql = 'SELECT @ItemName_Value = ' + @ItemName + ', @ItemContent_Value = ' + @ItemContent + ' FROM ' + @DataSQLMain + ' AND ' + @DataSQL_Item_Crt
	--SELECT @sql
	--SELECT 'Title',@RowIdx,@sql
	exec sp_executesql @sql, N'@comp_code char(7),@ver_no char(1),@ItemName_Value NVARCHAR(200) OUTPUT, @ItemContent_Value NVARCHAR(500) OUTPUT',@comp_code,@ver_no,@ItemName_Value OUTPUT,@ItemContent_Value OUTPUT

	IF @ItemName_Value IS NOT NULL
	BEGIN
		--Title
		INSERT #ReportTable(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
		VALUES(@RowIdx,@TitleColIdx,@ItemName_Class,@ItemName_Value,@ItemType_Title,NULL,'N','N')

		--Value
		INSERT #ReportTable(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
		VALUES(@RowIdx,@TitleColIdx+@ItemContent_ValueColIdx,@ItemContent_Class,@ItemContent_Value,@ItemType_Value,NULL,'N','N')
	END
	
	FETCH NEXT FROM CUR_ItemValue INTO @TitleColIdx,@ItemContent_ValueColIdx,@RowIdx,@ItemName,@DataSQLMain,@DataSQL_Header,@DataSQL_Item_Crt,@ItemName_Class,@ItemContent_Class,@ItemContent,@ItemType_Title,@ItemType_Value
END

CLOSE CUR_ItemValue
DEALLOCATE CUR_ItemValue

--Supplement the missing column
SELECT RowIdx,ColIdx,ItemValue,Class,ItemType,RemarkCode,Editable,Mergeable,@rpt_request_no FROM #ReportTable ORDER BY RowIdx,ColIdx

--SELECT * FROM #ReportTable WHERE RowIdx BETWEEN 8010020010 AND 8010020025 ORDER BY ColIdx,RowIdx

DROP TABLE #ReportTable
