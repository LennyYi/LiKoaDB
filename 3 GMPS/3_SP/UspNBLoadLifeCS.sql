IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = object_id('dbo.UspNBLoadLifeCS') and sysstat & 0xf = 4)
	DROP PROCEDURE dbo.UspNBLoadLifeCS
GO

CREATE PROCEDURE dbo.UspNBLoadLifeCS
(
	@comp_code 	 CHAR(7)
)
AS

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

DECLARE @lpaymodeload_waive CHAR(01)
DECLARE @mpaymodeload_waive CHAR(01)
DECLARE @life_print CHAR(01)
DECLARE @addl_print CHAR(01)
DECLARE @adds_print CHAR(01)
DECLARE @tpdi_print CHAR(01)
DECLARE @ci_print CHAR(01)
DECLARE @ltd_print CHAR(01)
DECLARE @life_paymode	CHAR(01)
DECLARE @lpaymode_loading DECIMAL(13,2)
DECLARE @mpaymode_loading DECIMAL(13,2)
DECLARE @life_ver CHAR(01)
DECLARE @life_uwver CHAR(01)

DECLARE @hsb_print CHAR(01)
DECLARE @hsb_ver CHAR(01)
DECLARE @hsb_hcver CHAR(01)
DECLARE @hsb_uwver CHAR(01)
DECLARE @med_paymode CHAR(01)
DECLARE @mc_print CHAR(01)
DECLARE @mc_ver CHAR(01)
DECLARE @mc_hcver CHAR(01)
DECLARE @mc_uwver CHAR(01)
DECLARE @cSales_Loading CHAR(05)
DECLARE @nSales_Loading DECIMAL(5,4)

DECLARE @nmMOP	INT

DECLARE @W_Employee CHAR(03)
DECLARE @W_Spouse CHAR(03)
DECLARE @W_Child CHAR(03)
DECLARE @W_Maternity CHAR(03)

SELECT @W_Employee = 'MEM',@W_Spouse = 'SPU', @W_Child = 'CHD', @W_Maternity = 'MAT'

--DECLARE @comp_code CHAR(7)
--SELECT @comp_code = @comp_code

SELECT @lpaymodeload_waive = lpaymodeload_waive
,@mpaymodeload_waive = mpaymodeload_waive
,@life_print = life_print
,@addl_print = addl_print
,@adds_print = adds_print
,@tpdi_print = tpdi_print
,@ci_print = ci_print
,@ltd_print = ltd_print
,@life_ver = life_ver
,@life_uwver = life_uwver
,@life_paymode = life_paymode
,@hsb_print = hsb_print
,@hsb_ver = hsb_ver
,@hsb_hcver = hsb_hcver
,@hsb_uwver = hsb_uwver
,@med_paymode = hsbmc_paymode
,@mc_print = mc_print
,@mc_ver = mc_ver
,@mc_hcver = mc_hcver
,@mc_uwver = mc_uwver
,@cSales_Loading = sales_loading
FROM t_ps_ebsetup WHERE comp_code = @comp_code

IF ISNULL(@cSales_Loading,'')=''
BEGIN
	SELECT @cSales_Loading = 0
END

SELECT @nSales_Loading = ROUND(1 + CONVERT(float,@cSales_Loading) / 100,4)

CREATE TABLE #PayModLoading(
	paymode CHAR(01),
	Loading decimal(13,2)
)

CREATE TABLE #CostSum(
	PRODGROUP VARCHAR(05),
	PRODNAME VARCHAR(10),
	COVGCODE CHAR(03),
	plan_no CHAR(03),
	nol INT NULL,
	SA DECIMAL(11,0) NULL,
	ann_prem_rate	DECIMAL(15,4) NULL,
	ann_prem	DECIMAL(13,2) NULL
)

CREATE TABLE #MAP_PROD(
	PRODGROUP VARCHAR(05),
	PRODNAME VARCHAR(10),
	PRODNAMEDesc1	VARCHAR(100),
	PRODNAMEDesc2	VARCHAR(100),
	PRODSEQ	DECIMAL(10,0)
)

INSERT #MAP_PROD VALUES('GL','LIFE','Group Life Scheme','Group Life',1001000000)
INSERT #MAP_PROD VALUES('GL','LIFECP','Group Life Scheme','Conversion Privilege (Group Life)',1001000025)
INSERT #MAP_PROD VALUES('GL','ADDS','Group Life Scheme','Group Accidental Death & Disablement Benefit',1004000000)
INSERT #MAP_PROD VALUES('GL','ADDL','Group Life Scheme','Group Accidental Death & Disablement Benefit',1006000000)
INSERT #MAP_PROD VALUES('GL','TPDI','Group Life Scheme','Group Total & Permanent Disability Income Benefit',1011000000)
INSERT #MAP_PROD VALUES('GL','CI','Group Life Scheme','Group Critical Illness Benefit',1013000000)
INSERT #MAP_PROD VALUES('GL','CICP','Group Life Scheme','Conversion Privilege (Group Critical Illness Benefit)',1014000000)
INSERT #MAP_PROD VALUES('GL','LTD','Group Life Scheme','Group Long Term Disability Benefit',1016000000)


INSERT #MAP_PROD VALUES('GM','HS','Group Medical Scheme','Group Hospitalization & Surgical Benefits',8010000000)
INSERT #MAP_PROD VALUES('GM','SMM','Group Medical Scheme','Group Supplementary Major Medical Benefit',8015010000)
INSERT #MAP_PROD VALUES('GM','EMB','Group Medical Scheme','Group Extended Medical Benefit',8016012000)
INSERT #MAP_PROD VALUES('GM','CP','Group Medical Scheme','Conversion Privilege',8010025000)
INSERT #MAP_PROD VALUES('GM','OP','Group Medical Scheme','Group Outpatient Benefits',8022000000)
INSERT #MAP_PROD VALUES('GM','MAT','Group Medical Scheme','Group Maternity Benefit',8023000000)
INSERT #MAP_PROD VALUES('GM','DENTAL','Group Medical Scheme','Group Dental Benefit',8024000000)
INSERT #MAP_PROD VALUES('GM','CAC','Group Medical Scheme','China Assist Card',8027010000)

CREATE TABLE #MAP_COVG(
	COVGCODE CHAR(03),
	COVGDESC VARCHAR(200),
	COVGSEQ	DECIMAL(2,0)
)

INSERT #MAP_COVG VALUES('MEM','Employee',1)
INSERT #MAP_COVG VALUES('SPU','Spouse',2)
INSERT #MAP_COVG VALUES('CHD','Child',3)
INSERT #MAP_COVG VALUES('MAT','Maternity',4)

IF @lpaymodeload_waive <> 'Y'
BEGIN
	SET @lpaymode_loading = 1.00
END
ELSE
BEGIN
	IF @life_paymode = 1 SET @lpaymode_loading = 1.00
	IF @life_paymode = 2 SET @lpaymode_loading = 1.02
	IF @life_paymode = 3 SET @lpaymode_loading = 1.04
	IF @life_paymode = 4 SET @lpaymode_loading = 1.08
END

IF @mpaymodeload_waive <> 'Y'
BEGIN
	SET @mpaymode_loading = 1.00
END
ELSE
BEGIN
	IF @med_paymode = 1 SET @mpaymode_loading = 1.00
	IF @med_paymode = 2 SET @mpaymode_loading = 1.02
	IF @med_paymode = 3 SET @mpaymode_loading = 1.04
	IF @med_paymode = 4 SET @mpaymode_loading = 1.08
END

IF @med_paymode = 1 SET @nmMOP=12
IF @med_paymode = 2 SET @nmMOP=6
IF @med_paymode = 3 SET @nmMOP=3
IF @med_paymode = 4 SET @nmMOP=1

CREATE TABLE #PLANLIST(
	plan_no varchar(03)
)

IF @life_print = '1' OR @addl_print = '1' OR @adds_print = '1' OR @tpdi_print = '1' OR @ci_print = '1' OR @ltd_print = '1'
BEGIN

	--1. Life
	SELECT life_plan_no as plan_no, 'LIFE' as prod_name,emp_no,life_sum_assu AS assu,sa_gtl_rate as ann_rate,sa_gtl_nel as nel INTO #CostSumDtl 
	FROM t_wp_emp A,t_wp_life_underwriting C
	where a.comp_code = @comp_code AND a.ver_no = @life_ver and @life_print = 1
	and c.comp_code = a.comp_code and c.ver_no = a.ver_no and c.uwver_no = @life_uwver
	UNION ALL	
	SELECT life_plan_no as plan_no, 'LIFECP' as prod_name,emp_no,life_sum_assu AS assu,sa_cpgl_rate as ann_rate,sa_gtl_nel as nel
	FROM t_wp_emp A,t_wp_life_underwriting C
	where a.comp_code = @comp_code AND a.ver_no = @life_ver and @life_print = 1
	and c.comp_code = a.comp_code and c.ver_no = a.ver_no and c.uwver_no = @life_uwver
	UNION ALL
	SELECT addl_plan_no as plan_no, 'ADDL' as prod_name,emp_no,addl_sum_assu AS assu,sa_add_rate as ann_rate,sa_add_nel as nel
	FROM t_wp_emp A,t_wp_life_underwriting C
	where a.comp_code = @comp_code AND a.ver_no = @life_ver and @addl_print = 1
	and c.comp_code = a.comp_code and c.ver_no = a.ver_no and c.uwver_no = @life_uwver
	UNION ALL
	SELECT adds_plan_no as plan_no, 'ADDS' as prod_name,emp_no,adds_sum_assu AS assu,sa_add_rate as ann_rate,sa_add_nel as nel
	FROM t_wp_emp A,t_wp_life_underwriting C
	where a.comp_code = @comp_code AND a.ver_no = @life_ver and @adds_print = 1
	and c.comp_code = a.comp_code and c.ver_no = a.ver_no and c.uwver_no = @life_uwver
	UNION ALL
	SELECT tpdi_plan_no as plan_no, 'TPDI' as prod_name,emp_no,tpdi_sum_assu AS assu,sa_tpd_rate as ann_rate,sa_tpd_nel as nel
	FROM t_wp_emp A,t_wp_life_underwriting C
	where a.comp_code = @comp_code AND a.ver_no = @life_ver and @tpdi_print = 1
	and c.comp_code = a.comp_code and c.ver_no = a.ver_no and c.uwver_no = @life_uwver
	UNION ALL
	SELECT ci_plan_no as plan_no, 'CI' as prod_name,emp_no,ci_sum_assu AS assu,sa_ci_rate as ann_rate,sa_ci_nel as nel
	FROM t_wp_emp A,t_wp_life_underwriting C
	where a.comp_code = @comp_code AND a.ver_no = @life_ver and @ci_print = 1
	and c.comp_code = a.comp_code and c.ver_no = a.ver_no and c.uwver_no = @life_uwver
	UNION ALL
	SELECT ci_plan_no as plan_no, 'CICP' as prod_name,emp_no,ci_sum_assu AS assu,sa_cpci_rate as ann_rate,sa_ci_nel as nel
	FROM t_wp_emp A,t_wp_life_underwriting C
	where a.comp_code = @comp_code AND a.ver_no = @life_ver and @ci_print = 1
	and c.comp_code = a.comp_code and c.ver_no = a.ver_no and c.uwver_no = @life_uwver	
	UNION ALL
	SELECT ltd_plan_no as plan_no, 'LTD' as prod_name,emp_no,ltd_sum_assu AS assu,sa_ltd_rate as ann_rate,sa_ltd_nel as nel
	FROM t_wp_emp A,t_wp_life_underwriting C
	where a.comp_code = @comp_code AND a.ver_no = @life_ver and @ltd_print = 1
	and c.comp_code = a.comp_code and c.ver_no = a.ver_no and c.uwver_no = @life_uwver

	UPDATE #CostSumDtl SET ann_rate = ROUND(ann_rate * @lpaymode_loading,3)

	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,SA,ann_prem_rate,ann_prem)
	SELECT 'GL',prod_name,@W_Employee,plan_no,COUNT(DISTINCT emp_no) as nol,SUM(assu),MAX(ann_rate),ROUND(SUM(ann_rate * assu)/1000,2) as ann_prem FROM #CostSumDtl WHERE plan_no<>'' 
	GROUP BY prod_name,plan_no
	
	DROP TABLE #CostSumDtl
END

--2. IN
IF @hsb_print = '1'
BEGIN

	DECLARE @cHSBComm_Factor CHAR(05)
	DECLARE @cHSBSales_Loading CHAR(05)	--Not used
	DECLARE @nHSBComm_Factor DECIMAL(5,3)
	EXEC po_ebps_med_commfactor @comp_code,@hsb_ver,@hsb_hcver,@hsb_uwver,@cHSBComm_Factor OUTPUT,@cHSBSales_Loading OUTPUT
	--EXEC po_ebps_med_commfactor '0021199', 'Q',1,1,@cHSBComm_Factor OUTPUT,@cHSBSales_Loading OUTPUT
	SELECT @nHSBComm_Factor = CONVERT(float,@cHSBComm_Factor)
	--SELECT @nHSBComm_Factor,@nSales_Loading

	--SELECT 'DEBUG',@mpaymode_loading,@nHSBComm_Factor,@nSales_Loading,@nmMOP

	--2.1 Group Medical

	--2.1.1 In-patient
	INSERT #CostSum			--Employee
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','HS',@W_Employee as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(emp_cnt,0)) as nol
	,SUM((ROUND(Round(rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihe * 4,0) / 4 * @nmMOP) + ROUND(Round(ecb_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihe * 4,0) / 4 * @nmMOP) as ann_prem_rate
	,ROUND(SUM(isnull(emp_cnt,0)) * SUM((ROUND(Round(rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihe * 4,0) / 4 * @nmMOP) + ROUND(Round(ecb_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihe * 4,0) / 4 * @nmMOP),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no, t_med_versetting B
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	GROUP BY LEFT(A.plan_no,3)

	INSERT #CostSum			--Spouse
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','HS',@W_Spouse as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(spouse_cnt,0)) as nol
	,SUM((ROUND(Round(rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihs * 4,0) / 4 * @nmMOP))
	,ROUND(SUM(isnull(spouse_cnt,0)) * SUM((ROUND(Round(rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihs * 4,0) / 4 * @nmMOP)),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no, t_med_versetting B
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	GROUP BY LEFT(A.plan_no,3)

	INSERT #CostSum			--Child
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','HS',@W_Child as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(child_cnt,0)) as nol
	,SUM((ROUND(Round(rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihk * 4,0) / 4 * @nmMOP))
	,ROUND(SUM(isnull(child_cnt,0)) * SUM((ROUND(Round(rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihk * 4,0) / 4 * @nmMOP)),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no, t_med_versetting B
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	GROUP BY LEFT(A.plan_no,3)

	--2.1.2 Out-patient
	INSERT #CostSum			--Employee
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','OP',@W_Employee as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(emp_cnt,0)) as nol
	,SUM((ROUND(Round(rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ope * 4,0) / 4 * @nmMOP))
	,ROUND(SUM(isnull(emp_cnt,0)) * SUM((ROUND(Round(rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ope * 4,0) / 4 * @nmMOP)),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no, t_med_versetting B
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%OP'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	GROUP BY LEFT(A.plan_no,3)

	INSERT #CostSum			--Spouse
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','OP',@W_Spouse as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(spouse_cnt,0)) as nol
	,SUM((ROUND(Round(rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ops * 4,0) / 4 * @nmMOP))
	,ROUND(SUM(isnull(spouse_cnt,0)) * SUM((ROUND(Round(rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ops * 4,0) / 4 * @nmMOP)),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no, t_med_versetting B
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%OP'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	GROUP BY LEFT(A.plan_no,3)

	INSERT #CostSum			--Child
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','OP',@W_Child as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(child_cnt,0)) as nol
	,SUM((ROUND(Round(rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_opk * 4,0) / 4 * @nmMOP))
	,ROUND(SUM(isnull(child_cnt,0)) * SUM((ROUND(Round(rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_opk * 4,0) / 4 * @nmMOP)),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no, t_med_versetting B
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%OP'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	GROUP BY LEFT(A.plan_no,3)


	--2.2. Other Benefits	
	--INSERT #CostSum			--Employee
	--(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	--SELECT 'OB' as Section,@W_Employee as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(emp_cnt,0)) as nol
	--,ROUND(SUM(isnull(emp_cnt,0)) * SUM((ROUND(Round(emb_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_embe * 4,0) / 4 * @nmMOP)),2) 
	--+ ROUND(SUM(isnull(emp_cnt,0)) * SUM((ROUND(Round(smm_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_smme * 4,0) / 4 * @nmMOP)),2) 
	--+ ROUND(SUM(isnull(marriedcnt,0)) * SUM((ROUND(Round(mat_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * 1 * 4,0) / 4 * @nmMOP)),2) 
	--+ ROUND(SUM(isnull(emp_cnt,0)) * SUM((ROUND(Round(dental_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_dene * 4,0) / 4 * @nmMOP)),2) 
	--+ ROUND(SUM(isnull(emp_cnt,0)) * SUM((ROUND(Round(cac_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihe * 4,0) / 4 * @nmMOP)),2) 
	--+ ROUND(SUM(isnull(emp_cnt,0)) * SUM((ceiling(ceiling(cp_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4) / 4 * B.factor_ihe * 4) / 4 * @nmMOP)),2)	
	--as ann_prem
	--FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no, t_med_versetting B
	--WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	--AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	--GROUP BY LEFT(A.plan_no,3)

	--1.Employee
	INSERT #CostSum			
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','EMB',@W_Employee as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(emp_cnt,0)) as nol
	,SUM((ROUND(Round(emb_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_embe * 4,0) / 4 * @nmMOP))
	,ROUND(SUM(isnull(emp_cnt,0)) * SUM((ROUND(Round(emb_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_embe * 4,0) / 4 * @nmMOP)),2)	as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no, t_med_versetting B
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	GROUP BY LEFT(A.plan_no,3)
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','SMM',@W_Employee as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(emp_cnt,0)) as nol
	,SUM((ROUND(Round(smm_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_smme * 4,0) / 4 * @nmMOP))
	,ROUND(SUM(isnull(emp_cnt,0)) * SUM((ROUND(Round(smm_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_smme * 4,0) / 4 * @nmMOP)),2)	as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no, t_med_versetting B
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	GROUP BY LEFT(A.plan_no,3)
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','MAT',@W_Maternity as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(marriedcnt,0)) as nol
	,SUM((ROUND(Round(mat_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * 1 * 4,0) / 4 * @nmMOP))
	,ROUND(SUM(isnull(marriedcnt,0)) * SUM((ROUND(Round(mat_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * 1 * 4,0) / 4 * @nmMOP)),2) as ann_prem	
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no, t_med_versetting B
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	GROUP BY LEFT(A.plan_no,3)
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','DENTAL',@W_Employee as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(emp_cnt,0)) as nol
	,SUM((ROUND(Round(dental_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_dene * 4,0) / 4 * @nmMOP))
	,ROUND(SUM(isnull(emp_cnt,0)) * SUM((ROUND(Round(dental_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_dene * 4,0) / 4 * @nmMOP)),2)	as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no, t_med_versetting B
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	GROUP BY LEFT(A.plan_no,3)	
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','CAC',@W_Employee as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(emp_cnt,0)) as nol
	,SUM((ROUND(Round(cac_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihe * 4,0) / 4 * @nmMOP))
	,ROUND(SUM(isnull(emp_cnt,0)) * SUM((ROUND(Round(cac_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihe * 4,0) / 4 * @nmMOP)),2) 	as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no, t_med_versetting B
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	GROUP BY LEFT(A.plan_no,3)
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','CP',@W_Employee as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(emp_cnt,0)) as nol
	,SUM((ceiling(ceiling(cp_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4) / 4 * B.factor_ihe * 4) / 4 * @nmMOP))
	,ROUND(SUM(isnull(emp_cnt,0)) * SUM((ceiling(ceiling(cp_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4) / 4 * B.factor_ihe * 4) / 4 * @nmMOP)),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no, t_med_versetting B
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	GROUP BY LEFT(A.plan_no,3)
	

	--Spouse
	--INSERT #CostSum			
	--SELECT 'OB' as Section,@W_Spouse as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(spouse_cnt,0)) as nol
	--,ROUND(SUM(isnull(spouse_cnt,0)) * SUM((ROUND(Round(emb_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_embs * 4,0) / 4 * @nmMOP)),2) 
	--+ ROUND(SUM(isnull(spouse_cnt,0)) * SUM((ROUND(Round(smm_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_smms * 4,0) / 4 * @nmMOP)),2) 
	--+ ROUND(SUM(isnull(spouse_cnt,0)) * SUM((ROUND(Round(dental_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_dens * 4,0) / 4 * @nmMOP)),2) 
	--+ ROUND(SUM(isnull(spouse_cnt,0)) * SUM(CASE WHEN cac=2 THEN (ROUND(Round(cac_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihs * 4,0) / 4 * @nmMOP) ELSE 0 END),2)
	--+ ROUND(SUM(isnull(spouse_cnt,0)) * SUM(CASE WHEN cp=2 THEN (ceiling(ceiling(cp_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4) / 4 * B.factor_ihs * 4) / 4 * @nmMOP) ELSE 0 END),2)
	--as ann_prem
	--FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no
	--, t_med_versetting B, t_wp_med1 D
	--WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	--AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	--AND D.comp_code = A.comp_code AND D.ver_no = A.cvgver_no AND D.plan_no = LEFT(A.plan_no,3)	
	--GROUP BY LEFT(A.plan_no,3)	
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','EMB',@W_Spouse as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(spouse_cnt,0)) as nol
	,SUM((ROUND(Round(emb_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_embs * 4,0) / 4 * @nmMOP))
	,ROUND(SUM(isnull(spouse_cnt,0)) * SUM((ROUND(Round(emb_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_embs * 4,0) / 4 * @nmMOP)),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no
	, t_med_versetting B, t_wp_med1 D
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	AND D.comp_code = A.comp_code AND D.ver_no = A.cvgver_no AND D.plan_no = LEFT(A.plan_no,3)	
	GROUP BY LEFT(A.plan_no,3)	
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','SMM',@W_Spouse as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(spouse_cnt,0)) as nol
	,SUM((ROUND(Round(smm_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_smms * 4,0) / 4 * @nmMOP))
	,ROUND(SUM(isnull(spouse_cnt,0)) * SUM((ROUND(Round(smm_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_smms * 4,0) / 4 * @nmMOP)),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no
	, t_med_versetting B, t_wp_med1 D
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	AND D.comp_code = A.comp_code AND D.ver_no = A.cvgver_no AND D.plan_no = LEFT(A.plan_no,3)	
	GROUP BY LEFT(A.plan_no,3)
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','DENTAL',@W_Spouse as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(spouse_cnt,0)) as nol
	,SUM((ROUND(Round(dental_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_dens * 4,0) / 4 * @nmMOP))
	,ROUND(SUM(isnull(spouse_cnt,0)) * SUM((ROUND(Round(dental_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_dens * 4,0) / 4 * @nmMOP)),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no
	, t_med_versetting B, t_wp_med1 D
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	AND D.comp_code = A.comp_code AND D.ver_no = A.cvgver_no AND D.plan_no = LEFT(A.plan_no,3)	
	GROUP BY LEFT(A.plan_no,3)
		
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','CAC',@W_Spouse as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(spouse_cnt,0)) as nol
	,SUM(CASE WHEN cac=2 THEN (ROUND(Round(cac_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihs * 4,0) / 4 * @nmMOP) ELSE 0 END)
	,ROUND(SUM(isnull(spouse_cnt,0)) * SUM(CASE WHEN cac=2 THEN (ROUND(Round(cac_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihs * 4,0) / 4 * @nmMOP) ELSE 0 END),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no
	, t_med_versetting B, t_wp_med1 D
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	AND D.comp_code = A.comp_code AND D.ver_no = A.cvgver_no AND D.plan_no = LEFT(A.plan_no,3)	
	GROUP BY LEFT(A.plan_no,3)
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','CP',@W_Spouse as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(spouse_cnt,0)) as nol
	,SUM(CASE WHEN cp=2 THEN (ceiling(ceiling(cp_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4) / 4 * B.factor_ihs * 4) / 4 * @nmMOP) ELSE 0 END)
	,ROUND(SUM(isnull(spouse_cnt,0)) * SUM(CASE WHEN cp=2 THEN (ceiling(ceiling(cp_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4) / 4 * B.factor_ihs * 4) / 4 * @nmMOP) ELSE 0 END),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no
	, t_med_versetting B, t_wp_med1 D
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	AND D.comp_code = A.comp_code AND D.ver_no = A.cvgver_no AND D.plan_no = LEFT(A.plan_no,3)	
	GROUP BY LEFT(A.plan_no,3)

	--Child
	--INSERT #CostSum			
	--SELECT 'OB' as Section,@W_Child as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(child_cnt,0)) as nol
	--,ROUND(SUM(isnull(child_cnt,0)) * SUM((ROUND(Round(emb_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_embk * 4,0) / 4 * @nmMOP)),2) 
	--+ ROUND(SUM(isnull(child_cnt,0)) * SUM((ROUND(Round(smm_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_smmk * 4,0) / 4 * @nmMOP)),2) 
	--+ ROUND(SUM(isnull(child_cnt,0)) * SUM((ROUND(Round(dental_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_denk * 4,0) / 4 * @nmMOP)),2) 
	--+ ROUND(SUM(isnull(child_cnt,0)) * SUM(CASE WHEN cac=2 THEN (ROUND(Round(cac_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihk * 4,0) / 4 * @nmMOP) ELSE 0 END),2)
	--+ ROUND(SUM(isnull(child_cnt,0)) * SUM(CASE WHEN cp=2 THEN (ceiling(ceiling(cp_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4) / 4 * B.factor_ihk * 4) / 4 * @nmMOP) ELSE 0 END),2)
	--as ann_prem
	--FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no
	--, t_med_versetting B, t_wp_med1 D
	--WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	--AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	--AND D.comp_code = A.comp_code AND D.ver_no = A.cvgver_no AND D.plan_no = LEFT(A.plan_no,3)	
	--GROUP BY LEFT(A.plan_no,3)
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','EMB',@W_Child as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(child_cnt,0)) as nol
	,SUM((ROUND(Round(emb_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_embk * 4,0) / 4 * @nmMOP))
	,ROUND(SUM(isnull(child_cnt,0)) * SUM((ROUND(Round(emb_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_embk * 4,0) / 4 * @nmMOP)),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no
	, t_med_versetting B, t_wp_med1 D
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	AND D.comp_code = A.comp_code AND D.ver_no = A.cvgver_no AND D.plan_no = LEFT(A.plan_no,3)	
	GROUP BY LEFT(A.plan_no,3)
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','SMM',@W_Child as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(child_cnt,0)) as nol
	,SUM((ROUND(Round(smm_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_smmk * 4,0) / 4 * @nmMOP))
	,ROUND(SUM(isnull(child_cnt,0)) * SUM((ROUND(Round(smm_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_smmk * 4,0) / 4 * @nmMOP)),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no
	, t_med_versetting B, t_wp_med1 D
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	AND D.comp_code = A.comp_code AND D.ver_no = A.cvgver_no AND D.plan_no = LEFT(A.plan_no,3)	
	GROUP BY LEFT(A.plan_no,3)
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','DENTAL',@W_Child as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(child_cnt,0)) as nol
	,SUM((ROUND(Round(dental_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_denk * 4,0) / 4 * @nmMOP))
	,ROUND(SUM(isnull(child_cnt,0)) * SUM((ROUND(Round(dental_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_denk * 4,0) / 4 * @nmMOP)),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no
	, t_med_versetting B, t_wp_med1 D
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	AND D.comp_code = A.comp_code AND D.ver_no = A.cvgver_no AND D.plan_no = LEFT(A.plan_no,3)	
	GROUP BY LEFT(A.plan_no,3)
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','CAC',@W_Child as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(child_cnt,0)) as nol
	,SUM(CASE WHEN cac=2 THEN (ROUND(Round(cac_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihk * 4,0) / 4 * @nmMOP) ELSE 0 END)
	,ROUND(SUM(isnull(child_cnt,0)) * SUM(CASE WHEN cac=2 THEN (ROUND(Round(cac_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4, 0) / 4 * B.factor_ihk * 4,0) / 4 * @nmMOP) ELSE 0 END),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no
	, t_med_versetting B, t_wp_med1 D
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	AND D.comp_code = A.comp_code AND D.ver_no = A.cvgver_no AND D.plan_no = LEFT(A.plan_no,3)	
	GROUP BY LEFT(A.plan_no,3)
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	SELECT 'GM','CP',@W_Child as COVGCODE,LEFT(A.plan_no,3) AS plan_no,SUM(isnull(child_cnt,0)) as nol
	,SUM(CASE WHEN cp=2 THEN (ceiling(ceiling(cp_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4) / 4 * B.factor_ihk * 4) / 4 * @nmMOP) ELSE 0 END)
	,ROUND(SUM(isnull(child_cnt,0)) * SUM(CASE WHEN cp=2 THEN (ceiling(ceiling(cp_rate * @mpaymode_loading * @nHSBComm_Factor * @nSales_Loading * 4) / 4 * B.factor_ihk * 4) / 4 * @nmMOP) ELSE 0 END),2) as ann_prem
	FROM t_wp_med_underwriting A LEFT JOIN t_wp_medhc1 C ON C.comp_code = A.comp_code AND C.cvgver_no = A.cvgver_no AND C.plan_no = LEFT(A.plan_no,3) AND C.ver_no = A.hcver_no
	, t_med_versetting B, t_wp_med1 D
	WHERE A.comp_code = @comp_code AND A.cvgver_no =@hsb_ver AND A.hcver_no = @hsb_hcver AND A.ver_no = @hsb_uwver AND A.plan_no like '%IH'
	AND B.comp_code = A.comp_code AND B.ver_no = A.cvgver_no
	AND D.comp_code = A.comp_code AND D.ver_no = A.cvgver_no AND D.plan_no = LEFT(A.plan_no,3)	
	GROUP BY LEFT(A.plan_no,3)

END

--3. MC
IF @mc_print = '1'
BEGIN
	--2.1.1 In-patient
	INSERT #CostSum			--Employee
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','HS',@W_Employee,plan_no,isnull(emp_cnt,0) as nol
	,(ROUND(Round(ih_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihe * 4,0) / 4 * @nmMOP + ROUND(Round(ecb_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihe * 4,0) / 4 * @nmMOP)
	,ROUND(isnull(emp_cnt,0) * (ROUND(Round(ih_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihe * 4,0) / 4 * @nmMOP + ROUND(Round(ecb_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihe * 4,0) / 4 * @nmMOP),2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no

	INSERT #CostSum			--Spouse
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','HS',@W_Spouse,plan_no,isnull(spouse_cnt,0) as nol
	,ROUND(Round(ih_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihs * 4,0) / 4 * @nmMOP
	,ROUND(isnull(spouse_cnt,0) * ROUND(Round(ih_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihs * 4,0) / 4 * @nmMOP,2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
		
	INSERT #CostSum			--Child
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','HS',@W_Child,plan_no,isnull(child_cnt,0) as nol
	,ROUND(Round(ih_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihk * 4,0) / 4 * @nmMOP
	,ROUND(isnull(child_cnt,0) * ROUND(Round(ih_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihk * 4,0) / 4 * @nmMOP,2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
	
	--2.1.2 Out-patient
	INSERT #CostSum			--Employee
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','OP',@W_Employee,plan_no,isnull(emp_cnt,0) as nol
	,ROUND(Round(op_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihe * 4,0) / 4 * @nmMOP
	,ROUND(isnull(emp_cnt,0) * ROUND(Round(op_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihe * 4,0) / 4 * @nmMOP,2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no

	INSERT #CostSum			--Spouse
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','OP',@W_Spouse,plan_no,isnull(spouse_cnt,0) as nol
	,ROUND(Round(op_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihs * 4,0) / 4 * @nmMOP
	,ROUND(isnull(spouse_cnt,0) * ROUND(Round(op_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihs * 4,0) / 4 * @nmMOP,2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
		
	INSERT #CostSum			--Child
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','OP',@W_Child,plan_no,isnull(child_cnt,0) as nol
	,ROUND(Round(op_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihk * 4,0) / 4 * @nmMOP
	,ROUND(isnull(child_cnt,0) * ROUND(Round(op_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihk * 4,0) / 4 * @nmMOP,2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
	
	--2.2. Other Benefits	
	--INSERT #CostSum			--Employee
	--select 'GM','OB',@W_Employee,plan_no,isnull(emp_cnt,0) as nol
	--,ROUND(isnull(emp_cnt,0) * (ROUND(Round(emb_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_embe * 4,0) / 4 * @nmMOP),2) 
	--+ ROUND(isnull(emp_cnt,0) * (ROUND(Round(smm_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_smme * 4,0) / 4 * @nmMOP),2) 
	--+ ROUND(isnull(marriedcnt,0) * (ROUND(Round(mat_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * 1 * 4,0) / 4 * @nmMOP),2) 
	--+ ROUND(isnull(emp_cnt,0) * (ROUND(Round(den_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_dene * 4,0) / 4 * @nmMOP),2) 
	--+ ROUND(isnull(emp_cnt,0) * (ROUND(Round(cac_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihe * 4,0) / 4 * @nmMOP),2) 
	--+ ROUND(isnull(emp_cnt,0) * (ceiling(ceiling(cp_rate * @mpaymode_loading * @nSales_Loading * 4) / 4 * B.factor_ihe * 4) / 4 * @nmMOP),2)	
	--as ann_prem
	--from t_wp_mc1 A,t_mc_versetting B
	--where A.comp_code = @comp_code and A.ver_no = @mc_ver
	--AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
	
	INSERT #CostSum			--Employee
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','EMB',@W_Employee,plan_no,isnull(emp_cnt,0) as nol
	,(ROUND(Round(emb_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_embe * 4,0) / 4 * @nmMOP)
	,ROUND(isnull(emp_cnt,0) * (ROUND(Round(emb_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_embe * 4,0) / 4 * @nmMOP),2) 	as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
	
	INSERT #CostSum			--Employee
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','SMM',@W_Employee,plan_no,isnull(emp_cnt,0) as nol
	,(ROUND(Round(smm_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_smme * 4,0) / 4 * @nmMOP)
	,ROUND(isnull(emp_cnt,0) * (ROUND(Round(smm_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_smme * 4,0) / 4 * @nmMOP),2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no	
	
	INSERT #CostSum			--Employee
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','MAT',@W_Employee,plan_no,isnull(marriedcnt,0) as nol
	,(ROUND(Round(mat_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * 1 * 4,0) / 4 * @nmMOP)
	,ROUND(isnull(marriedcnt,0) * (ROUND(Round(mat_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * 1 * 4,0) / 4 * @nmMOP),2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no

	INSERT #CostSum			--Employee
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','DENTAL',@W_Employee,plan_no,isnull(emp_cnt,0) as nol
	,(ROUND(Round(den_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_dene * 4,0) / 4 * @nmMOP)
	,ROUND(isnull(emp_cnt,0) * (ROUND(Round(den_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_dene * 4,0) / 4 * @nmMOP),2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
	
	INSERT #CostSum			--Employee
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','CAC',@W_Employee,plan_no,isnull(emp_cnt,0) as nol
	,(ROUND(Round(cac_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihe * 4,0) / 4 * @nmMOP)
	,ROUND(isnull(emp_cnt,0) * (ROUND(Round(cac_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihe * 4,0) / 4 * @nmMOP),2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
	
	INSERT #CostSum			--Employee
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','CP',@W_Employee,plan_no,isnull(emp_cnt,0) as nol
	,(ceiling(ceiling(cp_rate * @mpaymode_loading * @nSales_Loading * 4) / 4 * B.factor_ihe * 4) / 4 * @nmMOP)
	,ROUND(isnull(emp_cnt,0) * (ceiling(ceiling(cp_rate * @mpaymode_loading * @nSales_Loading * 4) / 4 * B.factor_ihe * 4) / 4 * @nmMOP),2)	as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no

	--Spouse
	--INSERT #CostSum			
	--select 'GM','OB',@W_Spouse,plan_no,isnull(spouse_cnt,0) as nol
	--,ROUND(isnull(spouse_cnt,0) * (ROUND(Round(emb_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_embs * 4,0) / 4 * @nmMOP),2) 
	--+ ROUND(isnull(spouse_cnt,0) * (ROUND(Round(smm_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_smms * 4,0) / 4 * @nmMOP),2) 
	--+ ROUND(isnull(spouse_cnt,0) * (ROUND(Round(den_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_dens * 4,0) / 4 * @nmMOP),2) 
	--+ ROUND(isnull(spouse_cnt,0) * CASE WHEN cac=2 THEN (ROUND(Round(cac_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihs * 4,0) / 4 * @nmMOP) ELSE 0 END,2)
	--+ ROUND(isnull(spouse_cnt,0) * CASE WHEN cp=2 THEN (ceiling(ceiling(cp_rate * @mpaymode_loading * @nSales_Loading * 4) / 4 * B.factor_ihs * 4) / 4 * @nmMOP) ELSE 0 END,2)
	--as ann_prem
	--from t_wp_mc1 A,t_mc_versetting B
	--where A.comp_code = @comp_code and A.ver_no = @mc_ver
	--AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','EMB',@W_Spouse,plan_no,isnull(spouse_cnt,0) as nol
	,(ROUND(Round(emb_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_embs * 4,0) / 4 * @nmMOP)
	,ROUND(isnull(spouse_cnt,0) * (ROUND(Round(emb_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_embs * 4,0) / 4 * @nmMOP),2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','SMM',@W_Spouse,plan_no,isnull(spouse_cnt,0) as nol
	,(ROUND(Round(smm_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_smms * 4,0) / 4 * @nmMOP)
	,ROUND(isnull(spouse_cnt,0) * (ROUND(Round(smm_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_smms * 4,0) / 4 * @nmMOP),2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','DENTAL',@W_Spouse,plan_no,isnull(spouse_cnt,0) as nol
	,(ROUND(Round(den_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_dens * 4,0) / 4 * @nmMOP)
	,ROUND(isnull(spouse_cnt,0) * (ROUND(Round(den_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_dens * 4,0) / 4 * @nmMOP),2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','CAC',@W_Spouse,plan_no,isnull(spouse_cnt,0) as nol
	,CASE WHEN cac=2 THEN (ROUND(Round(cac_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihs * 4,0) / 4 * @nmMOP) ELSE 0 END
	,ROUND(isnull(spouse_cnt,0) * CASE WHEN cac=2 THEN (ROUND(Round(cac_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihs * 4,0) / 4 * @nmMOP) ELSE 0 END,2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','CP',@W_Spouse,plan_no,isnull(spouse_cnt,0) as nol
	,CASE WHEN cp=2 THEN (ceiling(ceiling(cp_rate * @mpaymode_loading * @nSales_Loading * 4) / 4 * B.factor_ihs * 4) / 4 * @nmMOP) ELSE 0 END
	,ROUND(isnull(spouse_cnt,0) * CASE WHEN cp=2 THEN (ceiling(ceiling(cp_rate * @mpaymode_loading * @nSales_Loading * 4) / 4 * B.factor_ihs * 4) / 4 * @nmMOP) ELSE 0 END,2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no

	--Child
	--INSERT #CostSum
	--select 'GM','OB',@W_Child,plan_no,isnull(child_cnt,0) as nol
	--,ROUND(isnull(child_cnt,0) * (ROUND(Round(emb_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_embk * 4,0) / 4 * @nmMOP),2) 
	--+ ROUND(isnull(child_cnt,0) * (ROUND(Round(smm_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_smmk * 4,0) / 4 * @nmMOP),2) 
	--+ ROUND(isnull(child_cnt,0) * (ROUND(Round(den_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_denk * 4,0) / 4 * @nmMOP),2) 
	--+ ROUND(isnull(child_cnt,0) * CASE WHEN cac=2 THEN (ROUND(Round(cac_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihk * 4,0) / 4 * @nmMOP) ELSE 0 END,2)
	--+ ROUND(isnull(child_cnt,0) * CASE WHEN cp=2 THEN (ceiling(ceiling(cp_rate * @mpaymode_loading * @nSales_Loading * 4) / 4 * B.factor_ihk * 4) / 4 * @nmMOP) ELSE 0 END,2)
	--as ann_prem
	--from t_wp_mc1 A,t_mc_versetting B
	--where A.comp_code = @comp_code and A.ver_no = @mc_ver
	--AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no

	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','EMB',@W_Child,plan_no,isnull(child_cnt,0) as nol
	,(ROUND(Round(emb_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_embk * 4,0) / 4 * @nmMOP)
	,ROUND(isnull(child_cnt,0) * (ROUND(Round(emb_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_embe * 4,0) / 4 * @nmMOP),2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','SMM',@W_Child,plan_no,isnull(child_cnt,0) as nol
	,(ROUND(Round(smm_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_smmk * 4,0) / 4 * @nmMOP)
	,ROUND(isnull(child_cnt,0) * (ROUND(Round(smm_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_smmk * 4,0) / 4 * @nmMOP),2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','DENTAL',@W_Child,plan_no,isnull(child_cnt,0) as nol
	,(ROUND(Round(den_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_denk * 4,0) / 4 * @nmMOP)
	,ROUND(isnull(child_cnt,0) * (ROUND(Round(den_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_denk * 4,0) / 4 * @nmMOP),2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','CAC',@W_Child,plan_no,isnull(child_cnt,0) as nol
	,CASE WHEN cac=2 THEN (ROUND(Round(cac_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihk * 4,0) / 4 * @nmMOP) ELSE 0 END
	,ROUND(isnull(child_cnt,0) * CASE WHEN cac=2 THEN (ROUND(Round(cac_rate * @mpaymode_loading * @nSales_Loading * 4, 0) / 4 * B.factor_ihk * 4,0) / 4 * @nmMOP) ELSE 0 END,2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no
	
	INSERT #CostSum
	(PRODGROUP,PRODNAME,COVGCODE,plan_no,nol,ann_prem_rate,ann_prem)
	select 'GM','CP',@W_Child,plan_no,isnull(child_cnt,0) as nol
	,CASE WHEN cp=2 THEN (ceiling(ceiling(cp_rate * @mpaymode_loading * @nSales_Loading * 4) / 4 * B.factor_ihk * 4) / 4 * @nmMOP) ELSE 0 END
	,ROUND(isnull(child_cnt,0) * CASE WHEN cp=2 THEN (ceiling(ceiling(cp_rate * @mpaymode_loading * @nSales_Loading * 4) / 4 * B.factor_ihk * 4) / 4 * @nmMOP) ELSE 0 END,2) as ann_prem
	from t_wp_mc1 A,t_mc_versetting B
	where A.comp_code = @comp_code and A.ver_no = @mc_ver
	AND B.comp_code = A.comp_code AND B.ver_no = A.ver_no

END
/*
SELECT * FROM t_mc_versetting where comp_code = @comp_code AND ver_no = 'O'
SELECT ih_rate,ecb_rate,* FROM t_wp_mc1 where comp_code = @comp_code AND ver_no = 'O' and plan_no = '01'
*/
--SELECT * FROM #CostSum ORDER BY PRODGROUP,PRODNAME,COVGCODE,plan_no

SELECT PRODSEQ,COVGSEQ,A.PRODGROUP,A.PRODNAME,B.PRODNAMEDesc1,B.PRODNAMEDesc2,A.COVGCODE,C.COVGDESC,plan_no,nol,SA,ann_prem_rate,ann_prem FROM #CostSum A, #MAP_PROD B, #MAP_COVG C
WHERE B.PRODNAME = A.PRODNAME
AND C.COVGCODE = A.COVGCODE
ORDER BY PRODSEQ,plan_no,COVGSEQ

DROP TABLE #CostSum
DROP TABLE #PayModLoading
