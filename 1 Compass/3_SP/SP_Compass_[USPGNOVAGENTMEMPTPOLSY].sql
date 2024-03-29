IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.USPGNOVAGENTMEMPTPOLSY') AND sysstat & 0xf = 4)
	drop procedure dbo.USPGNOVAGENTMEMPTPOLSY
GO

SET ANSI_NULLS ON 
SET QUOTED_IDENTIFIER ON  
SET CONCAT_NULL_YIELDS_NULL ON 
SET ANSI_WARNINGS ON 
SET ANSI_PADDING ON
GO
CREATE PROCEDURE dbo.USPGNOVAGENTMEMPTPOLSY
(@request_no		VARCHAR(30))
AS
BEGIN
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	USPGNOVAGENTMEMPTPOL.SQL - Prepare TMEMPTPOL table for TMEMPTPOL_NOVA letter
        
        PROCESSING DETAILS:
        Prepare TMEMPTPOL table for JS SY package product
			
	AUTHOR      :     Issca Zhu
	DATE	    :     11/06/2014
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        5.1	  NOVA		Celia Huang				03/24/2015	Initial Version 
		5.2   NOVA      Celia Huang				03/26/2015	Change JS SY
		5.3	  NOVA		Issac Zhu				05/22/2015	Change Benefit Max to Benefit Amount
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
DECLARE @cProgramID VARCHAR(60)

SELECT @cACTIVE = 'A'


SELECT @XML = NovaXML FROM T_Nova_TXMLConvert where request_no = @request_no
SELECT  @cCLNTCODE = T.N.value('CLNTCODE[1]','varchar(20)') from  @XML.nodes('/form/TCLIENT/item') T(N) 
SELECT  @cPOLNO = T.N.value('POLNO[1]','varchar(10)') from  @XML.nodes('/form/TPOLICY/item') T(N) 

UPDATE	T1
SET		T1.PRODCODE =  T2.PRODCODE,
		T1.BENPLNCD = T2.BENPLNCD
FROM	TMEMPTPOL T1,
		TPOLPDT_NOVA T2
WHERE	T1.PRODCODE = T2.NOVA_PRODCODE
AND		T1.BENPLNCD = T2.NOVA_BENPLNCD
AND		T1.CLNTCODE	= @cCLNTCODE
AND		T1.POLNO	= @cPOLNO
AND		T2.POLNO	= @cPOLNO


SELECT * INTO #TMEMPTPOL_TEMP 
FROM TMEMPTPOL 
WHERE CLNTCODE	= @cCLNTCODE AND POLNO	= @cPOLNO

DELETE FROM TMEMPTPOL WHERE CLNTCODE = @cCLNTCODE AND POLNO	= @cPOLNO

IF EXISTS(SELECT 1 FROM TBENPLNDT T1, TMEMPTPOL T2 WHERE T1.PKGPRDCD = T2.PRODCODE AND T2.CLNTCODE = @cCLNTCODE AND T2.POLNO = @cPOLNO AND T1.RCDSTS='A')
BEGIN
	INSERT	TMEMPTPOL
	SELECT	DISTINCT 
	T4.CLNTCODE,T4.SUBOFFCODE,T4.CERTNO,T4.DEPCODE,T4.POLNO,T2.PRODCODE,T2.BENPLNCD,T4.COVGCODE,T4.CHGEFFDATE,T4.CHGEFFDT,T4.INIEFFDT,T4.PRDSTATUS,
	CASE T3.PRODTYPE 
	--WHEN 'L' THEN T2.BENAMTMAX
	WHEN 'L' THEN T2.BENAMTMB
	ELSE NULL
	END,
	CASE T3.PRODTYPE 
    --WHEN 'L' THEN T2.BENAMTMAX
	WHEN 'L' THEN T2.BENAMTMB
	ELSE NULL
	END,
	CASE T3.PRODTYPE 
	WHEN 'L' THEN T4.NELAMT
	ELSE NULL
	END,
	CASE T3.PRODTYPE 
	WHEN 'L' THEN T4.UWSTATUS
	ELSE NULL
	END,
	CASE T3.PRODTYPE 
	WHEN 'L' THEN T4.UWSTUEFF
	ELSE NULL
	END,
	T4.MEDRATCODE,T4.PRMLOADAMT,T4.PRMLOADPC,T4.PRMLOADEXP,T4.PREMWAIND,T4.RCDSTS,T4.RCDUSRID,T4.RCDDTSTMP,T4.PUWSTATUS,T4.PUWSTUEFF,T4.BILLNO,T4.ORMLOADOVR,
	T4.STATUSRMK,T4.COVAGEMAX,T4.INFLOADAMT,T4.INFLOADPC,T4.PROTMPLOADAMT,T4.INFTMPLOADAMT,T4.PROTMPLOADPC,T4.INFTMPLOADPC,T4.TMPLOADEXP
	FROM	TPOLPDT T1,
			TPOLPDTBEN T2,
			TPRODUCT T3,
			#TMEMPTPOL_TEMP T4,
			TBENPLNDT T5 
	WHERE 	T4.POLNO = T2.POLNO
	AND		T1.EFFDATE = T2.EFFDATE
	AND		T4.POLNO = T4.POLNO
	AND		T4.BENPLNCD = T2.BENPLNCD
	AND		T4.POLNO	= @cPOLNO
	--V5.1 BEGIN
	AND 	t1.prodcode = t2.prodcode 
	--V5.1 END
	AND		T2.PRODCODE	= T3.PRODCODE
	AND		T4.PRODCODE = T5.PKGPRDCD
	AND		T2.PRODCODE = T5.PRODCODE
	AND		T2.BENPLNCD = T5.BENPLNCD
	AND		T2.BENCODE	= T5.BENCODE
	AND		T5.PRIBENIND = 'Y'
	AND		T3.RCDSTS	=	'A'
	AND		T5.RCDSTS	=	'A'
END
ELSE
BEGIN

	INSERT	TMEMPTPOL
	 SELECT	DISTINCT 
	T4.CLNTCODE,T4.SUBOFFCODE,T4.CERTNO,T4.DEPCODE,T4.POLNO,T2.PRODCODE,T2.BENPLNCD,T4.COVGCODE,T4.CHGEFFDATE,T4.CHGEFFDT,T4.INIEFFDT,T4.PRDSTATUS,
	CASE T3.PRODTYPE 
	--WHEN 'L' THEN T2.BENAMTMAX
	WHEN 'L' THEN T2.BENAMTMB
	ELSE NULL
	END,
	CASE T3.PRODTYPE 
	--WHEN 'L' THEN T2.BENAMTMAX
	WHEN 'L' THEN T2.BENAMTMB
	ELSE NULL
	END,
	CASE T3.PRODTYPE 
	WHEN 'L' THEN T4.NELAMT
	ELSE NULL
	END,
	CASE T3.PRODTYPE 
	WHEN 'L' THEN T4.UWSTATUS
	ELSE NULL
	END,
	CASE T3.PRODTYPE 
	WHEN 'L' THEN T4.UWSTUEFF
	ELSE NULL
	END,
	T4.MEDRATCODE,T4.PRMLOADAMT,T4.PRMLOADPC,T4.PRMLOADEXP,T4.PREMWAIND,T4.RCDSTS,T4.RCDUSRID,T4.RCDDTSTMP,T4.PUWSTATUS,T4.PUWSTUEFF,T4.BILLNO,T4.ORMLOADOVR,
	T4.STATUSRMK,T4.COVAGEMAX,T4.INFLOADAMT,T4.INFLOADPC,T4.PROTMPLOADAMT,T4.INFTMPLOADAMT,T4.PROTMPLOADPC,T4.INFTMPLOADPC,T4.TMPLOADEXP
	FROM	TPOLPDT T1,
			TPOLPDTBEN T2,
			TPRODUCT T3,
			#TMEMPTPOL_TEMP T4
	WHERE 	T4.POLNO = T2.POLNO
	AND		T1.EFFDATE = T2.EFFDATE
	AND		T4.POLNO = T4.POLNO
	AND		T4.BENPLNCD = T2.BENPLNCD
	AND		T4.POLNO	= @cPOLNO
	AND		T2.PRODCODE	= T3.PRODCODE
	--V5.1 BEGIN
	--AND 	t1.prodcode = t2.prodcode  -- V5.2 comment
	AND     t1.prodcode = t4.prodcode
	--V5.1 END
	AND		T2.BENCODE	= (SELECT MIN(T5.BENCODE) FROM TPOLPDTBEN T5 
									WHERE T5.POLNO=@cPOLNO
									AND T5.PRODCODE = T2.PRODCODE 
									AND T5.BENPLNCD=T2.BENPLNCD 
									AND T5.EFFDATE=T2.EFFDATE 
									AND T5.RCDSTS=	'A')
	AND		T3.RCDSTS	=	'A'

END

SELECT @ErrCode = @@error
IF @ErrCode <> 0
BEGIN
	--SELECT @cRETCODE = '9999'
	
	INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
	VALUES(@request_no,@cProgramID,'insert temp table TMEMPTPOL error','NOVAPROC',GETDATE())
	
	GOTO EXIT_WINDOW
END	



INSERT TIUWTRN1
(CLNTCODE,SUBOFFCODE,POLNO,CERTNO,DEPCODE,TRANSCODE,CHGEFFDT,PRODCODE,USEDIND,NELCHKIND,RCDSTS,RCDUSRID,RCDDTSTMP,CHECKIND,AALIND,HIVIND,NELIND,UWCASENO,SHARENELIND,SHARETYPE,SHAREEFFIND)
SELECT  T1.CLNTCODE, T1.SUBOFFCODE, T1.POLNO, T1.CERTNO, T1.DEPCODE, 'C',T1.CHGEFFDATE,T1.PRODCODE,'N','Y','A',T1.RCDUSRID,T1.RCDDTSTMP,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
FROM	TMEMPTPOL T1,
		TPRODUCT T2
WHERE	T1.CLNTCODE	= @cCLNTCODE	
AND		T1.POLNO	= @cPOLNO
AND		T1.PRODCODE	= T2.PRODCODE
AND		T2.PRODTYPE	 = 'L'


SELECT @ErrCode = @@error
IF @ErrCode <> 0
BEGIN
	--SELECT @cRETCODE = '9999'
	
	INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
	VALUES(@request_no,@cProgramID,'insert temp table TIUWTRN1 error','NOVAPROC',GETDATE())
	
	GOTO EXIT_WINDOW
END	

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