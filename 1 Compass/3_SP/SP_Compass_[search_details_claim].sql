if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[search_details_claim]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
     drop procedure [dbo].[search_details_claim]
GO

CREATE PROCEDURE [dbo].[search_details_claim]
(
	@sectionId	VARCHAR(20),
	@policyNo	VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON
	if(@sectionId = 'claim_base')
	begin
		SELECT	TotalAmountBilled = Sum(ISNULL(T3.AmountBilled,0)), 
				TotalAmountPaid = Sum(ISNULL(T3.AmountPaid,0)),
				TotalAmountCovered = Sum(ISNULL(T3.AmountCovered,0)), 
				TotalAmountDeclined = Sum(ISNULL(T3.AmountDeclined,0)),
				TotalSFAmountPaid = Sum(ISNULL(T4.MembSFAmt,0)), 
				TotalAmountReimb = Sum(ISNULL(T3.amountpaid,0) - ISNULL(T4.MembSFAmt, 0))
        FROM  tclaimsummary T1  
        INNER JOIN TClaimTransaction T2 On T1.POLNO = @policyNo and T2.ClaimNo  = T1.ClaimNo and T1.Rcdsts = 'A' and T2.Rcdsts = 'A'
        LEFT JOIN tclaimline T3  On T1.ClaimNo = T3.ClaimNo and T2.ClaimTransno =T3.ClaimTransNo
        LEFT JOIN TClaimlinedtl T4  On T4.claimno = T1.claimno and T4.claimtransno= T2.claimtransno  and T4.claimlineno = T3.claimlineno
	end
	
	if(@sectionId = 'claim_list')
	begin
		select 
            --ClaimType = '{0}',
            ClaimNo = Csum.ClaimNo, 
            [Status] = Case When Ctrn.ClaimTransStatus = 'P' Then N'待处理'
                        When Ctrn.ClaimTransStatus = 'R' Then N'已处理'
                        When Ctrn.ClaimTransStatus = 'H' Then N'历史'
                        --When Ctrn.ClaimTransStatus = 'B' Then 'Batch'
                        When Ctrn.ClaimTransStatus = 'C' Then N'已取消'
                        When Ctrn.ClaimTransStatus = 'L' Then N'已记录'
                    Else N'其他' End,
            ClaimTransLine = Clin.ClaimLineNo,
            SubOffice = CTrn.SubOffCode,
            DepCode = CSum.depcode,
            ProductCode = CSum.ProdCode,
            BenCode = clin.bencode,
            DateNotified = CSum.DateNotified,
            LossDate = Csum.LossDate,
            FromDate = clin.datefrom,

            ToDate = clin.dateto,
            PrimDiag = CASE WHEN CSum.diagnosis IS NOT NULL 
                    THEN RTRIM(CSum.diagnosis)+' - '+ RTRIM(diag1.DXDescription) ELSE NULL END,
            SecondDiag = CASE WHEN Clin.SecondDiag IS NOT NULL and RTRIM(Clin.SecondDiag) <> CSum.diagnosis
                    THEN RTRIM(Clin.SecondDiag)+' - '+ RTRIM(diag2.DXDescription) ELSE NULL END,
            BilledAmt = clin.AmountBilled,
            CoPayAmt = cld.copayamt,
            ReimbAmt = ISNULL(Clin.amountpaid,0) - ISNULL(cld.MembSFAmt, 0),
            PaidAmt = Clin.AmountPaid,
            DeductedAmt = Clin.AmountDeducted,
            DeclinedAmt = Clin.AmountDeclined,
            MemberShortfall = cld.MembSFAmt,

            RMK1 = CASE WHEN RTRIM(Clin.Remark1) IS NOT NULL THEN RTRIM(Clin.Remark1)+' - '+RTRIM(rem1.RemarkText) ELSE NULL END,
            RMK2 = CASE WHEN RTRIM(Clin.Remark2) IS NOT NULL THEN RTRIM(Clin.Remark2)+' - '+RTRIM(rem2.RemarkText) ELSE NULL END,
            ProvNo = clin.ProviderNo,
            eClaimSubmissionDate = CSum.DateNotified,
            EnterDate = CTrn.DateEntered,
            PaidDate = Ctrn.datepaid,
            HoldDate = CTrn.HoldClmDte,
            ReleaseDate = CTrn.RlseClmDte,
            PayeeInd = Clin.PayeeIndicator,
            AnlyId = CTrn.Anlyind,

            InvoiceNo = CTrn.InvoiceNo,
            Exgratia = Case When Ctrn.Exgratia = 1 Then 'Y'
		                        When Ctrn.Exgratia = 0 Then 'N' End ,
            NotesIndicator = Case When TNot.NoteText is null then 'N' Else 'Y' End,
            Reimb = Clin.CopaymentPercent,
            CoveredAmt = Clin.AmountCovered,
            DiscountedAmt = Clin.AmountDiscounted,
            OtherCompCov = Clin.AmountOthCompCov,
            OtherCompPaid =Clin.AmountOthCompPaid,
            CobSavings =  Clin.AmountCOB,
            OutstandReserve = Csum.OSReserve,
            PrecertDays = CSum.PrecertDays,
            Caveout = Clin.AmountCOBCarveout,
            Subrogatior = Clin.AmountCOBSubrogat,
            WithheldAmt = Clin.AmountWithheld,
            TaxAmt = Clin.TaxAmount,
            SpecialHandling = CTrn.SpecialHandling,
            GISClaimNo = CSum.GISCLAIMNO,
            PaymentType = CASE	WHEN	CTrn.PaymentType = 'E'	THEN N'转账'
		                        WHEN	CTrn.PaymentType = 'C'	THEN N'支票'
		                        ELSE	N'其他' END,
            GatewayCompany = SUBSTRING('0000',1,4-LEN(convert(varchar(4),CTrn.GateWayComp)))+ RTRIM(convert(varchar(4),CTrn.GateWayComp)) + ' - ' + T2.COMPSHORT,
            ImageSeqNo = t3.IMGSEQNO
		From tclaimsummary CSum  
        Inner Join TClaimTransaction CTrn 
            On CSum.POLNO	= @policyNo
            and	CTrn.ClaimNo 	= CSum.ClaimNo
            and	CSum.Rcdsts	= 'A'
            and	CTrn.Rcdsts	= 'A'
			--and CSum.PRODCODE like '32%'
		Left Join tclaimline clin 
            On CSum.ClaimNo	= CLin.ClaimNo
            and	CTrn.ClaimTransno =CLin.ClaimTransNo
        left join TClaimlinedtl cld
            On cld.claimno	= CSum.claimno 
            and	cld.claimtransno= CTrn.claimtransno
            and	cld.claimlineno	= CLin.claimlineno
        left join TCOMPANY T2 
            On CTrn.GATEWAYCOMP = T2.COMPCODE
            AND	T2.RCDSTS = 'A'
        left join TCLAIMHEADER T3
            On CTrn.ClaimNo= T3.ClaimNo
        Left Join tdiagnosis	diag1 
            On diag1.diagnosis	= CSum.diagnosis
            and	diag1.rcdsts	= 'A'
        Left Join tdiagnosis diag2
            On diag2.diagnosis	= Clin.SecondDiag
            and	diag2.rcdsts	= 'A'
        Left Join TEOBRemarks	rem1 
            On rem1.remarkcode	= Clin.remark1
            and	rem1.rcdsts	= 'A'
        Left Join TEOBRemarks	rem2 
            On rem2.remarkcode	= Clin.remark2
            and	rem2.rcdsts	= 'A'
        Left Join TNotes		TNot 
            On TNot.ClaimNo		= CSum.ClaimNo
            And TNot.RCDSTS		=  'A'

	end
	
	if(@sectionId = 'claim_memb')
	begin
		SELECT DISTINCT DepCode = T1.DepCode, 
			DepType = CASE WHEN T1.DEPCODE = 1 THEN N'员工' ELSE T7.DEPDESC END, 
			InsuredName = CASE WHEN T1.DEPCODE = 1 
						THEN RTRIM(T2.NAMELAST) + ' ' + RTRIM(T2.NAMEFIRST)
						ELSE RTRIM(T3.NAMELAST) + ' ' + RTRIM(T3.NAMEFIRST) END,
			ClientCode = T1.CLNTCODE,
			PolicyNo = T1.POLNO,
			PolicyIniDate = T4.INIEFFDT,
			CertNo = T1.CERTNO,
			MemberIniDate = CASE WHEN T1.DEPCODE = 1 THEN T2.INIEFFDT ELSE T3.INIEFFDT END,
			DOB= CASE WHEN T1.DEPCODE = 1 THEN T2.DOB ELSE T3.DOB END,
			Stat = T5.STATE,
			City = T5.CITY,
			PostalCode = T5.MAILCODE,
			SubOfficeCode = T6.SUBOFFCODE
	    from tclaimsummary t1
	    INNER JOIN TClaimTransaction T6 ON T1.ClaimNo 	= T6.ClaimNo
	         AND	T1.Rcdsts	= 'A'
	         AND	T6.Rcdsts	= 'A'
	         and	T1.POLNO = @policyNo 
	         AND	T1.RCDSTS = 'A'
	    inner JOIN TPOLICY T4 ON T1.POLNO = T4.POLNO
	    inner JOIN TMEMADDR T5 ON T1.CERTNO = T5.CERTNO and t1.CLNTCODE = t5.CLNTCODE
	    LEFT JOIN  (SELECT T2.*,RANK() OVER (PARTITION BY T2.CLNTCODE, T2.CERTNO ORDER BY T2.EFFDATE DESC, T2.CHGEFFDT DESC ) ROWNO
	         FROM TMEMBER T2 
	         INNER JOIN (SELECT DISTINCT CLNTCODE,CERTNO FROM tclaimsummary 
	                    WHERE POLNO = @policyNo AND RCDSTS = 'A') T1 ON T1.CLNTCODE = T2.CLNTCODE
	         AND T1.CERTNO = T2.CERTNO
	         AND T2.EFFDATE <= GETDATE() 
	         AND T2.RCDSTS = 'A') T2 ON T1.CLNTCODE = T2.CLNTCODE 
	         AND T1.CERTNO = T2.CERTNO
	         AND T2.ROWNO = 1
	    LEFT JOIN  (SELECT T2.*,RANK() OVER (PARTITION BY T2.CLNTCODE, T2.CERTNO, T2.DEPCODE ORDER BY T2.EFFDATE DESC, T2.CHGEFFDT DESC ) ROWNO
	         FROM TDEPENDENT T2 
	         INNER JOIN (SELECT DISTINCT CLNTCODE,CERTNO,DEPCODE FROM tclaimsummary 
	                    WHERE POLNO = @policyNo AND RCDSTS = 'A') T1 ON T1.CLNTCODE = T2.CLNTCODE
	         AND T1.CERTNO = T2.CERTNO
	         AND T2.EFFDATE <= GETDATE() 
	         AND T2.RCDSTS = 'A') T3 ON T1.CLNTCODE = T3.CLNTCODE 
	         AND T1.CERTNO = T3.CERTNO
	         AND T1.DEPCODE = T3.DEPCODE
	         AND T3.ROWNO = 1
		LEFT JOIN TDEPTYPE T7 ON T3.DEPTYPE = T7.DEPTYPE 
	end
END