if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[search_details_bill]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
     drop procedure [dbo].[search_details_bill]
GO

CREATE PROCEDURE [dbo].[search_details_bill]
(@sectionId varchar(20),
@policyNo varchar(50))
AS
BEGIN
SET NOCOUNT ON
	if(@sectionId = 'bill_pay')
	begin
		SELECT  POLNO = @policyNo,
            ProductCode = t1.PRODCODE ,
            ProductName = t3.PRODSHORT,
            SubOffCode = t1.SUBOFFCODE,
            SubOffName = t4.SUBOFFNAME,
            BillToDay = CONVERT(CHAR(10), ISNULL(t1.BILLTODATE,'1900-01-01'), 111),
            PayToDay = CONVERT(CHAR(10), ISNULL(t2.PAIDTODATE,'1900-01-01'), 111)
        FROM TPOLPDTSUB t1 
    	inner join (select POLNO,SUBOFFCODE,PRODCODE,MAX(PAIDTODATE) as PAIDTODATE from TPOLFINCL 
					where  POLNO = @policyNo 
					GROUP BY POLNO,SUBOFFCODE,PRODCODE ) t2
        on  t1.POLNO = t2.POLNO
        and t1.SuboffCode = t2.SuboffCode
        and t1.PRODCODE = t2.PRODCODE
        and t1.POLNO = @policyNo 
	    INNER JOIN TPOLICY T5 ON T1.POLNO = T5.POLNO AND T5.POLNO = @policyNo 
	    LEFT JOIN TPRODUCT T3 ON T1.PRODCODE = T3.PRODCODE
	    LEFT JOIN TCLNTSUB T4 ON T1.SUBOFFCODE = T4.SUBOFFCODE AND T4.CLNTCODE = T5.CLNTCODE  
	end
	
	if(@sectionId = 'bill_list')
	begin
		SELECT  BillNo =  TB.BILLNO, 
				SubOffice = TB.SUBOFFCODE, 
				BillIssueDate = CONVERT(CHAR(10), TB.BISSDATE, 111),
				BillCurrency = MAX(TCr.CURSYMBOL),
                BillType = CASE WHEN TB.BILLNO LIKE 'EST%' THEN 'Estimate' WHEN TB.FMTBILLIND = 'O' AND TB.RCDSTS = 'A'  THEN 'Official'
                           WHEN TB.FMTBILLIND = 'D' AND TB.RCDSTS = 'D' THEN 'Draft' WHEN TB.FMTBILLIND = 'O' AND TB.RCDSTS = 'D'  AND (NOT TB.STATUS='R' ) THEN 'Deleted' WHEN TB.FMTBILLIND = 'O' AND TB.RCDSTS = 'D' AND TB.STATUS='R'  THEN 'Replaced' END,
                BillControl = TB.BILLSEQNO,  
				RenewFirstBill = case rtrim(TB.RenewFirstInd) when 'Y' then 'Y' else '' end,   
				ChequeDate = CONVERT(CHAR(10), isnull(TB.CHEQUEDATE,''), 111),
				FR = CASE WHEN MAX(TP.FYRENCODE) = 'F' THEN N'新账单' ELSE N'续保账单' END,
                TotalBilledAmt = SUM(ISNULL(TP.PREMDU, 0) + ISNULL(TP.PREMDUAD, 0) + ISNULL(TP.PREMTAX, 0) + ISNULL(TP.STMPDUTY, 0) - ISNULL(TP.EXPREFD, 0) - ISNULL(TP.PREMBIND, 0)),
                PaidAmt = SUM(ISNULL(TP.PAIDAMT, 0)),
                CurrentOSAmt = SUM(ISNULL(TP.PREMDU, 0) + ISNULL(TP.PREMDUAD, 0) + ISNULL(TP.PREMTAX, 0) + ISNULL(TP.STMPDUTY, 0) - ISNULL(TP.EXPREFD, 0) - ISNULL(TP.PREMBIND, 0) - ISNULL(TP.PAIDAMT, 0)),
                BillDueDate = CONVERT(CHAR(10), isnull(MAX(TP.BILLPRDFR),''), 111),
				BillPaidDate = CONVERT(CHAR(10), isnull(TB.PAIDDATE,''), 111),
				GrossPremium = SUM(ISNULL(TP.PREMDU, 0) + ISNULL( TP.PREMDUAD, 0)),
                PremiumTax = SUM(ISNULL(TP.PREMTAX, 0)), 
				AdvanceExpRefund = SUM(ISNULL(TP.EXPREFD, 0) - ISNULL(TP.PRYREXPRFD,0)),
                PrYrsExpRefund = SUM(ISNULL(TP.PRYREXPRFD,0)), 
				BinderPrenium = SUM(ISNULL(TP.PREMBIND, 0)),  
				BilledCommission = SUM(ISNULL(TP.COMMDU, 0)), 
				BilledAdminFee = SUM(ISNULL(ADMINFEE,0)),
                NetDueAmount = SUM(ISNULL(TP.PREMDU, 0) + ISNULL(TP.PREMDUAD, 0) + ISNULL(TP.PREMTAX, 0) + ISNULL(TP.STMPDUTY, 0) - ISNULL(TP.EXPREFD, 0) - ISNULL(TP.PREMBIND, 0) - ISNULL(TP.COMMDU, 0) - ISNULL(TP.ADMINFEE,0)),
				BillPeriodFrom = CONVERT(CHAR(10), MAX(TP.BillPrdFr), 111),
				BillPeriodTo = CONVERT(CHAR(10), MAX(TP.BillPrdTo), 111)
        from TBILDETP TP
        INNER JOIN TBILDETB TB on TP.BILLNO	= TB.BILLNO  AND TP.SUBOFFCODE	= TB.SUBOFFCODE AND TB.COMPCODE	= TP.COMPCODE AND TB.CLNTCODE = TP.CLNTCODE AND TP.POLNO = @policyNo AND TB.BISSDATE IS NOT NULL AND TB.RCDSTS = 'A' AND TP.RCDSTS = 'A'
        INNER JOIN TCURCTBL TCr on TB.CURCCODE = TCr.CURCCODE AND TCr.RCDSTS = 'A'
        LEFT JOIN TBILDLTLOG TDel on TDel.SUBOFFCODE = TB.SUBOFFCODE AND TDel.BILLNO = TB.BILLNO AND TDel.POLNO	= @policyNo  AND TDel.PRODCODE	= TP.PRODCODE AND TDel.BILLPRDFR = TP.BILLPRDFR AND TDel.BILLPRDTO = Tp.BILLPRDTO AND TDel.RCDSTS = 'A'
        group by TB.BILLNO, TB.SUBOFFCODE, TB.BILLSEQNO, TB.BISSDATE, TB.CHEQUEDATE, TB.PAIDDATE, TB.CURCCode,TB.FMTBILLIND,TB.RCDSTS,TB.STATUS,TDel.DLTRSN, TB.RenewFirstInd

	end

	IF(@sectionId = 'bill_plst')
	BEGIN

		SELECT  DISTINCT  
			BILLNO = TP.BILLNO,
			POLNO = TP.POLNO,
			SUBOFFICE = TF.SUBOFFCODE,
			PRODCODE = TP.ProdCode,
			MODALPREM = TP.PremDu, 
			AJUSTPREM = TP.PremDuAd, 
			BILLPREM = ISNULL(TP.PremDu, 0) + ISNULL(TP.PremDuAd, 0) - ISNULL(TP.PremBind, 0),
			COMMDUE = TP.CommDu,
			ADMINFEE = isnull(TP.ADMINFEE,0), 
			PAIDAMT = TP.PaidAmt,
			PRODCURR = TCu.CurSymbol,
			PAIDTODATE = CONVERT(CHAR(10), TF.PaidToDate, 111),
			CLMPAIDTODATE = CONVERT(CHAR(10), TF.ClmPdToDt, 111),
			ADVEXPREFUND = TP.ExpRefd - isnull( TP.PRYREXPRFD,0) ,  
			PRYRSEXPREFUND = isnull( TP.PRYREXPRFD,0), 
			PREMTAX = TP.PremTax, 
			STAMPDUTY = TP.StmpDuty, 
			OUTSTANDINGBANLANCE = TP.OutdgBal, 
			BINDERPREM = TP.PremBind,
			PYMTNO = TBA.PymtNo,
			PYMTDUEDATE = TAL.ACDATE,
			PYMTTRAN = TAL.PYMTTRAN,
			ALLOCAMT = TAL.ALLOCAMT,
			PAYMENTAMT = TBA.PaidAmt
		FROM TBILDETP TP INNER JOIN TCURCTBL TCu ON TP.CURCCODE = TCu.CURCCODE and TCu.RCDSTS = 'A'
		INNER JOIN TPOLFINCL TF ON TF.POLNO = TP.POLNO and	TF.PRODCODE = TP.PRODCODE and TF.SUBOFFCODE = TP.SUBOFFCODE
		LEFT JOIN TPYMTBIL TBI ON TBI.BILLNO = TP.BILLNO AND TBI.ClntCode = TP.CLNTCODE AND TBI.CompCode = TP.COMPCODE AND TBI.RCDSTS = 'A'
		LEFT JOIN TPYMTBAS TBA ON TBA.SubOffCode = TP.SUBOFFCODE AND TBA.PymtNo = TBI.PymtNo AND TBA.CompCode = TBI.CompCode AND TBA.RcdSts = 'A'
		LEFT JOIN TPREMALTRN TAL ON TAL.PymtNo = TBI.PymtNo AND TAL.PolNo = TP.POLNO AND TAL.SubOffCode = TP.SUBOFFCODE AND  TAL.RcdSts = 'A'
		WHERE TP.POLNO = @policyNo
		and 	TF.ACDATE =   (
				SELECT	MAX(ACDATE)
				FROM	TPOLFINCL
				WHERE	POLNO		= TF.POLNO
				AND	PRODCODE	= TF.PRODCODE
				AND	SUBOFFCODE	= TF.SUBOFFCODE
				)
		ORDER BY TP.PRODCODE  

	END

	IF(@sectionId = 'bill_dlst')
	BEGIN
		SELECT  
			BILLNO = TBdtc.BILLNO,
			POLNO = TBdtc.POLNO,
			SUBOFFICE = TBdtc.SUBOFFCODE,
			PRODCODE = TBdtc.PRODCODE,
			[PLAN] = TBdtc.BENPLNCD,
			COVERAGE = TBdtc.COVGCODE, 
			MODALPREM = TBdtc.PREMDU, 
			AJUSTPREM = TBdtc.PREMDUAD, 
			PrevCoverage = TBdtc.BENAMTPRV,
			AddCoverage = TBdtc.BENAMTADD, 
			TermCoverage = TBdtc.BENAMTTERM,
			TotCoverage = TBdtc.BENAMTPRV + TBdtc.BENAMTADD - TBdtc.BENAMTTERM,
			PrevCounts = TBdtc.NUMMEMPRV,
			AddCounts = TBdtc.NUMADD, 
			TermCounts = TBdtc.NUMTERM, 
			TotCounts = TBdtc.NUMMEMPRV + TBdtc.NUMADD - TBdtc.NUMTERM,
			ModalRate = ISNULL(TBdtc.PREMMODAL2, 0)
		FROM TBILDETC TBdtc, TCURCTBL TCurr, TBILDETP TBdtp, TCOVERAGE TCovg
		WHERE	TBdtc.POLNO = @policyNo
		AND TBdtc.COMPCODE = TBdtp.COMPCODE
		AND TBdtc.CLNTCODE = TBdtp.CLNTCODE
		AND TBdtc.BILLNO = TBdtp.BILLNO
		AND TBdtc.SUBOFFCODE = TBdtp.SUBOFFCODE
		AND TBdtp.COMPCODE = TBdtc.COMPCODE
		AND TBdtp.CLNTCODE = TBdtc.CLNTCODE
		AND TBdtp.BILLNO = TBdtc.BILLNO
		AND TBdtp.SUBOFFCODE = TBdtc.SUBOFFCODE
		AND TBdtp.DEPARTCD = TBdtc.DEPARTCD
		AND TBdtp.POLNO = TBdtc.POLNO
		AND TBdtp.PRODCODE = TBdtc.PRODCODE
		AND TCurr.CURCCODE = TBdtp.CURCCODE
		AND TCovg.COVGCODE = TBdtc.COVGCODE
		AND TCurr.RCDSTS = 'A'
		order by TBdtc.PRODCODE, TBdtc.BENPLNCD, TCovg.SortOrder
	END

	IF(@sectionId = 'bill_clst')
	BEGIN
		SELECT	
			BILLNO = TBDTB.BILLNO,
			POLNO = TPOLC.POLNO,
			SUBOFFICE = TBDTB.SUBOFFCODE,
			PRODCODE = TCMDT.PRODCODE,
			Producer = SUBSTRING( TCMDT.PRDUCODE + ' ' + RTRIM(TPRDC.PRDUNAME), 1, 30),
			Commission = SUM(TCMDT.COMMAMT),
			DueMonth = MAX(TCMDT.COMMMDPERD),
			TranDate = CONVERT(CHAR(10), MAX(TCMDT.TRANDTE), 111),
			PaidDate = CONVERT(CHAR(10), MAX(TCMDT2.COMMPAIDTE), 111),
			Withheld = '0'
  		from	TBILDETB	TBDTB
		inner join  TPOLICY		TPOLC
			on	TPOLC.POLNO		= @policyNo
			AND	TBDTB.COMPCODE		= TPOLC.COMPCODE
			AND	TBDTB.CLNTCODE		= TPOLC.CLNTCODE
		LEFT join  TCOMMDTL	TCMDT
			on	TCMDT.POLNO		= TPOLC.POLNO
			AND	TCMDT.COMMTYPE		= 'D1'
			AND	TCMDT.SUBOFFCODE	= TBDTB.SUBOFFCODE
			AND	( (TCMDT.TRANDTE		>= TBDTB.BISSDATE 
				AND ISNULL(TCMDT.BILLNO,'DDDDDDDD' )  =  'DDDDDDDD' )
				OR     ISNULL(TCMDT.BILLNO,'DDDDDDDD' ) = TBDTB.BILLNO )
			AND	TCMDT.COMMMDPERD	= (
				SELECT	MAX( DATEPART( YY, BILLPRDFR ) * 100 + DATEPART( MM, BILLPRDFR ) )
				FROM	TBILDETP
				WHERE	COMPCODE	= TBDTB.COMPCODE
				AND	CLNTCODE	= TBDTB.CLNTCODE
				AND	BILLNO		= TBDTB.BILLNO
				AND	SUBOFFCODE	= TBDTB.SUBOFFCODE
			)
		LEFT JOIN 	TCOMMDTL TCMDT2
			on	TCMDT2.POLNO = TPOLC.POLNO
			AND	TCMDT2.COMMTYPE	= 'P1'
			AND	TCMDT2.SUBOFFCODE = TBDTB.SUBOFFCODE
			AND    (TCMDT2.PYMTNO IN (	SELECT TPYBL.PYMTNO
							FROM  TPYMTBIL TPYBL
							WHERE TPYBL.CLNTCODE 	= TBDTB.CLNTCODE
							AND   TPYBL.BILLNO	= TBDTB.BILLNO )
				OR      TCMDT2.PYMTNO IS NULL )
			AND	TCMDT2.COMMMDPERD	= (
				SELECT	MAX( DATEPART( YY, BILLPRDFR ) * 100 + DATEPART( MM, BILLPRDFR ) )
				FROM	TBILDETP
				WHERE	COMPCODE	= TBDTB.COMPCODE
				AND	CLNTCODE	= TBDTB.CLNTCODE
				AND	BILLNO		= TBDTB.BILLNO
				AND	SUBOFFCODE	= TBDTB.SUBOFFCODE
			)
			AND	TCMDT2.PRDUCODE <> 'XXXXX00000'
		LEFT JOIN  TPRODUCER TPRDC on TPRDC.PRDUCODE	= TCMDT.PRDUCODE
		WHERE TCMDT.PRDUCODE IS NOT NULL
		group by	TPOLC.POLNO, TBDTB.BILLNO, TBDTB.SUBOFFCODE, TCMDT.PRODCODE, SUBSTRING( TCMDT.PRDUCODE + ' ' + RTRIM(TPRDC.PRDUNAME), 1, 30)
		order by	TPOLC.POLNO, TBDTB.BILLNO, TBDTB.SUBOFFCODE, TCMDT.PRODCODE, SUBSTRING( TCMDT.PRDUCODE + ' ' + RTRIM(TPRDC.PRDUNAME), 1, 30)

	END

	IF(@sectionId = 'bill_mlst')
	BEGIN
		SELECT 
			BILLNO = TBdtm.BILLNO,
			POLNO = TBdtm.POLNO,
			SUBOFFICE = TBdtm.SUBOFFCODE,
			CertNo = TMemb.certno,  
			Name = RTRIM(TMemb.NAMELAST),
			Department = TBdtm.DEPARTCD + ' ' + TDept.DeptName,
			Product = TBdtm.PRODCODE,
			[Plan] = TBdtm.BENPLNCD,
			Coverage = TBdtm.COVGCODE,
			Age = TBdtm.MBAGE,
			MODALPREM = TBdtm.PREMDU,
			AJUSTPREM = TBdtm.PREMDUAD,
			ModalLoading = TBdtm.PRMLOADMOD,
			AjustLoading = TBdtm.PRMLOADADJ,
			ContributionAmt = TBdtm.CONTAMTMB,
			ADVEXPREFUND = TBdtm.EXPREFD - TBdtm.PRYREXPRFD,
			PRYRSEXPREFUND = TBdtm.PRYREXPRFD,
			DepType = N'员工',
			TBdtm.DEPCODE,
			TCovg.SortOrder
		from TMEMBER  TMemb,
			tcoverage TCovg,
 			TBILDETM  TBdtm
			left outer join TDEPARTMENT TDept
				on TDept.ClntCode = TBdtm.ClntCode
				and TDept.SubOffCode = TBdtm.SubOffCode
				and TDept.DeptCode = TBdtm.DEPARTCD
				and TDept.RcdSts = 'A'
		where TBdtm.CLNTCODE = TMemb.CLNTCODE
		and TBdtm.POLNO    = @policyNo
		and TBdtm.depcode  = 1
		and TBdtm.CERTNO   =   TMemb.CERTNO
		and TMemb.SUBOFFCODE = TBdtm.SUBOFFCODE
		and TMemb.RCDSTS   =   'A'
		and TMemb.effdate  = (select max(effdate)
							 from tmember mem1
							 where mem1.clntcode    = TMemb.clntcode
							   and mem1.certno      = TMemb.certno
							   and mem1.suboffcode  = TMemb.suboffcode
							   and mem1.rcdsts      = 'A')
		and TMemb.chgeffdt = (select max(chgeffdt)
							 from tmember mem1
							 where mem1.clntcode    = TMemb.clntcode
							   and mem1.certno      = TMemb.certno
							   and mem1.suboffcode  = TMemb.suboffcode
							   and mem1.effdate     = TMemb.effdate
							   and mem1.rcdsts      = 'A')
		and	TBdtm.COVGCODE = TCovg.COVGCODE
		UNION
		SELECT
			TBdtm.BILLNO,
			TBdtm.POLNO,
			TBdtm.SUBOFFCODE,
			TDEP.certno,
			RTRIM(TDEP.NAMELAST),
			TBdtm.DEPARTCD + ' ' + TDept.DeptName,
			TBdtm.PRODCODE,
			TBdtm.BENPLNCD,
			TBdtm.COVGCODE,
			TBdtm.MBAGE,
			TBdtm.PREMDU,
			TBdtm.PREMDUAD,
			TBdtm.PRMLOADMOD,
			TBdtm.PRMLOADADJ,
			TBdtm.CONTAMTMB,
			TBdtm.EXPREFD - TBdtm.PRYREXPRFD,
			TBdtm.PRYREXPRFD,
			DepType.DEPDESC,
			TBdtm.depcode,
			TCovg.SortOrder
		from TDEPENDENT TDEP
			left join TDEPTYPE DepType 
				on TDEP.DEPTYPE = DepType.DEPTYPE,
			tcoverage TCovg,
			TBILDETM  TBdtm
	
			left outer join TDEPARTMENT TDept
				on     TDept.ClntCode = TBdtm.ClntCode
				and     TDept.SubOffCode = TBdtm.SubOffCode
				and     TDept.DeptCode = TBdtm.DEPARTCD
				and     TDept.RcdSts = 'A'
		where TBdtm.CLNTCODE = TDEP.CLNTCODE
		and TBdtm.POLNO    = @policyNo
		and TBdtm.DEPCODE  >1
		and TBdtm.CERTNO   =   TDEP.CERTNO
		and TDEP.DEPCODE  =   TBdtm.DEPCODE
		and TDEP.RCDSTS   =   'A'
		and TDEP.effdate  =
				   (select max(effdate)
					from TDEPENDENT TDEP1
					where TDEP1.clntcode    = TDEP.clntcode
					  and TDEP1.certno      = TDEP.certno
					  and TDEP1.DEPCODE     = TDEP.DEPCODE
					  and TDEP1.rcdsts      = 'A')
		and TDEP.chgeffdt    =
				   (select max(chgeffdt)
					from TDEPENDENT TDEP1
					where TDEP1.clntcode    = TDEP.clntcode
					  and TDEP1.certno      = TDEP.certno
					  and TDEP1.DEPCODE     = TDEP.DEPCODE
					  and TDEP1.effdate     = TDEP.effdate
					  and TDEP1.rcdsts      = 'A')
		and	TBdtm.COVGCODE = TCovg.COVGCODE
		order by 1, 2, 3, 4, 19
	END
END