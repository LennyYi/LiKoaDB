IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.USPNOVACOMMCALC') AND sysstat & 0xf = 4)
	drop procedure dbo.USPNOVACOMMCALC
GO

CREATE PROCEDURE dbo.USPNOVACOMMCALC (
	@nCOMPCODE	DECIMAL(4,0),
	@cCLNTCODE	CHAR(5),
	@cSUBOFFCODE	CHAR(3),
	@cPOLNO		CHAR(10),
	@cPRODCODE	CHAR(5),
	@cBILLNO	CHAR(8),
	@cPYMTNO	CHAR(16),
	@cBILCURCODE	CHAR(3),
	@cSEPMETHOD	CHAR(1),
	@cFYRENCODE	CHAR(1),
	@dtBILPERIODFR	DATETIME,
	@dtBILPERIODTO	DATETIME,
	@dTOTBILLAMT	DECIMAL(13,2),
	@dTEMPCOMMDUE	DECIMAL(13,2),
	@cUSERID	CHAR(8),
	@cRETCODE	CHAR(4),
	@cCALLTYPE	CHAR(1),
	@dTotFEEAMT	DECIMAL(13,2) OUTPUT,
	@cAsOfDate   CHAR(10) = ''
) AS

/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	USPGNOVAOFFICIALBILL.SQL - Prepare TMEMPTPOL table for TMEMPTPOL_NOVA letter
        
        PROCESSING DETAILS:
        Prepare TMEMPTPOL table for TMEMPTPOL_NOVA letter
			
	AUTHOR      :     Celia Huang
	DATE	    :     11/26/2014
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        5.0	  NOVA		Celia				11/26/2014	Initial Version
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
	@cPRDUCODE	char(10), 
	@cPRDUSHRPC	decimal(5,4),
	@cPdtCurccode 	char(3),
	@cRLOBCODE 	decimal(4,0),
	@dtINIEFFDT 	datetime,
	@dtEFFDATE 	datetime,
	@dPOLYAER 	decimal(3,0),
	@cFeeCode 	char(5),
	@cFeeCurccode	char(3),
	@dtTRANDTE	datetime,
	@cFEEBPIND	char(2),
	@dFEEAMT	decimal(13,2),
	@cBILLMODE	char(1),
	@dFEEMDPERD	decimal(6,0), 
	@dtFEEPAIDTE	datetime, 
	@cAGYCODE	char(10),
	@dFeePerc	decimal(5,4),
	@dTotPRDUSHRPC	decimal(5,4),
	@cADMINFEE	char(1),
	@dtFeeEFFDATE 	datetime,
	@cBILLTYPE	char(1),
	@nSelfFeeAmt	decimal(13,2),
	@cFeeStatus	char(1),
	@dTotFeePerc	decimal(5,4),
	@dTotPrduPerc	decimal(5,4),
	@iRvsFact	int,
	@dPremAmt decimal(13,2),
	@cCommcode char(5),
	@dTotCommPerc decimal(5,4),
	@dTotCommAMT decimal(13,2)

SELECT	@cYES = 'Y',
	@cNO = 'N',
	@cACTIVE = 'A',
	@cADMINFEE = 'A'
SELECT  @cErrFrom = 'USPGBIS134FeeCalc',
	@cRTNFAIL = '9999',
	@cRTNSUCC = '0000'
SELECT	@cRETCODE = @cRTNSUCC
SELECT @iRvsFact = 1

IF @cAsOfDate = ''
	select @dtTRANDTE = convert(char(10),getdate(),120)
ELSE 
    select @dtTRANDTE = @cAsOfDate  

select @cBILLTYPE = billtype, 
	   @nSelfFeeAmt = ADMINFEE,
	   @dPremAmt=PREMDU+PREMDUAD-PREMBIND 
from tbildetp
	where	billno = @cBILLNO
	and 	compcode = @nCOMPCODE
	and	clntcode = @cCLNTCODE
	and 	suboffcode = @cSUBOFFCODE
	and 	polno = @cPOLNO
	and 	prodcode = @cPRODCODE
	and	RCDSTS = @cACTIVE

if isnull(@dtBILPERIODFR,'1900-01-01') = '1900-01-01'
begin
	select @dtBILPERIODFR = BILLPRDFR
	from	tbildetp
	where	billno = @cBILLNO
	and 	compcode = @nCOMPCODE
	and	clntcode = @cCLNTCODE
	and 	suboffcode = @cSUBOFFCODE
	and 	polno = @cPOLNO
	and 	prodcode = @cPRODCODE
	and	RCDSTS = @cACTIVE
end

select @dFEEMDPERD = datepart(yyyy,@dtBILPERIODFR) *100 + datepart(mm,@dtBILPERIODFR)


SELECT @dPOLYAER = POLYEAR
FROM TPOLYEAR (NOLOCK)
WHERE POLNO = @cPOLNO
AND   (@dtBILPERIODFR
       BETWEEN POLDTFR AND POLDTTO)
AND   RCDSTS = @cACTIVE

select @cPdtCurccode = curccode, 
	@cRLOBCODE = rlobcode, 
	@dtINIEFFDT = INIEFFDT, 
	@dtEFFDATE = effdate,
	@cBILLMODE = BILLMODE,
	@cCommcode = commcode
from tpolpdt d1
where	d1.polno = @cPOLNO
and	d1.prodcode = @cPRODCODE
and	d1.rcdsts = @cACTIVE
and	d1.CHGEFFDT = (select max(CHGEFFDT) from tpolpdt d2
	where	d2.rcdsts = @cACTIVE
	and	d2.polno = @cPOLNO
	and	d2.prodcode = @cPRODCODE
	and	d2.chgeffdt <= @dtBILPERIODFR
	)
and	d1.effdate = (select max(effdate) from tpolpdt d3
	where	d3.rcdsts = @cACTIVE
	and	d3.polno = @cPOLNO
	and	d3.prodcode = @cPRODCODE
	and	d3.chgeffdt = d1.CHGEFFDT
	)

--SELECT @cCommcode

select @dTotCommPerc = isnull(s.COMMPERC,0)
from 	 tcomscale s
where 	s.commcode = @cCommcode 
  and   s.PREMMAX= (select min(b.PREMMAX) 
					from tcomscale b 
					where b.PREMMAX >=@dTOTBILLAMT and b.commcode = @cCommcode
					and 	@dPOLYAER > s.YRFR 
					and 	@dPOLYAER <= s.YRTO
					and 	s.RCDSTS = @cACTIVE)



--- @cCommcode, @dTotCommPerc
if ISNULL(@cPYMTNO, '') = ''
begin
	select @cFEEBPIND = 'B1'
end
else 
begin
	select @cFEEBPIND = 'P1'

	select @iRvsFact = case when isnull(RVSIND,'') = @cYES then -1 else 1 end from tpymtbas where PYMTNO = @cPYMTNO

	If @cBILLTYPE = 'S' 
	begin
		Select  @nSelfFeeAmt= @nSelfFeeAmt * ABS(@dTOTBILLAMT/@dPremAmt)
	end

end

select @dTotFEEAMT = 	 @dTOTBILLAMT * @dTotCommPerc


declare cur_prdu cursor for
select	p1.PRDUCODE, p1.PRDUSHRPC, c.curccode, s.COMMPERC
from	tpolpdtcom p1, tcommcode c, tcomscale s
where 	p1.polno = @cPOLNO
and	p1.prodcode = @cPRODCODE
and	p1.effdate = @dtEFFDATE
and 	c.commcode = @cCommcode
and 	s.commcode = c.commcode
and 	@dPOLYAER > s.YRFR 
and 	@dPOLYAER <= s.YRTO
and	p1.rcdsts = @cACTIVE
and 	c.RCDSTS = @cACTIVE
and 	S.RCDSTS = @cACTIVE


select @dTotPRDUSHRPC = 0,
	@dTotFEEAMT = 0


open cur_prdu

-- fetch next from cur_prdu into @cPRDUCODE, @cPRDUSHRPC
fetch next from cur_prdu into @cPRDUCODE, @cPRDUSHRPC, @cFeeCurccode, @dFeePerc
while @@fetch_status = 0
begin
	if @cPRDUSHRPC = 0 
	begin
		GOTO FETCHPRDU
	end


	if ISNULL(@cPYMTNO, '') <> ''
	begin
		if not exists(select 1 from tproducer where prducode = @cPRDUCODE and RCDSTS = @cACTIVE)
		begin
			GOTO FETCHPRDU
		end
	end


	SELECT @dTotPRDUSHRPC = isnull(@cPRDUSHRPC,0) + @dTotPRDUSHRPC

	if @dTotPRDUSHRPC < 1
	begin

			select @dFEEAMT = @dTOTBILLAMT * @dTotCommPerc * @cPRDUSHRPC
		
	end
	else 
	begin
			
			select @dFEEAMT = @dTOTBILLAMT * @dTotCommPerc - @dTotFEEAMT

	end


	insert into tcommdtl(TRANDTE,POLNO,PRODCODE, PRDUCODE, COMMTYPE, CURCCODE,COMMAMT,SUBOFFCODE, FYRENCODE, COMMMDPERD,COMMPAIDTE,USRID,COLOFFCODE,
	 BILLMODE ,COMPCODE, PYMTNO ,BILLNO, PRDUSHRPC, AGYCODE)
	values (convert(char(10), getdate(),120), @cPOLNO, @cPRODCODE, @cPRDUCODE, 'D1', @cFeeCurccode, @dFEEAMT, @cSUBOFFCODE,
		'F',@dFEEMDPERD, null, 'NOVASYS','000', @cBILLMODE, @nCOMPCODE, NULL,@cBILLNO, 	@cPRDUSHRPC,NULL)


	SELECT @iErrCode = @@error
	IF @iErrCode <> 0
	BEGIN
		SELECT @cRETCODE = @cRTNFAIL
		SELECT @cErrMsg = 'INSERT Tcommdtl ERROR:' + convert(char(10),@iErrCode)  --Error Message
		SELECT @cErrData = 'DATA ' + @cPOLNO + ' ' + @cPRODCODE + ' ' + @cPRDUCODE
		
		GOTO ErrorHandling
	END	

	select @dTotFEEAMT = isnull(@dFEEAMT,0) + @dTotFEEAMT

FETCHPRDU:

	fetch next from cur_prdu into @cPRDUCODE, @cPRDUSHRPC, @cFeeCurccode, @dFeePerc
end


close cur_prdu
deallocate cur_prdu

--select @dTotCommAMT = 	 @dTOTBILLAMT * @dTotCommPerc
	



GOTO EXIT_WINDOW

ErrorHandling:
IF  @cRETCODE = @cRTNFAIL   --(if the error is NOT returned from sub store proc, write TERLOGTRN)
BEGIN
	INSERT terlogtrn (timestmp, userid, pgmid, contind, errmsg, errdata)
	VALUES (GETDATE(),@cUSERID, @cErrFrom, @cNO, @cErrMsg, @cErrData) 
END

EXIT_WINDOW:

select @dTotFEEAMT = ISNULL(@dTotFEEAMT,0)

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