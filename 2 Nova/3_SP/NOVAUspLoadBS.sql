
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = object_id('dbo.NOVAUspLoadBS') and sysstat & 0xf = 4)
	DROP PROCEDURE dbo.NOVAUspLoadBS
GO

CREATE PROCEDURE dbo.NOVAUspLoadBS
( 	
	@request_no varchar(30),
	@rpt_request_no	varchar(30),
	@ReportType	char(10),
	@SectionID DECIMAL(20,0),
	@comp_code	char(7),
	@ver_no		char(1),	--'0021199' AND ver_no = 'Q'
	@BenGroup	varchar(10),
	@MedSchTemplate	char(01)
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
SELECT @ReportType = 'PS_BS',@SectionID = '1'
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

--Get the default CSS class of header and content (by @ReportID and @SectionID)
DECLARE @W_ContentClass VARCHAR(10)

SELECT @W_ContentClass = 'd1'
	
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

DECLARE @W_PLANCNT	INT
DECLARE @W_HEADERROW INT
DECLARE @W_ITEMTITLECOL_1 INT
DECLARE @W_ITEMTITLECOL_2 INT
DECLARE @W_ITEMTITLECOL_3 INT
SELECT @W_PLANCNT = 10
SELECT @W_HEADERROW = 1
SELECT @W_ITEMTITLECOL_1 = 1
SELECT @W_ITEMTITLECOL_2 = 2
SELECT @W_ITEMTITLECOL_3 = 3

--(1,1) - Plan

DECLARE @i INT
DECLARE @nPlanNo INT
SET @nPlanNo = 1


DECLARE @RowIdx DECIMAL(20,0)
DECLARE @ColIdx INT
DECLARE @DataSQLMain NVARCHAR(MAX)
DECLARE @DataSQL_Header NVARCHAR(200)
DECLARE @DataSQL_Item_Crt	NVARCHAR(1000)
DECLARE @ItemContent	NVARCHAR(1000)
DECLARE @ItemContent_Class	VARCHAR(20)
DECLARE @ItemName_Class VARCHAR(20)
DECLARE @ItemContent_Value NVARCHAR(500)
DECLARE @RemarkCode	NVARCHAR(1000)
DECLARE @ItemName	NVARCHAR(1000)
DECLARE @ItemName_Value	NVARCHAR(200)
DECLARE @RemarkCode_Value	VARCHAR(100)
DECLARE @nActPlanCnt INT
SELECT @nActPlanCnt = NULL

--Get main SQL
SELECT @DataSQLMain = DataSQLMain,@DataSQL_Header=DataSQL_Header FROM TNBBSMap WHERE ReportType = @ReportType AND ItemID = @SectionID AND BenGroup = @BenGroup
SELECT @DataSQLMain = REPLACE(@DataSQLMain,'<GMPSDB>',@cGMPSDB)
--SELECT @DataSQLMain,@DataSQL_Header

--Prepare Plan header
--(1,1)
INSERT #ReportTable(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
VALUES(@W_HEADERROW,@W_ITEMTITLECOL_1,'h0_F01','',@W_TYPE_HEADER,NULL,'N','N')
INSERT #ReportTable(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
VALUES(@W_HEADERROW,@W_ITEMTITLECOL_2,'h0_F02','',@W_TYPE_HEADER,NULL,'N','N')
INSERT #ReportTable(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
VALUES(@W_HEADERROW,@W_ITEMTITLECOL_3,'h0_F03','',@W_TYPE_HEADER,NULL,'N','N')

--(x,1)
SELECT @i = 1
WHILE @i <= @W_PLANCNT
BEGIN
	--Get plan header
	SELECT @ItemContent_Value = NULL
	SELECT @sql = 'SELECT @ItemContent_Value = ' + @DataSQL_Header + ' FROM (SELECT ROW_NUMBER() OVER(ORDER BY ' + @DataSQL_Header + ') AS rowNum, * FROM (SELECT DISTINCT ' + @DataSQL_Header + ' FROM ' + @DataSQLMain + ') AS A) AS t WHERE rowNum=@i'
	--SELECT @sql
	exec sp_executesql @sql, N'@request_no varchar(30),@i int,@comp_code char(7),@ver_no char(1),@MedSchTemplate char(01),@ItemContent_Value VARCHAR(500) OUTPUT',@request_no,@i,@comp_code,@ver_no,@MedSchTemplate,@ItemContent_Value OUTPUT
				
	IF @ItemContent_Value IS NOT NULL
	BEGIN
		INSERT #ReportTable(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
		VALUES(@W_HEADERROW,@i*100+1,'h0_P10','Plan ' + @ItemContent_Value,@W_TYPE_HEADER,NULL,'N','N')
				
		SELECT @nActPlanCnt = @i	--Actual plan counts
		SELECT @i = @i + 1
	END
	ELSE
	BEGIN
		break;
	END
END	

DECLARE @TitleColIdx INT
DECLARE @ItemContent_ValueColIdx INT
DECLARE @Editable CHAR(01)
DECLARE @Mergeable CHAR(01)


--Prepare item
DECLARE CUR_ItemValue CURSOR FOR	
	SELECT A.TitleColIdx,A.ValueColIdx,A.ItemID,ISNULL(A.ItemName_ENG,''),ISNULL(A.RemarkCode,''),A.DataSQLMain,A.DataSQL_Header,A.DataSQL_Item_Crt,A.TitleClass,A.ValueClass,A.Value_ENG,@W_TYPE_ITEMTITLE1,@W_TYPE_ITEMVALUE1,Editable,Mergeable FROM TNBBSMap A
	WHERE A.ReportType = @ReportType AND A.ParentID = @SectionID AND A.BenGroup = @BenGroup
	AND ISNULL(A.DataSQLMain,'') <> ''
	AND (TitleColIdx + ValueColIdx)<>0
	UNION
	SELECT B.TitleColIdx,B.ValueColIdx,B.ItemID,ISNULL(B.ItemName_ENG,''),ISNULL(B.RemarkCode,''),B.DataSQLMain,B.DataSQL_Header,B.DataSQL_Item_Crt,B.TitleClass,B.ValueClass,B.Value_ENG,@W_TYPE_ITEMTITLE2,@W_TYPE_ITEMVALUE2,B.Editable,B.Mergeable FROM TNBBSMap A, TNBBSMap B
	WHERE A.ReportType = @ReportType AND A.ParentID = @SectionID AND A.BenGroup = @BenGroup
	AND B.ReportType = A.ReportType AND B.ParentID = A.ItemID AND B.BenGroup = @BenGroup
	AND ISNULL(B.DataSQLMain,'') <> ''
	AND (B.TitleColIdx + B.ValueColIdx)<>0
	ORDER BY ItemID,TitleColIdx,ValueColIdx

OPEN CUR_ItemValue
FETCH NEXT FROM CUR_ItemValue INTO @TitleColIdx,@ItemContent_ValueColIdx,@RowIdx,@ItemName,@RemarkCode,@DataSQLMain,@DataSQL_Header,@DataSQL_Item_Crt,@ItemName_Class,@ItemContent_Class,@ItemContent,@ItemType_Title,@ItemType_Value,@Editable,@Mergeable


WHILE @@fetch_status=0
BEGIN
	SELECT @DataSQLMain = REPLACE(@DataSQLMain,'<GMPSDB>',@cGMPSDB)
	IF ISNULL(RTRIM(@DataSQL_Item_Crt),'') = ''
	BEGIN
		SELECT @DataSQL_Item_Crt = '1=1'
	END

	--SELECT 'Debug',@TitleColIdx,@ItemContent_ValueColIdx,@RowIdx,@ItemName
	
	IF @nActPlanCnt IS NOT NULL
	BEGIN
		--Prepare item title
		SELECT @ItemContent_Value = NULL
		SELECT @RemarkCode_Value = NULL
		SELECT @ItemName_Value = NULL
		IF @RemarkCode <> ''
		BEGIN
			SELECT @sql = 'SELECT @RemarkCode_Value = max(' + @RemarkCode + '), @ItemName_Value = max(' + @ItemName + ') FROM (SELECT ROW_NUMBER() OVER(ORDER BY ' + @DataSQL_Header + ') AS rowNum, * FROM ' + @DataSQLMain + ') AS t WHERE (' + @DataSQL_Item_Crt + ')'
		END
		ELSE
		BEGIN
			SELECT @sql = 'SELECT @RemarkCode_Value = max(CASE WHEN 1=1 THEN NULL ELSE '''' END), @ItemName_Value = max(' + @ItemName + ') FROM (SELECT ROW_NUMBER() OVER(ORDER BY ' + @DataSQL_Header + ') AS rowNum, * FROM ' + @DataSQLMain + ') AS t WHERE (' + @DataSQL_Item_Crt + ')'
		END
		--SELECT 'Title',@RowIdx,@sql
		exec sp_executesql @sql, N'@request_no varchar(30),@i int,@comp_code char(7),@ver_no char(1),@MedSchTemplate char(01),@RemarkCode_Value VARCHAR(100) OUTPUT,@ItemName_Value NVARCHAR(200) OUTPUT',@request_no,@i,@comp_code,@ver_no,@MedSchTemplate,@RemarkCode_Value OUTPUT,@ItemName_Value OUTPUT
				
		IF @ItemName_Value IS NOT NULL
		BEGIN
			INSERT #ReportTable(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
			VALUES(@RowIdx,@TitleColIdx,@ItemName_Class,@ItemName_Value,@ItemType_Title,@RemarkCode_Value,'N','N')

			--Prepare item value
			SELECT @i = 1
			WHILE @i <= @nActPlanCnt
			BEGIN
				IF @ItemContent<>''
				BEGIN
					SELECT @ItemContent_Value = NULL
					SELECT @sql = 'SELECT @ItemContent_Value = (' + @ItemContent + ') FROM (SELECT ROW_NUMBER() OVER(ORDER BY ' + @DataSQL_Header + ') AS rowNum, * FROM ' + @DataSQLMain + ') AS t WHERE rowNum=@i' + ' AND (' + @DataSQL_Item_Crt + ')'
					--SELECT 'Value',@sql
					exec sp_executesql @sql, N'@request_no varchar(30),@i int,@comp_code char(7),@ver_no char(1),@MedSchTemplate char(01),@ItemContent_Value NVARCHAR(500) OUTPUT',@request_no,@i,@comp_code,@ver_no,@MedSchTemplate,@ItemContent_Value OUTPUT
					
					IF @ItemContent_Value IS NOT NULL
					BEGIN
						INSERT #ReportTable(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
						VALUES(@RowIdx,@i*100+@ItemContent_ValueColIdx,@ItemContent_Class,@ItemContent_Value,@ItemType_Value,NULL,@Editable,@Mergeable)
					END
					ELSE IF @ItemType_Value = @W_TYPE_ITEMVALUE1
					BEGIN
						INSERT #ReportTable(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
						VALUES(@RowIdx,@i*100+@ItemContent_ValueColIdx,@ItemContent_Class,'',@ItemType_Value,NULL,@Editable,@Mergeable)
					END
					ELSE
					BEGIN
						INSERT #ReportTable(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
						VALUES(@RowIdx,@i*100+@ItemContent_ValueColIdx,@ItemContent_Class,'-',@ItemType_Value,NULL,@Editable,@Mergeable)
					END
				END
				SELECT @i = @i + 1
			END
		END
	END
	
	FETCH NEXT FROM CUR_ItemValue INTO @TitleColIdx,@ItemContent_ValueColIdx,@RowIdx,@ItemName,@RemarkCode,@DataSQLMain,@DataSQL_Header,@DataSQL_Item_Crt,@ItemName_Class,@ItemContent_Class,@ItemContent,@ItemType_Title,@ItemType_Value,@Editable,@Mergeable
END

CLOSE CUR_ItemValue
DEALLOCATE CUR_ItemValue

--UPDATE A
--SET A.ItemType = @W_TYPE_ITEMVALUE1
--FROM #ReportTable A, TNBBSMap B
--WHERE B.ReportType = @ReportType AND B.ParentID = @SectionID
--AND A.RowIdx = B.ItemID

--Supplement the blank item title 1
INSERT #ReportTable
(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
SELECT RowIdx,@W_ITEMTITLECOL_1,Class,'',ItemType,'','N','N' FROM #ReportTable A WHERE ItemType BETWEEN 11 AND 19 AND ColIdx = @W_ITEMTITLECOL_2	--11 ~ 19: Item title
AND NOT EXISTS(SELECT 1 FROM #ReportTable B WHERE B.ItemType BETWEEN 11 AND 19 AND B.ColIdx = @W_ITEMTITLECOL_1 AND B.RowIdx = A.RowIdx)

INSERT #ReportTable
(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
SELECT RowIdx,@W_ITEMTITLECOL_1,Class,'',ItemType,'','N','N' FROM #ReportTable A WHERE ItemType BETWEEN 11 AND 19 AND ColIdx = @W_ITEMTITLECOL_3	--11 ~ 19: Item title
AND NOT EXISTS(SELECT 1 FROM #ReportTable B WHERE B.ItemType BETWEEN 11 AND 19 AND B.ColIdx = @W_ITEMTITLECOL_1 AND B.RowIdx = A.RowIdx)

--Supplement the blank item title 2
INSERT #ReportTable
(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
SELECT RowIdx,@W_ITEMTITLECOL_2,Class,'',ItemType,'','N','N' FROM #ReportTable A WHERE ItemType BETWEEN 11 AND 19 AND ColIdx = @W_ITEMTITLECOL_1	--11 ~ 19: Item title
AND NOT EXISTS(SELECT 1 FROM #ReportTable B WHERE B.ItemType BETWEEN 11 AND 19 AND B.ColIdx = @W_ITEMTITLECOL_2 AND B.RowIdx = A.RowIdx)

--Supplement the blank item title 3
INSERT #ReportTable
(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
SELECT RowIdx,@W_ITEMTITLECOL_3,Class,'',ItemType,'','N','N' FROM #ReportTable A WHERE ItemType BETWEEN 11 AND 19 AND ColIdx = @W_ITEMTITLECOL_1	--11 ~ 19: Item title
AND NOT EXISTS(SELECT 1 FROM #ReportTable B WHERE B.ItemType BETWEEN 11 AND 19 AND B.ColIdx = @W_ITEMTITLECOL_3 AND B.RowIdx = A.RowIdx)

INSERT #ReportTable
(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
SELECT DISTINCT B.RowIdx,A.ColIdx,B.Class,'-',@W_TYPE_ITEMVALUE2,NULL,'N','N'
FROM #ReportTable A, #ReportTable B
WHERE A.ItemType = @W_TYPE_ITEMVALUE2
AND B.ItemType = @W_TYPE_ITEMVALUE2
AND NOT EXISTS(SELECT 1 FROM #ReportTable C WHERE C.ItemType = @W_TYPE_ITEMVALUE2 AND C.RowIdx = B.RowIdx AND C.ColIdx = A.ColIdx)
order by B.RowIdx,A.ColIdx

INSERT #ReportTable
(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
SELECT DISTINCT B.RowIdx,A.ColIdx,B.Class,'',@W_TYPE_ITEMVALUE1,NULL,'N','N'
FROM #ReportTable A, #ReportTable B
WHERE A.ItemType = @W_TYPE_ITEMVALUE1
AND B.ItemType = @W_TYPE_ITEMVALUE1
AND NOT EXISTS(SELECT 1 FROM #ReportTable C WHERE C.ItemType = @W_TYPE_ITEMVALUE1 AND C.RowIdx = B.RowIdx AND C.ColIdx = A.ColIdx)
order by B.RowIdx,A.ColIdx

--Supplement the missing column
SELECT RowIdx,ColIdx,ItemValue,Class,ItemType,RemarkCode,Editable,Mergeable,@rpt_request_no FROM #ReportTable ORDER BY RowIdx,ColIdx

--SELECT * FROM #ReportTable WHERE RowIdx BETWEEN 8010020010 AND 8010020025 ORDER BY ColIdx,RowIdx

DROP TABLE #ReportTable

