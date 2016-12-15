IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = object_id('dbo.UspGNOVASbmSD') and sysstat & 0xf = 4)
	DROP PROCEDURE dbo.UspGNOVASbmSD
GO

CREATE PROCEDURE dbo.UspGNOVASbmSD
( 	
	@cTRANDATE CHAR(10), 
	@request_no VARCHAR(30),
	@staff_code VARCHAR(10),
	@cUSERID CHAR(8),
	@cCALLTYPE CHAR(1), -- O - Online, B -- Batch
	@cRETCODE CHAR(4) OUTPUT,
	@cRETMESSAGE NVARCHAR(MAX) OUTPUT
)
AS
/*******************************************************************
	AIA CONFIDENTIAL MARCH 2000

	COMPASS 2000 USER STORED PROCEDURE

	STORED PROCEDURE USED FOR Submit stampt duty - AU
	
	AUTHOR		:	Hinson Liang
	DATE		:	01/15/2015
	
REVISION LOG:
PDCF		PROGRAMMER	DATE		CTRL No.	PURPOSE
------------------------------------------------------------------------------------------
			Hinson.L	02/05/2015				Initial
*********************************************************************/

SET NOCOUNT ON

DECLARE @dBILLPRDFR DATETIME
DECLARE @cPOLNO CHAR(10)
DECLARE @dSubmitDate DATETIME
DECLARE @cPath VARCHAR(1000)
DECLARE @nMinHDRINDEX DECIMAL(12,0)

declare @sql nvarchar(2000) 
declare @cNOVADB varchar(20)


SELECT @cNOVADB = RTRIM(PARMVALUE) FROM TSYSPARMH WHERE PARMDESC = 'NOVADB'

--Setup the file path
SELECT @sql = 'EXEC <NOVA_DB>..NOVAUspGetUploadPath @cPath OUTPUT'
SELECT @sql = REPLACE(@sql,'<NOVA_DB>',@cNOVADB)
exec sp_executesql @sql, N'@cPath VARCHAR(1000) OUTPUT',@cPath OUTPUT 

UPDATE TNOVA_SDRequest SET FILEPATH = @cPath + FILEPATH WHERE NOVAREQNO = @request_no

--The header name field from NOVA is "index,headerName". Need to split it to fields HDRINDEX and HDRNAME
DELETE TNOVA_SDHdrMap WHERE NOVAREQNO = @request_no AND ISNULL(RTRIM(NOVAHDRNAME),'') = ''
UPDATE TNOVA_SDHdrMap 
SET HDRINDEX = LEFT(NOVAHDRNAME,CHARINDEX(',',NOVAHDRNAME)-1)
	,HDRNAME = RIGHT(NOVAHDRNAME,LEN(NOVAHDRNAME)-CHARINDEX(',',NOVAHDRNAME))
WHERE NOVAREQNO = @request_no

--Let header index start from 0
--20150217 BEGIN
--SELECT @nMinHDRINDEX = MIN(HDRINDEX) FROM TNOVA_SDHdrMap WHERE NOVAREQNO = @request_no
--UPDATE TNOVA_SDHdrMap SET HDRINDEX = HDRINDEX - @nMinHDRINDEX WHERE NOVAREQNO = @request_no
UPDATE TNOVA_SDHdrMap SET HDRINDEX = HDRINDEX - 1 WHERE NOVAREQNO = @request_no
--20150217 END

SELECT @cPOLNO = POLNO, @dBILLPRDFR = BILLPRDFR,@dSubmitDate = SubmitDATE FROM TNOVA_SDRequest WHERE NOVAREQNO = @request_no

--Insert job
INSERT TJOBSBMH
(SBMTIM,USERID,LANGCODE,JOBDESC,BATTYPE,CLASSTYPE,PGMNAME,PARMLIST)
VALUES(@dSubmitDate,@staff_code,'850','Stamp Duty Upload (Nova)','A','X','GNOVAUplSD','@' + @request_no + '@')

--Wait job completed (scan every 15 seconds)
WHILE EXISTS(SELECT 1 FROM TJOBSBMH WHERE SBMTIM = @dSubmitDate)
BEGIN
	WAITFOR DELAY '00:00:15'
END

--Return the calculated stamp duty result to NOVA
SELECT @sql = 'DELETE <NOVA_DB>..teflow_6_5 WHERE request_no = @request_no'
SELECT @sql = REPLACE(@sql,'<NOVA_DB>',@cNOVADB)

exec sp_executesql @sql, N'@request_no varchar(30)',@request_no 

SELECT @sql = '
INSERT <NOVA_DB>..teflow_6_5
(
request_no
,field_5_1	--Product Code
,field_5_2	--Product Short Name
,field_5_3	--State
,field_5_4	--Apportion
,field_5_5	--SD
,field_5_6	--SD Basis
,field_5_7	--NetOff
,field_5_8	--Paid Prem Input
,field_5_9	--Annualised Growth Prem 
,field_5_10	--Paid SD
,field_5_11	--First/Renewallnd
)
SELECT
NOVAREQNO
,PRODCODE
,PRODSHORT
,STATE
,CONVERT(VARCHAR(20),CONVERT(DECIMAL(5,2),ISNULL(ApportionPCT,0) * 100)) + ''%''
,CONVERT(VARCHAR(20),CONVERT(DECIMAL(5,2),ISNULL(StmpDutyPCT,0) * 100)) + ''%''
,CALCBASIS
,CONVERT(VARCHAR(20),CONVERT(DECIMAL(5,2),ISNULL(NETOFFPCT,0) * 100)) + ''%''
,CONVERT(VARCHAR(30), CONVERT(MONEY,PREMPAID),1)
,CONVERT(VARCHAR(30), CONVERT(MONEY,PREMANNGROW),1)
,CONVERT(VARCHAR(30), CONVERT(MONEY,STMPDUTYPAID),1)
,FYRENCODE
FROM TNOVA_SDPremSum WHERE NOVAREQNO = @request_no'

SELECT @sql = REPLACE(@sql,'<NOVA_DB>',@cNOVADB)
exec sp_executesql @sql, N'@request_no varchar(30)',@request_no 


RETURN


