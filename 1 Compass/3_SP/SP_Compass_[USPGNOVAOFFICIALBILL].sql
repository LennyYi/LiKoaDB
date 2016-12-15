IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.USPGNOVAOFFICIALBILL') AND sysstat & 0xf = 4)
	drop procedure dbo.USPGNOVAOFFICIALBILL
GO

SET ANSI_NULLS ON 
SET QUOTED_IDENTIFIER ON  
SET CONCAT_NULL_YIELDS_NULL ON 
SET ANSI_WARNINGS ON 
SET ANSI_PADDING ON
go
CREATE PROCEDURE dbo.USPGNOVAOFFICIALBILL
(@request_no		VARCHAR(30))
AS
BEGIN

/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	USPGNOVAOFFICIALBILL.SQL - Prepare TMEMPTPOL table for TMEMPTPOL_NOVA letter
        
        PROCESSING DETAILS:
        Prepare TMEMPTPOL table for TMEMPTPOL_NOVA letter
			
	AUTHOR      :     Celia Huang
	DATE	    :     11/25/2014
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        5.0	  NOVA		Celia				11/25/2014	Initial Version
        	  NOVA-279	Celia				05/21/2015	update numadd, benadd
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
DECLARE @cRETCODE   CHAR(4)
DECLARE @cRETMESSAGE NVARCHAR(MAX)
DECLARE @sUserid    CHAR(8)

SELECT @L_ISSDATE = CONVERT(CHAR(10), GETDATE(), 120)

SELECT @cACTIVE = 'A'
SELECT @cProgramID = 'USPGNOVAOFFICIALBILL'




--HINSON BEGIN
--BEGIN TRAN

--BEGIN TRY


SET ANSI_NULLS ON 
SET QUOTED_IDENTIFIER ON  
SET CONCAT_NULL_YIELDS_NULL ON 
SET ANSI_WARNINGS ON 
SET ANSI_PADDING ON
--HINSON END

SELECT @XML = NovaXML FROM T_Nova_TXMLConvert where request_no = @request_no
SELECT  @cCLNTCODE = T.N.value('CLNTCODE[1]','varchar(20)') from  @XML.nodes('/form/TCLIENT/item') T(N) 
SELECT  @cPOLNO = T.N.value('POLNO[1]','varchar(10)') from  @XML.nodes('/form/TPOLICY/item') T(N) 

CREATE TABLE DBO.#TEMP
(	RequestID varchar(30)  NULL,
	COMPCODE decimal(4, 0)  NULL,
	CLNTCODE char(5)  NULL,
	BILLNO char(8) NULL,
	BillFromDate datetime  NULL,
	BillToDate datetime  NULL,
	SUBOFFCODE char(3)  NULL,
	POLNO char(10)  NULL,
	PRODCODE char(5)  NULL,
	BENPLNCD char(3)  NULL,
	COVGCODE char(3)  NULL,
	CERTNO char(10)  NULL,
	DEPCODE decimal(2, 0)  NULL,
	MBAGE int  NULL,
	PREMDU decimal(13, 2)  NULL,
	PREMDUAD decimal(13, 2)  NULL,
	PRMLOADAMT decimal(13, 2)  NULL,
	CONTAMTMB decimal(13, 2)  NULL,
	)

INSERT #TEMP
SELECT A.RequestID ,
	A.COMPCODE ,
	A.CLNTCODE ,
	'',
	A.BillFromDate ,
	A.BillToDate ,
	A.SUBOFFCODE ,
	A.POLNO ,
	B.PRODCODE ,
	B.Plancode ,
	A.COVGCODE ,
	A.CERTNO ,
	'1', --A.DEPCODE ,
	A.MBAGE ,
	B.Premium, 
	0,
	0,
	0
FROM TBILLDETAIL_NOVA A, TNOVAprodprem B, TPOLPDT_NOVA C 
WHERE A.POLNO = @cPOLNO AND A.RequestID = @request_no 
--WHERE A.POLNO = 'NOVA000013' AND A.RequestID = 'NBForm_11252014_01' 
AND A.POLNO = C.POLNO AND A.PRODCODE = C.NOVA_PRODCODE
AND A.BENPLNCD = C.NOVA_BENPLNCD AND B.pkgcode = C.PRODCODE
AND B.Plancode = C.BENPLNCD AND A.MBAGE >=B.AgeMin
AND A.MBAGE <= B.AgeMax


--HINSON BEGIN
SELECT @billprdfr = MAX(BillFromDate) FROM #TEMP
EXEC USPGNOVAGENBILLNO @cCLNTCODE, @billprdfr, @BILLNO OUT, @ErrCode OUT

IF @ErrCode <> 0	--If bill number generated failed, not insert billing tables
BEGIN
	SELECT @ErrMsg = 'Bill number generation failed'
	--ROLLBACK TRAN
	GOTO ERROR_HANDLE
END
--HINSON END


--SELECT DISTINCT A.COMPCODE,
--	A.CLNTCODE,
--	@BILLNO,
--	A.SUBOFFCODE,
--	'A',
--	CONVERT(CHAR(10), GETDATE(), 120),
--	'086',
--	NULL,
--	B.SEPMETHOD,
--	B.FMTPREMNT,
--	'N',
--	'O',
--	'N',
--	'A',
--	'NOVASYS',
--	GETDATE(),
--	B.FMTPRTDCOM,
--	NULL,
--	'4',
--	NULL,
--	NULL,
--	NULL,
--	NULL
--FROM TBILLDETAIL_NOVA A, TBILLPLAN B, TPOLPDT C
--WHERE A.POLNO = @cPOLNO AND A.RequestID = @request_no 
----WHERE A.POLNO = 'NOVA000013' AND A.RequestID = 'NBForm_11252014_01' 
--AND C.POLNO =A.POLNO 
--AND C.EFFDATE = (SELECT MAX(D.EFFDATE) FROM TPOLPDT D
--					WHERE C.POLNO = C.POLNO AND C.RCDSTS ='A')
--AND C.BILLPLANCD = B.BILLPLANCD

INSERT TBILDETB 
(COMPCODE,CLNTCODE ,BILLNO,SUBOFFCODE, STATUS ,BISSDATE, CURCCODE ,PAIDDATE,SEPMETHOD ,FMTPREMNT,
	PRMBNDIND, FMTBILLIND, FMTRCNBIND, RCDSTS, RCDUSRID, RCDDTSTMP, FMTPRTDCOM, BINDPOL, BILLLVLIND,
	BILLSEQNO,CHEQUEDATE,RCPTPRINTDATE,RenewFirstInd)
SELECT DISTINCT A.COMPCODE,
	A.CLNTCODE,
	@BILLNO,
	A.SUBOFFCODE,
	'A',
	@L_ISSDATE,
	'086',
	NULL,
	B.SEPMETHOD,
	B.FMTPREMNT,
	'N',
	'O',
	'N',
	'A',
	'NOVASYS',
	GETDATE(),
	B.FMTPRTDCOM,
	NULL,
	'4',
	NULL,
	NULL,
	NULL,
	NULL
FROM TBILLDETAIL_NOVA A, TBILLPLAN B, TPOLPDT C
WHERE A.POLNO = @cPOLNO AND A.RequestID = @request_no 
--WHERE A.POLNO = 'NOVA000013' AND A.RequestID = 'NBForm_11252014_01' 
AND C.POLNO =A.POLNO 
AND C.EFFDATE = (SELECT MAX(D.EFFDATE) FROM TPOLPDT D
				 WHERE C.POLNO = D.POLNO AND D.RCDSTS ='A')
AND C.BILLPLANCD = B.BILLPLANCD

INSERT TBILDETM 
(COMPCODE,CLNTCODE,BILLNO,SUBOFFCODE,DEPARTCD,POLNO ,PRODCODE, BENPLNCD, COVGCODE,
CERTNO,DEPCODE, MBAGE , PREMDU , PREMDUAD ,PRMLOADAMT , CONTAMTMB,RCDSTS, RCDUSRID,
RCDDTSTMP ,PRMLOADMOD , PRMLOADADJ,EXPREFD,PRYREXPRFD)
SELECT COMPCODE,
	   CLNTCODE,
	   @BILLNO, --'AAAAAAAA',
	   SUBOFFCODE, 
	   '000', 
	   POLNO,
	   PRODCODE,
	   BENPLNCD,
	   'MEM',
	   CERTNO,
	   '1', --DEPCODE, 
	   MBAGE,
	   PREMDU,
	   PREMDUAD,
	   PRMLOADAMT,
	   CONTAMTMB ,
	   'A',
	   'NOVASYS',
	   GETDATE(),
	   0 ,
	   0 ,
	   0,
	   NULL
FROM #TEMP 


INSERT TBILDETP 
(COMPCODE,CLNTCODE,BILLNO,SUBOFFCODE, DEPARTCD, POLNO,PRODCODE, BILLPRDFR ,BILLPRDTO,BILLTYPE ,ASOBILTYPE, 
FYRENCODE, CURCCODE ,OUTDGBAL , PREMDU,PREMDUAD ,CONTAMTMB,EXPREFD,PREMTAX,STMPDUTY  ,COMMDU , PAIDAMT,
ASODEPBAL,ASOCHRGDU,ASOAMTDU,CLMAMT,CLMNUM,RCDSTS, RCDUSRID, RCDDTSTMP,ASOTOTCHRG, PREMBIND,CALSD , PRYREXPRFD ,ADMINFEE)
SELECT 
A.COMPCODE,
B.CLNTCODE,
@BILLNO,
B.SUBOFFCODE,
'000',
B.POLNO,
B.PRODCODE,
A.BillFromDate,
A.BillToDate,
'D',--BILLTYPE,
NULL, --ASOBILTYPE,
--'F',-- FYRENCODE ,
A.FYRENCODE,-- FYRENCODE ,
'086',--CURCCODE,
0,-- OUTDGBAL
SUM(B.PREMDU),
0,--PREMDUAD 
0,-- CONTAMTMB
0,-- EXPREFD 
0,--PREMTAX,
0,--STMPDUTY 
0,--COMMDU,
0,--PAIDAMT
0,--ASODEPBAL,
0,--ASOCHRGDU
0,--ASOAMTDU
0,-- CLMAMT
0,--CLMNUM 
'A',
'NOVASYS',
 GETDATE(),  
 0,-- ASOTOTCHRG  
 0,--  PREMBIND 
 NULL,-- CALSD 
 0,--PRYREXPRFD  ,
 0-- ADMINFEE
FROM TBILLDETAIL_NOVA A, TBILDETM B 
WHERE A.POLNO = @cPOLNO AND A.RequestID = @request_no  
--WHERE A.POLNO = 'NOVA000022' AND A.RequestID = 'NBForm_11282014_05' 
AND A.COMPCODE = B.COMPCODE 
AND A.CLNTCODE = B.CLNTCODE AND A.CERTNO = B.CERTNO
AND B.BILLNO = @BILLNO
GROUP BY A.COMPCODE, B.CLNTCODE,B.POLNO,B.SUBOFFCODE,B.PRODCODE,A.BillFromDate,A.BillToDate

INSERT TBILDETC 
(COMPCODE,CLNTCODE, BILLNO,SUBOFFCODE,DEPARTCD, POLNO,PRODCODE, BENPLNCD, COVGCODE, BENAMTPRV,BENAMTADD,BENAMTTERM,NUMMEMPRV,
NUMADD,NUMTERM,PREMMODAL,PREMDU, PREMDUAD ,CONTAMTMB ,RCDSTS,RCDUSRID, RCDDTSTMP,PREMMODAL2,BENAMTPRV2, BENAMTADD2,BENAMTTERM2)
SELECT 
A.COMPCODE,
B.CLNTCODE,
@BILLNO,
B.SUBOFFCODE,
'000',
B.POLNO,
B.PRODCODE,
B.BENPLNCD,
B.COVGCODE,
0,
0,--BENAMTADD,
0, 
0,
--0,--NUMADD,  -- NOVA-279
count(distinct a.certno),--NUMADD,-- NOVA-279
0,
0,--PREMMODAL,
SUM(B.PREMDU) ,
0, 
0, 
'A',
'NOVASYS',
GETDATE(),
0,
0,
0,
0
FROM TBILLDETAIL_NOVA A, TBILDETM B 
WHERE A.POLNO = @cPOLNO AND A.RequestID = @request_no  
--WHERE A.POLNO = 'NOVA000013' AND A.RequestID = 'NBForm_11252014_01' 
AND A.COMPCODE = B.COMPCODE 
AND A.CLNTCODE = B.CLNTCODE AND A.CERTNO =B.CERTNO
AND B.BILLNO = @BILLNO
GROUP BY A.COMPCODE, B.CLNTCODE,B.POLNO,B.SUBOFFCODE,B.PRODCODE,B.COVGCODE,B.BENPLNCD

select a.polno, a.suboffcode, a.prodcode,a.covgcode,  A.BENPLNCD,sum(INFLFIA) as BENAMTADD --count(distinct certno) as NUMADD, sum(INFLFIA) as BENAMTADD 
into #tbildetc
from tmemptpol a, #TEMP b, tbildetc c
where a.clntcode = b.clntcode and a.polno =b.polno
and b.clntcode =c.clntcode and b.polno = c.polno 
and c.billno = @BILLNO and a.suboffcode = c.suboffcode  and c.covgcode = a.covgcode and a.INFLFIA is not null
--NOVA-279
and a.benplncd = b.BENPLNCD and a.benplncd = c.BENPLNCD and c.prodcode = a.prodcode and b.prodcode =c.prodcode 
--NOVA-279
group by a.polno, a.suboffcode, a.prodcode,a.covgcode, A.BENPLNCD

--NOVA-279 BEGIN
--select a.polno, a.suboffcode, a.prodcode,a.covgcode,count(distinct a.certno) as NUMADD into #tmemptpol
--from tmemptpol a, #tbildetc b
--where a.polno =b.polno and a.prodcode = b.prodcode  and a.suboffcode =b.suboffcode and a.covgcode = b.covgcode
--group by a.polno, a.suboffcode, a.prodcode,a.covgcode

--update b set b.NUMADD =a.NUMADD from #tmemptpol a, #tbildetc b 
--where a.polno =b.polno and a.prodcode = b.prodcode  and a.suboffcode =b.suboffcode and a.covgcode = b.covgcode
--NOVA-279 BEGIN

update c set --c.NUMADD  = b.NUMADD ,-- NOVA - 279
 c.BENAMTADD = b.BENAMTADD from #tbildetc b, tbildetc c
where b.polno = c.polno and c.billno = @BILLNO and b.suboffcode = c.suboffcode  
and c.covgcode = b.covgcode and b.prodcode = c.prodcode
and b.benplncd = c.benplncd -- NOVA-279

--SELECT * FROM TBILDETc WHERE BILLNO ='AAAAAAAA' AND POLNO = 'NOVA000013'
--SELECT * FROM TBILLPLAN

declare cur_comm cursor for
select	distinct a.compcode, a.clntcode, a.suboffcode,a.polno, a.prodcode,@BILLNO, a.billprdfr, a.billprdto,a.premdu
from	Tbildetp a, #TEMP b
where   a.clntcode = b.clntcode and a.billno = @BILLNO
and a.clntcode = @cCLNTCODE and a.polno = @cPOLNO

open cur_comm

fetch next from cur_comm into @compcode, @cclntcode, @suboffcode,@cpolno, @prodcode,@BILLNO, @billprdfr, @bilprdto,@premdu
while @@fetch_status = 0
begin

--SELECT @compcode, @cclntcode, @suboffcode,@cpolno, @prodcode,@BILLNO,'', '086','','F', @billprdfr, @bilprdto,@premdu,0,'NOVASYS','','S',@dTotFEEAMT, ''
EXEC USPNOVACOMMCALC @compcode, @cclntcode, @suboffcode,@cpolno, @prodcode,@BILLNO,'', '086','','F', @billprdfr, @bilprdto,@premdu,0,'NOVASYS','','S',@dTotFEEAMT OUTPUT, ''

UPDATE TBILDETP SET COMMDU = @dTotFEEAMT
WHERE clntcode = @cCLNTCODE and polno = @cPOLNO AND billno = @BILLNO
AND PRODCODE = @prodcode AND SUBOFFCODE = @suboffcode AND RCDSTS ='A'
select @cbillprdfr = CONVERT(CHAR(10),@billprdfr,112)
select @cbilprdto = CONVERT(CHAR(10),@bilprdto,112)
select @cpremdu = CONVERT(CHAR(16),@premdu)
select @cdTotFEEAMT = CONVERT(CHAR(16),@dTotFEEAMT)

UPDATE TPOLPDTSUB SET BILLTODATE = @bilprdto, BILLTODTNX = @bilprdto
WHERE polno = @cPOLNO 
AND PRODCODE = @prodcode AND SUBOFFCODE = @suboffcode 

UPDATE TMEMPTPOL SET BILLNO = @BILLNO 
WHERE polno = @cPOLNO AND PRODCODE = @prodcode 
  AND SUBOFFCODE = @suboffcode AND isnull(billno,'') in ('',null,'DDDDDDDD')
  AND CHGEFFDATE = @cbillprdfr AND RCDSTS ='A'


UPDATE TRATCHGADJ SET BILLNO = @BILLNO 
WHERE polno = @cPOLNO AND PRODCODE = @prodcode 
  AND SUBOFFCODE = @suboffcode AND isnull(billno,'') in ('',null,'DDDDDDDD')
  AND CHGEFFDT = @cbillprdfr 

--SELECT @cdTotFEEAMT

EXEC USP_GBIS005 @cpolno, @prodcode,@suboffcode,@cbillprdfr,@cbilprdto,'NOVASYS',@RETVALUE OUT, 'B'
EXEC USP_GBIS007 @cpolno,@prodcode,@suboffcode,@cbillprdfr,@L_ISSDATE,@cpremdu,'0','0','0','0','0',@cdTotFEEAMT,'0','0','B','NOVASYS','','B' 

--EXEC USP_UPDATEFHF	@cpolno, @prodcode,@suboffcode,CONVERT(CHAR(10),@billprdfr,112),CONVERT(CHAR(10),@bilprdto,112),CONVERT(CHAR(16),@premdu),'',CONVERT(CHAR(16),@dTotFEEAMT),'BA','NOVASYS','S',@RETVALUE OUTPUT, '0'
EXEC USP_UPDATEFHF	@cpolno, @prodcode,@suboffcode,@cbillprdfr,@cbilprdto,@cpremdu,'0',@cdTotFEEAMT,'BA','NOVASYS','B',@RETVALUE OUTPUT, '0'

fetch next from cur_comm into @compcode, @cclntcode, @suboffcode,@cpolno, @prodcode,@BILLNO, @billprdfr, @bilprdto,@premdu
end
-- C23764 end

close cur_comm
deallocate cur_comm

update TBILLDETAIL_NOVA set billno = @BILLNO where RequestID = @request_no --and isnull(billno,'') in ('',null,'DDDDDDDD')

select @sUserid = min(RCDUSRID)
from tmemptpol 
where polno = @cPOLNO and billno = @BILLNO


--generate bill report
--exec USPNOVABillREPORT '', @request_no, 'NOVASYS', @sUSERID,'O',@cRETCODE OUTPUT, @cRETMESSAGE OUTPUT

SELECT @cRETCODE = '0000'
--HINSON BEGIN
--COMMIT TRAN
--END TRY
--BEGIN CATCH
--	SELECT @ErrCode = error_number()
--	SELECT @ErrMsg = ERROR_MESSAGE()
--	--ROLLBACK TRAN
--	GOTO ERROR_HANDLE
--END CATCH

ERROR_HANDLE:
--HINSON END

IF @ErrCode <> 0
BEGIN
	--SELECT @cRETCODE = '9999'
	
	INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
	VALUES(@request_no,@cProgramID,@ErrMsg,'NOVAPROC',GETDATE())	--HINSON
	
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
go