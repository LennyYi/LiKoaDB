IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.USPNOVABillREPORT') AND sysstat & 0xf = 4)
	drop procedure dbo.USPNOVABillREPORT
GO

CREATE PROCEDURE dbo.USPNOVABillREPORT (
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
	COMPASS 2000 USER STORED PROCEDURE

	USPNOVABillREPORT.SQL - Generate bill report
        
        PROCESSING DETAILS:
 
			
	AUTHOR      :     Celia Huang
	DATE	    :     12/04/2014
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        5.0	  NOVA		Celia				12/04/2014	Initial Version
********************************************************************/

SET NOCOUNT ON
DECLARE @cYES	CHAR(1),
	@cNO	CHAR(1),           
	@iErrCode	INT,          
	@cErrFrom	CHAR(20),
	@cErrMsg	CHAR(65),
	@cErrData	CHAR(45),
	@cRTNFAIL 	CHAR(4),
	@cRTNSUCC 	CHAR(4),
	@cACTIVE	char(10),
	@cPRDUCODE	char(10) 
	DECLARE	@CLNTCODE	CHAR(1)
	DECLARE	@cCLNTCODE	CHAR(5)
	DECLARE	@cPOLNO		CHAR(10)
	DECLARE @cProgramID VARCHAR(60)
	DECLARE @BILLNO		CHAR(8)
	DECLARE @compcode   DEC(4,0) 
	DECLARE @suboffcode CHAR(3)
	DECLARE @prodcode   CHAR(5)
	DECLARE @billprdfr  DATETIME 
	DECLARE @bilprdto   DATETIME
	DECLARE @premdu     DEC(13,2)
	DECLARE @dTotFEEAMT DEC(13,2)
	DECLARE @RETVALUE   CHAR(6)
	DECLARE @cbillprdfr CHAR(10)
	DECLARE @cbilprdto  CHAR(10)
	DECLARE @cpremdu    CHAR(16)
	DECLARE @cdTotFEEAMT CHAR(16)
	DECLARE @L_ISSDATE CHAR(10)
	DECLARE @cBILLNO  char(8)
	DECLARE @dcompcode decimal(4,0)
	DECLARE @csuboffcode CHAR(3)

	SELECT @cACTIVE ='A'

SELECT  @dcompcode = COMPCODE, @cBILLNO =  billno, @cCLNTCODE = clntcode,@cPOLNO = polno  from TBILLDETAIL_NOVA where RequestID = @request_no


declare cur_suboffice cursor for
select	DISTINCT suboffcode
from	Tbildetp 
where 	clntcode = @cCLNTCODE
and		polno	 = @cPOLNO
and		billno	 = @cBILLNO
and		rcdsts	 = @cACTIVE

open cur_suboffice

fetch next from cur_suboffice into @csuboffcode
while @@fetch_status = 0
begin

  insert tjobsbmh 
  (SBMTIM ,USERID ,LANGCODE, JOBDESC,BATTYPE, CLASSTYPE, PGMNAME, PARMLIST)
  values
  (getdate(), @cUSERID,  '850','PRINT BILL DETAIL', NULL, NULL,'GBIB008O', '01R'+substring(CONVERT(char(5),@dcompcode + 10000),2,5)+@cCLNTCODE+@cBILLNO+@csuboffcode+'000N')


	fetch next from cur_suboffice into  @csuboffcode
end


close cur_suboffice
deallocate cur_suboffice


GOTO EXIT_WINDOW

ErrorHandling:
IF  @cRETCODE = @cRTNFAIL   --(if the error is NOT returned from sub store proc, write TERLOGTRN)
BEGIN
	INSERT terlogtrn (timestmp, userid, pgmid, contind, errmsg, errdata)
	VALUES (GETDATE(),@cUSERID, @cErrFrom, @cNO, @cErrMsg, @cErrData) 
END

EXIT_WINDOW:



IF @cCALLTYPE = 'O'
BEGIN
	SELECT @cRETCODE
END
ELSE
BEGIN
	RAISERROR (@cRetCode, 1, 2)
END

SET NOCOUNT OFF
RETURN