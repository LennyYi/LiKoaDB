IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.USPGNOVAGENTPOLFINCL') AND sysstat & 0xf = 4)
	drop procedure dbo.USPGNOVAGENTPOLFINCL
GO
SET ANSI_NULLS ON 
SET QUOTED_IDENTIFIER ON  
SET CONCAT_NULL_YIELDS_NULL ON 
SET ANSI_WARNINGS ON 
SET ANSI_PADDING ON
GO
CREATE PROCEDURE dbo.USPGNOVAGENTPOLFINCL
(@request_no		VARCHAR(30))
AS
BEGIN
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	USPGNOVAGENTPOLFINCL.SQL - Prepare TMEMPTPOL table for TMEMPTPOL_NOVA letter
        
        PROCESSING DETAILS:
        Prepare TMEMPTPOL table for TMEMPTPOL_NOVA letter
			
	AUTHOR      :     Issca Zhu
	DATE	    :     11/06/2014
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        5.0	  NOVA		Issca Zhu				11/06/2014	Initial Version
********************************************************************/
/*error handling variable section */
DECLARE @ErrFrom	CHAR(20)
DECLARE @ErrMsg		CHAR(65)
DECLARE @ErrData	CHAR(45)
DECLARE @ErrCode        INT
DECLARE @StoreProcInd   CHAR(1)
DECLARE	@cMSGID		CHAR(5)
/*DECLARE VARIABLES AND CONSTANTS*/
DECLARE	@cACTIVE	CHAR(1)
DECLARE	@cDELETED	CHAR(1)
DECLARE	@cYES		CHAR(1)
DECLARE	@cNO		CHAR(1)
DECLARE @XML XML 
DECLARE	@CLNTCODE	CHAR(1)
DECLARE	@cCLNTCODE	CHAR(5)
DECLARE	@cPOLNO		CHAR(10)
DECLARE	@cCERTNO	VARCHAR(10)
DECLARE @cProgramID VARCHAR(60)
DECLARE	@dtEFFDATE	DATETIME
DECLARE	@dtRCDCRTDT	DATETIME
DECLARE	@cMEM		CHAR(3)
DECLARE	@cSUBOFFCODE CHAR(3)
DECLARE	@cCNTYCODE	CHAR(3)
DECLARE	@cPRODCODE	CHAR(5)
DECLARE	@cRETNCODE	CHAR(4)

DECLARE	@cSTARDATE CHAR(10)
DECLARE	@cENDDATE  CHAR(10)

SELECT @cACTIVE = 'A'
SELECT @cMEM = 'MEM'

SET ANSI_NULLS ON 
SET QUOTED_IDENTIFIER ON  
SET CONCAT_NULL_YIELDS_NULL ON 
SET ANSI_WARNINGS ON 
SET ANSI_PADDING ON

SELECT @XML = NovaXML FROM T_Nova_TXMLConvert where request_no = @request_no
SELECT  @cCLNTCODE = T.N.value('CLNTCODE[1]','varchar(20)') from  @XML.nodes('/form/TCLIENT/item') T(N) 
SELECT  @cPOLNO = T.N.value('POLNO[1]','varchar(10)') from  @XML.nodes('/form/TPOLICY/item') T(N) 
SELECT  @dtEFFDATE = T.N.value('INIEFFDT[1]','datetime') from  @XML.nodes('/form/TPOLICY/item') T(N) 
SELECT  @dtRCDCRTDT = T.N.value('RCDCRTDT[1]','datetime') from  @XML.nodes('/form/TPOLICY/item') T(N) 

declare CUR_GENPOLFINCL cursor for
SELECT	T1.POLNO,T1.PRODCODE,T3.SUBOFFCODE
FROM	TPOLPDT T1,
		TPRODUCT T2,
		TCLNTSUB T3
WHERE	T3.CLNTCODE	= @cCLNTCODE 
AND		T1.POLNO	= @cPOLNO
AND		T1.PRODCODE = T2.PRODCODE
AND		T2.PRODTYPE <>'P'
AND		T2.RCDSTS = @cACTIVE

open CUR_GENPOLFINCL

FETCH NEXT FROM CUR_GENPOLFINCL INTO @cPOLNO,@cPRODCODE,@cSUBOFFCODE
WHILE (@@FETCH_STATUS = 0)
BEGIN

IF @dtEFFDATE<@dtRCDCRTDT
BEGIN
	SELECT @cSTARDATE = CONVERT(CHAR(10),@dtEFFDATE,120)
	SELECT @cENDDATE = CONVERT(CHAR(10),@dtRCDCRTDT,120)
END
ELSE 
BEGIN
	SELECT @cSTARDATE = CONVERT(CHAR(10),@dtRCDCRTDT,120)
	SELECT @cENDDATE = CONVERT(CHAR(10),@dtEFFDATE,120)
END


EXEC USP_GBIS005 @cPOLNO,@cPRODCODE,@cSUBOFFCODE,@cSTARDATE,@cENDDATE,'NOVAPROC', @cRETNCODE OUTPUT,'S'

SELECT @ErrCode = @@error
IF @ErrCode <> 0
BEGIN
	--SELECT @cRETCODE = '9999'
	
	INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
	VALUES(@request_no,@cProgramID,'insert temp table TPOLFINCL error','NOVAPROC',GETDATE())
	
	GOTO EXIT_WINDOW
END	


FETCH NEXT FROM CUR_GENPOLFINCL INTO @cPOLNO,@cPRODCODE,@cSUBOFFCODE
END

CLOSE CUR_GENPOLFINCL 
DEALLOCATE CUR_GENPOLFINCL


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