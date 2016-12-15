IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.UspGACS033FillSDDtl') AND sysstat & 0xf = 4)
	drop procedure dbo.UspGACS033FillSDDtl
GO

/********************************************************************************
* COMPASS 2000 
*	
* UspGACS033FillSDDtl.SQL - For AU, populate stamp duty detail screen
*
* Initial version	: 5.5	
* Request Number	: PIRC13256
* Author	        : Clark Pan
* CREATED       	: 2006-12-22
********************************************************************************
VERSION    PIRNO          PROGRAMMER           DATE          REMARK     PURPOSE 
V1.1       Step2          May Chen             05/07/2013    TSK20      Upgrade 2012    
v6.1		AU_SD			Hinson.L			03/03/2015				For AU Stamp Duty enhancement
********************************************************************************/
CREATE PROCEDURE dbo.UspGACS033FillSDDtl
(	@cAction  char(1),	--'S' for summuary, 'D' for detail
	@sPolicyNo	CHAR(10),
	@cPolicyType    CHAR(1),
  	@dtMonthEnd	datetime
)
 AS

/*DECLARE VARIABLES AND CONSTANTS*/
DECLARE	@cACTIVE		CHAR(1)
DECLARE	@cDELETED		CHAR(1)
DECLARE	@cYES			CHAR(1)
DECLARE	@cNO			CHAR(1)
DECLARE	@cBATCH			CHAR(1)
DECLARE	@cONLINE		CHAR(1)
DECLARE	@cSTOREDPROC		CHAR(1)
DECLARE	@cRETCODE		CHAR(4)
DECLARE  @cLANGCODE	CHAR(03)
DECLARE  @cPGMID	CHAR(40)
DECLARE  @cRETN_SUCCESS CHAR(04)
DECLARE  @cRETN_ERROR   CHAR(04)
DECLARE  @cCONTIND	CHAR(01)
DECLARE  @cERRDATA      CHAR(45)
DECLARE  @cERRMSG	CHAR(65)
DECLARE  @ERROR	INT
DECLARE  @cSELECT_FAIL  CHAR(05)
DECLARE  @nROW_EMPTY    INT
DECLARE  @cSPACES	CHAR(01)
/********************************************************************************/	
DECLARE	@sCutOffDate		VARCHAR(10)
DECLARE  @nACDate    INT, @nCurrentMonth    INT
create table #tmpDETAIL
         (
	[POLNO] [char] (10) NOT NULL ,
	TYPE	        Char	(1)	Null,	
	PREMGROWPCT	Decimal	(5,4)	Null,		
	[PRODCODE] [char] (5) NOT NULL ,
	[PRODSHORT] [char] (10) NULL ,
	[STATE] [char] (3) NULL ,
	[ApportionPCT] [decimal](5, 4) NULL ,
	[StmpDutyPCT] [decimal](5, 4) NULL ,
	[CALCBASIS] [char] (3) NULL ,
	[NETOFFPCT] [decimal](6, 4) NULL ,
	[PREMPAID] [decimal](13, 2) NULL ,
	[PREMGROWTH] [decimal](13, 2) NULL ,
	[PREMANNGROW] [decimal](13, 2) NULL ,
	[STMPDUTYPAID] [decimal](13, 2) NULL ,
	[FYRENCODE] [char] (1) NULL
)

/*INITIATE CONSTANTS*/
SELECT  @cRETN_ERROR	= '9999'
SELECT  @cLANGCODE	= '850'
SELECT  @ERROR	= 0
SELECT  @nROW_EMPTY	= 0
SELECT  @cSELECT_FAIL   = 'I0065'
SELECT	@cPGMID		= 'UspGACS033FillSDDtl'
SELECT	@cCONTIND  	= 'N'
SELECT  @cSPACES	= ' '
SELECT	@cONLINE		= 'O'
SELECT	@cBATCH			= 'B'
SELECT	@cSTOREDPROC		= 'S'
SELECT	@cRETN_SUCCESS		= '0000'
SELECT	@cYES			= 'Y'
SELECT	@cNO			= 'N'
SELECT	@cACTIVE		= 'A'
SELECT	@cDELETED		= 'D'
/********************************************************************************/	
set @nACDate = datepart(year, @dtMonthEnd)*100 + datepart(month, @dtMonthEnd)
set @nCurrentMonth = datepart(year, getdate())*100 + datepart(month, getdate())

select @sCutOffDate = PARMVALUE
  FROM Tsysparmh
 where PARMDESC     = 'SD_CUTOFFDAT'

if @cPolicyType = '2'
begin

	insert #tmpDETAIL(POLNO,PRODCODE,PRODSHORT,STATE,ApportionPCT,StmpDutyPCT,CALCBASIS,NETOFFPCT,PREMPAID,PREMGROWTH,PREMANNGROW,STMPDUTYPAID,FYRENCODE)
	select @sPolicyNo,TPOLD.PRODCODE,TPROD.PRODSHORT,tpsd.STATE,tpsd.STMPDUTYPCT,tsdr.TAXPCT/100,CALCBASIS,NETOFFPCT,0,0,0,null,'F'
			  from tpolpdt TPOLD, tproduct TPROD, TPOLPDTSTPDTY tpsd, TSTMPDUTYRT_AU tsdr
			 where TPOLD.POLNO = @sPolicyNo
		and TPROD.PRODCODE =TPOLD.PRODCODE
			   AND TPOLD.RCDSTS    = @cACTIVE
			   AND TPOLD.EFFDATE   = (
				SELECT MAX(TPLPD2.EFFDATE)
				  FROM TPOLPDT TPLPD2
				 WHERE TPLPD2.POLNO    = @sPolicyNo
				   AND TPLPD2.PRODCODE = TPOLD.PRODCODE
				   and TPLPD2.CHGEFFDT <= @dtMonthEnd
				   AND TPLPD2.RCDSTS   = @cACTIVE
				   )
		and tpsd.POLNO = @sPolicyNo
		and tpsd.PRODCODE =TPOLD.PRODCODE
			   AND tpsd.RCDSTS    = @cACTIVE
			   AND tpsd.CHGEFFDT   = (
				SELECT MAX(TPLPD2.CHGEFFDT)
				  FROM TPOLPDTSTPDTY TPLPD2
				 WHERE TPLPD2.POLNO    = @sPolicyNo
				   AND TPLPD2.PRODCODE = TPOLD.PRODCODE
				   and TPLPD2.CHGEFFDT <= @dtMonthEnd
				   AND TPLPD2.RCDSTS   = @cACTIVE
				   )
		and tsdr.STATE = tpsd.STATE
		and tsdr.PRODCODE =TPOLD.PRODCODE
			   AND tsdr.EFFDATE   = (
				SELECT MAX(TPLPD2.EFFDATE)
				  FROM TSTMPDUTYRT_AU TPLPD2
				 WHERE TPLPD2.STATE = tsdr.STATE
				   AND TPLPD2.PRODCODE = TPOLD.PRODCODE
				   and TPLPD2.EFFDATE <= @dtMonthEnd
				   )

	if exists(
			select POLNO
			  from TSTMPDUTYDTL_TPATRX
			 where POLNO        =  @sPolicyNo
			   AND ACDATE       =  @nACDate
			   AND PAIDMTH      =  @nCurrentMonth
			   AND RCDSTS       =  @cACTIVE
			 union all
			select ts.POLNO
			  from TPREMALTRN ts
			 where ts.POLNO     =  @sPolicyNo
			   AND ts.RCDSTS    =  @cACTIVE
			   AND ts.RCDDTSTMP >= @sCutOffDate
			   AND ts.ACDATE    =  @nACDate
			   AND ts.PYMTNO not in (
				select PYMTNO
				  from TSTMPDUTYPYMT_TPATRX
				 WHERE RCDSTS       =  @cACTIVE
				   )
	)
	begin
		insert #tmpDETAIL(POLNO,PRODCODE,PRODSHORT,STATE,ApportionPCT,StmpDutyPCT,CALCBASIS,NETOFFPCT,PREMPAID,PREMGROWTH,PREMANNGROW,STMPDUTYPAID,FYRENCODE)
		select POLNO,PRODCODE,PRODSHORT,STATE,ApportionPCT,StmpDutyPCT,CALCBASIS,NETOFFPCT,PREMPAID,PREMGROWTH,PREMANNGROW,STMPDUTYPAID,'R' from #tmpDETAIL TPROD
				 where TPROD.CALCBASIS ='AP'

		/*
					select ts.ALLOCAMT, td.POLNO, td.PRODCODE, td.FYRENCODE,*
					  from TPREMALTRN ts, (select distinct POLNO, PRODCODE, CALCBASIS, FYRENCODE from #tmpDETAIL) as td, TPYMTBIL tpb
					 where td.POLNO       =  @sPolicyNo
					   and ts.POLNO       =  @sPolicyNo
					   and td.PRODCODE    =  ts.PRODCODE
					   and ts.PYMTTRAN in ('A','B','C','D')
					   AND ts.RCDSTS      =  @cACTIVE
					   AND ts.RCDDTSTMP   >= @sCutOffDate
					   AND ts.ACDATE      =  @nACDate
					   AND ts.PYMTNO not in (
							select PYMTNO
							  from TSTMPDUTYPYMT_TPATRX
							 WHERE RCDSTS       =  @cACTIVE
						   )
					   and tpb.PYMTNO     =  ts.PYMTNO
					   and (
							   (
								   td.CALCBASIS   =  'AP'
							   and td.FYRENCODE   =  (
									select distinct tb.FYRENCODE
									  from TBILDETP tb, tpolicy tp
									 where tp.POLNO       =  @sPolicyNo
									   and tb.BILLNO      =  tpb.BILLNO
									   and tb.POLNO       =  @sPolicyNo
									   and tb.COMPCODE    =  tp.COMPCODE
									   and tb.CLNTCODE    =  tp.CLNTCODE
									   and tb.PRODCODE    =  td.PRODCODE
								   )
							   )
							or (td.CALCBASIS  =  'FYP')
						   )
		*/
				update ttmp
				   set PREMPAID       =  PREMPAID+round(tpat.total*ApportionPCT,2)
				  from #tmpDETAIL ttmp, (
					select sum(ts.ALLOCAMT) as total, td.POLNO, td.PRODCODE, td.CALCBASIS, td.FYRENCODE
					  from TPREMALTRN ts, (select distinct POLNO, PRODCODE, CALCBASIS, FYRENCODE from #tmpDETAIL) as td, TPYMTBIL tpb
					 where td.POLNO       =  @sPolicyNo
					   and ts.POLNO       =  @sPolicyNo
					   and td.PRODCODE    =  ts.PRODCODE
					   and ts.PYMTTRAN in ('A','B','C','D')
					   AND ts.RCDSTS      =  @cACTIVE
					   AND ts.RCDDTSTMP   >= @sCutOffDate
					   AND ts.ACDATE      =  @nACDate
					   AND ts.PYMTNO not in (
							select PYMTNO
							  from TSTMPDUTYPYMT_TPATRX
							 WHERE RCDSTS       =  @cACTIVE
						   )
					   and tpb.PYMTNO     =  ts.PYMTNO
					   and (
							   (
								   td.CALCBASIS   =  'AP'
							   and td.FYRENCODE   =  (
									select distinct tb.FYRENCODE
									  from TBILDETP tb, tpolicy tp
									 where tp.POLNO       =  @sPolicyNo
									   and tb.BILLNO      =  tpb.BILLNO
									   and tb.POLNO       =  @sPolicyNo
									   and tb.COMPCODE    =  tp.COMPCODE
									   and tb.CLNTCODE    =  tp.CLNTCODE
									   and tb.PRODCODE    =  td.PRODCODE
								   )
							   )
							or (td.CALCBASIS  =  'FYP')
						   )
					 group by td.POLNO, td.PRODCODE, td.CALCBASIS, td.FYRENCODE
					   ) as tpat
				 where ttmp.POLNO     =  @sPolicyNo
				   and tpat.POLNO     =  @sPolicyNo
				   and ttmp.PRODCODE  =  tpat.PRODCODE
				   and ttmp.CALCBASIS =  tpat.CALCBASIS
				   and ttmp.FYRENCODE =  tpat.FYRENCODE

				update ttmp
				   set PREMPAID       =  PREMPAID-round(tpat.total*ApportionPCT,2)
				  from #tmpDETAIL ttmp, (
					select sum(ts.ALLOCAMT) as total, td.POLNO, td.PRODCODE, td.CALCBASIS, td.FYRENCODE
					  from TPREMALTRN ts, (select distinct POLNO, PRODCODE, CALCBASIS, FYRENCODE from #tmpDETAIL) as td, TPYMTBIL tpb
					 where td.POLNO       =  @sPolicyNo
					   and ts.POLNO       =  @sPolicyNo
					   and td.PRODCODE    =  ts.PRODCODE
					   and ts.PYMTTRAN = 'W'
					   AND ts.RCDSTS      =  @cACTIVE
					   AND ts.RCDDTSTMP   >= @sCutOffDate
					   AND ts.ACDATE      =  @nACDate
					   AND ts.PYMTNO not in (
							select PYMTNO
							  from TSTMPDUTYPYMT_TPATRX
							 WHERE RCDSTS       =  @cACTIVE
						   )
					   and tpb.PYMTNO     =  ts.PYMTNO
					   and (
							   (
								   td.CALCBASIS   =  'AP'
							   and td.FYRENCODE   =  (
									select distinct tb.FYRENCODE
									  from TBILDETP tb, tpolicy tp
									 where tp.POLNO       =  @sPolicyNo
									   and tb.BILLNO      =  tpb.BILLNO
									   and tb.POLNO       =  @sPolicyNo
									   and tb.COMPCODE    =  tp.COMPCODE
									   and tb.CLNTCODE    =  tp.CLNTCODE
									   and tb.PRODCODE    =  td.PRODCODE
								   )
							   )
							or (td.CALCBASIS  =  'FYP')
						   )
					 group by td.POLNO, td.PRODCODE, td.CALCBASIS, td.FYRENCODE
					   ) as tpat
				 where ttmp.POLNO     =  @sPolicyNo
				   and tpat.POLNO     =  @sPolicyNo
				   and ttmp.PRODCODE  =  tpat.PRODCODE
				   and ttmp.CALCBASIS =  tpat.CALCBASIS
				   and ttmp.FYRENCODE =  tpat.FYRENCODE

				update #tmpDETAIL
				   set PREMGROWTH     =  PREMPAID

				update ttmp
			   set PREMPAID       = ttmp.PREMPAID+tsdd.PREMPAID,
				   PREMGROWTH = tsdd.PREMGROWTH,
				   PREMANNGROW = tsdd.PREMANNGROW,
				   STMPDUTYPAID = tsdd.STMPDUTYPAID
				  from #tmpDETAIL ttmp, TSTMPDUTYDTL_TPATRX tsdd
				 where ttmp.POLNO     = @sPolicyNo
				   and tsdd.POLNO     = @sPolicyNo
				   and ttmp.PRODCODE  = tsdd.PRODCODE
				   and ttmp.STATE     = tsdd.STATE
				   and ttmp.FYRENCODE = tsdd.FYRENCODE
				   AND tsdd.ACDATE    = @nACDate
				   AND tsdd.PAIDMTH   = @nCurrentMonth
				   AND tsdd.RCDSTS    = @cACTIVE

			delete 	#tmpDETAIL where CALCBASIS   =  'AP' and PREMPAID = 0 and PREMGROWTH = 0 and PREMANNGROW = 0

		end

	select PRODCODE,PRODSHORT,STATE,ApportionPCT,StmpDutyPCT,CALCBASIS,NETOFFPCT,PREMPAID,PREMGROWTH,PREMANNGROW,STMPDUTYPAID,FYRENCODE from #tmpDETAIL
	order by PRODCODE,STATE,FYRENCODE
end
else if @cAction = 'S' and (@cPolicyType = '3' or @cPolicyType = '4')
	begin
insert #tmpDETAIL(POLNO,PRODCODE,PRODSHORT,TYPE,PREMGROWPCT,CALCBASIS,PREMPAID,PREMANNGROW)
select @sPolicyNo,TPOLD.PRODCODE,TPROD.PRODSHORT,@cPolicyType,null,CALCBASIS,0,0
          from tpolpdt TPOLD, tproduct TPROD, TPOLPDTSTPDTY tpsd, TSTMPDUTYRT_AU tsdr
         where TPOLD.POLNO = @sPolicyNo
	and TPROD.PRODCODE =TPOLD.PRODCODE
           AND TPOLD.RCDSTS    = @cACTIVE
           AND TPOLD.EFFDATE   = (
			SELECT MAX(TPLPD2.EFFDATE)
			  FROM TPOLPDT TPLPD2
			 WHERE TPLPD2.POLNO    = @sPolicyNo
			   AND TPLPD2.PRODCODE = TPOLD.PRODCODE
			   and TPLPD2.CHGEFFDT <= @dtMonthEnd
			   AND TPLPD2.RCDSTS   = @cACTIVE
               )
	and tpsd.POLNO = @sPolicyNo
	and tpsd.PRODCODE =TPOLD.PRODCODE
           AND tpsd.RCDSTS    = @cACTIVE
           AND tpsd.CHGEFFDT   = (
			SELECT MAX(TPLPD2.CHGEFFDT)
			  FROM TPOLPDTSTPDTY TPLPD2
			 WHERE TPLPD2.POLNO    = @sPolicyNo
			   AND TPLPD2.PRODCODE = TPOLD.PRODCODE
			   and TPLPD2.CHGEFFDT <= @dtMonthEnd
			   AND TPLPD2.RCDSTS   = @cACTIVE
               )
	and tsdr.STATE = tpsd.STATE
	and tsdr.PRODCODE =TPOLD.PRODCODE
           AND tsdr.EFFDATE   = (
			SELECT MAX(TPLPD2.EFFDATE)
			  FROM TSTMPDUTYRT_AU TPLPD2
			 WHERE TPLPD2.STATE = tsdr.STATE
			   AND TPLPD2.PRODCODE = TPOLD.PRODCODE
			   and TPLPD2.EFFDATE <= @dtMonthEnd
               )
	group by TPOLD.PRODCODE,TPROD.PRODSHORT,CALCBASIS
--Upgrade2012 Step2 TSK20 begin
	order by TPOLD.PRODCODE,TPROD.PRODSHORT,CALCBASIS
--Upgrade2012 Step2 TSK20 end

if exists(
        select POLNO
          from TSTMPDUTYDTL_TPATRX
         where POLNO        =  @sPolicyNo
           AND ACDATE       =  @nACDate
           AND PAIDMTH      =  @nCurrentMonth
           AND RCDSTS       =  @cACTIVE
         union all
        select ts.POLNO
          from TPREMALTRN ts
         where ts.POLNO     =  @sPolicyNo
           AND ts.RCDSTS    =  @cACTIVE
           AND ts.RCDDTSTMP >= @sCutOffDate
           AND ts.ACDATE    =  @nACDate
           AND ts.PYMTNO not in (
			select PYMTNO
			  from TSTMPDUTYPYMT_TPATRX
			 WHERE RCDSTS       =  @cACTIVE
               )
)
	begin
/*insert #tmpDETAIL(POLNO,PRODCODE,PRODSHORT,STATE,ApportionPCT,StmpDutyPCT,CALCBASIS,NETOFFPCT,PREMPAID,PREMGROWTH,PREMANNGROW,STMPDUTYPAID,FYRENCODE)
select POLNO,PRODCODE,PRODSHORT,STATE,ApportionPCT,StmpDutyPCT,CALCBASIS,NETOFFPCT,PREMPAID,PREMGROWTH,PREMANNGROW,STMPDUTYPAID,'R' from #tmpDETAIL TPROD
         where TPROD.CALCBASIS ='AP'
*/
/*			select ts.ALLOCAMT, td.POLNO, td.PRODCODE, td.FYRENCODE,*
			  from TPREMALTRN ts, #tmpDETAIL td, TPYMTBIL tpb
			 where td.POLNO       =  @sPolicyNo
			   and ts.POLNO       =  @sPolicyNo
			   and td.PRODCODE    =  ts.PRODCODE
			   and ts.PYMTTRAN in ('A','B','C','D')
			   AND ts.RCDSTS      =  @cACTIVE
			   AND ts.RCDDTSTMP   >= @sCutOffDate
			   AND ts.ACDATE      =  @nACDate
			   AND ts.PYMTNO not in (
					select PYMTNO
					  from TSTMPDUTYPYMT_TPATRX
					 WHERE RCDSTS       =  @cACTIVE
			       )
			   and tpb.PYMTNO     =  ts.PYMTNO
			   and (
				       (
					       td.CALCBASIS   =  'AP'
					   and td.FYRENCODE   =  (
							select distinct tb.FYRENCODE
							  from TBILDETP tb, tpolicy tp
							 where tp.POLNO       =  @sPolicyNo
							   and tb.BILLNO      =  tpb.BILLNO
							   and tb.POLNO       =  @sPolicyNo
							   and tb.COMPCODE    =  tp.COMPCODE
							   and tb.CLNTCODE    =  tp.CLNTCODE
							   and tb.PRODCODE    =  td.PRODCODE
					       )
				       )
				    or (td.CALCBASIS  =  'FYP')
			       )
*/
        update ttmp
           set PREMPAID       =  PREMPAID+tpat.total
          from #tmpDETAIL ttmp, (
			select sum(ts.ALLOCAMT) as total, td.POLNO, td.PRODCODE
			  from TPREMALTRN ts, (select distinct POLNO, PRODCODE from #tmpDETAIL) as td, TPYMTBIL tpb
			 where td.POLNO       =  @sPolicyNo
			   and ts.POLNO       =  @sPolicyNo
			   and td.PRODCODE    =  ts.PRODCODE
			   and ts.PYMTTRAN in ('A','B','C','D')
			   AND ts.RCDSTS      =  @cACTIVE
			   AND ts.RCDDTSTMP   >= @sCutOffDate
			   AND ts.ACDATE      =  @nACDate
			   AND ts.PYMTNO not in (
					select PYMTNO
					  from TSTMPDUTYPYMT_TPATRX
					 WHERE RCDSTS       =  @cACTIVE
			       )
			   and tpb.PYMTNO     =  ts.PYMTNO
			 group by td.POLNO, td.PRODCODE
               ) as tpat
         where ttmp.POLNO     =  @sPolicyNo
           and tpat.POLNO     =  @sPolicyNo
           and ttmp.PRODCODE  =  tpat.PRODCODE

        update ttmp
           set PREMPAID       =  PREMPAID-tpat.total
          from #tmpDETAIL ttmp, (
			select sum(ts.ALLOCAMT) as total, td.POLNO, td.PRODCODE
			  from TPREMALTRN ts, (select distinct POLNO, PRODCODE from #tmpDETAIL) as td, TPYMTBIL tpb
			 where td.POLNO       =  @sPolicyNo
			   and ts.POLNO       =  @sPolicyNo
			   and td.PRODCODE    =  ts.PRODCODE
			   and ts.PYMTTRAN = 'W'
			   AND ts.RCDSTS      =  @cACTIVE
			   AND ts.RCDDTSTMP   >= @sCutOffDate
			   AND ts.ACDATE      =  @nACDate
			   AND ts.PYMTNO not in (
					select PYMTNO
					  from TSTMPDUTYPYMT_TPATRX
					 WHERE RCDSTS       =  @cACTIVE
			       )
			   and tpb.PYMTNO     =  ts.PYMTNO
			 group by td.POLNO, td.PRODCODE
               ) as tpat
         where ttmp.POLNO     =  @sPolicyNo
           and tpat.POLNO     =  @sPolicyNo
           and ttmp.PRODCODE  =  tpat.PRODCODE

        update #tmpDETAIL
           set PREMGROWTH     =  PREMPAID

        update ttmp
	   set PREMPAID       = ttmp.PREMPAID+tsdd.PREMPAID,
	       PREMGROWTH = ttmp.PREMPAID+tsdd.PREMPAID,
	       PREMANNGROW = tsdd.PREMANNGROW,
	       PREMGROWPCT = tsdd.PREMGROWPCT
          from #tmpDETAIL ttmp, TSTMPDUTYPRD_TRX tsdd
         where ttmp.POLNO     = @sPolicyNo
           and tsdd.POLNO     = @sPolicyNo
           and ttmp.PRODCODE  = tsdd.PRODCODE
           and ttmp.CALCBASIS = tsdd.CALCBASIS
           AND tsdd.ACDATE    = @nACDate
           AND tsdd.RCDSTS    = @cACTIVE
           AND tsdd.PAIDMTH    = @nCurrentMonth

--	delete 	#tmpDETAIL where CALCBASIS   =  'AP' and PREMPAID = 0 and PREMANNGROW = 0

	end

select PRODCODE,PRODSHORT,CALCBASIS,PREMPAID,PREMGROWTH,PREMANNGROW,PREMGROWPCT from #tmpDETAIL
order by PRODCODE,CALCBASIS
end
else if @cAction = 'D' and (@cPolicyType = '3' or @cPolicyType = '4')
	begin
insert #tmpDETAIL(POLNO,PRODCODE,PRODSHORT,STATE,ApportionPCT,StmpDutyPCT,CALCBASIS,NETOFFPCT,PREMPAID,PREMGROWTH,PREMANNGROW,PREMGROWPCT,STMPDUTYPAID,FYRENCODE)
select @sPolicyNo,TPOLD.PRODCODE,TPROD.PRODSHORT,tpsd.STATE,tpsd.STMPDUTYPCT,tsdr.TAXPCT/100,tsdr.CALCBASIS,NETOFFPCT,round(tsdp.PREMPAID*tpsd.STMPDUTYPCT, 2),round(tsdp.PREMPAID*tpsd.STMPDUTYPCT, 2),round(tsdp.PREMANNGROW*tpsd.STMPDUTYPCT, 2),tsdp.PREMGROWPCT,0,'F'
          from TSTMPDUTYPRD_TRX tsdp, tpolpdt TPOLD, tproduct TPROD, TPOLPDTSTPDTY tpsd, TSTMPDUTYRT_AU tsdr
         where tsdp.POLNO = @sPolicyNo
	and tsdp.PRODCODE =TPOLD.PRODCODE
           AND tsdp.ACDATE       =  @nACDate
           AND tsdp.PAIDMTH    = @nCurrentMonth
           AND tsdp.RCDSTS    = @cACTIVE
	and TPOLD.POLNO = @sPolicyNo
	and TPROD.PRODCODE =TPOLD.PRODCODE
           AND TPOLD.RCDSTS    = @cACTIVE
           AND TPOLD.EFFDATE   = (
			SELECT MAX(TPLPD2.EFFDATE)
			  FROM TPOLPDT TPLPD2
			 WHERE TPLPD2.POLNO    = @sPolicyNo
			   AND TPLPD2.PRODCODE = TPOLD.PRODCODE
			   and TPLPD2.CHGEFFDT <= @dtMonthEnd
			   AND TPLPD2.RCDSTS   = @cACTIVE
               )
	and tpsd.POLNO = @sPolicyNo
	and tpsd.PRODCODE =TPOLD.PRODCODE
           AND tpsd.RCDSTS    = @cACTIVE
           AND tpsd.CHGEFFDT   = (
			SELECT MAX(TPLPD2.CHGEFFDT)
			  FROM TPOLPDTSTPDTY TPLPD2
			 WHERE TPLPD2.POLNO    = @sPolicyNo
			   AND TPLPD2.PRODCODE = TPOLD.PRODCODE
			   and TPLPD2.CHGEFFDT <= @dtMonthEnd
			   AND TPLPD2.RCDSTS   = @cACTIVE
               )
	and tsdr.STATE = tpsd.STATE
	and tsdr.PRODCODE =TPOLD.PRODCODE
	and tsdr.CALCBASIS =tsdp.CALCBASIS
           AND tsdr.EFFDATE   = (
			SELECT MAX(TPLPD2.EFFDATE)
			  FROM TSTMPDUTYRT_AU TPLPD2
			 WHERE TPLPD2.STATE = tsdr.STATE
			   AND TPLPD2.PRODCODE = TPOLD.PRODCODE
			   and TPLPD2.EFFDATE <= @dtMonthEnd
               )

--select * from #tmpDETAIL
	if @cPolicyType = '3'
update tsdp set STMPDUTYPAID = isnull(round(case tsdp.CALCBASIS when 'FYP' then tsdp.PREMANNGROW/NETOFFPCT*StmpDutyPCT else tsdp.PREMPAID/NETOFFPCT*StmpDutyPCT end, 2), 0)
from #tmpDETAIL tsdp
where tsdp.POLNO = @sPolicyNo
	else if @cPolicyType = '4'
		update tsdp set PREMGROWTH = tsdp.PREMPAID, PREMANNGROW = round(tsdp.PREMPAID*PREMGROWPCT, 2), STMPDUTYPAID = isnull(round(case tsdp.CALCBASIS when 'FYP' then tsdp.PREMPAID/NETOFFPCT*StmpDutyPCT*PREMGROWPCT else tsdp.PREMPAID/NETOFFPCT*StmpDutyPCT end, 2), 0)
from #tmpDETAIL tsdp
where tsdp.POLNO = @sPolicyNo

select PRODCODE,PRODSHORT,STATE,ApportionPCT,StmpDutyPCT,CALCBASIS,NETOFFPCT,PREMPAID,PREMGROWTH,PREMANNGROW,STMPDUTYPAID,FYRENCODE from #tmpDETAIL
order by PRODCODE,STATE,FYRENCODE
	end

