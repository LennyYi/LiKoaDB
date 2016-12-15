IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = object_id('dbo.NOVAUspNBPSGenData') and sysstat & 0xf = 4)
	DROP PROCEDURE dbo.NOVAUspNBPSGenData
GO

CREATE PROCEDURE dbo.NOVAUspNBPSGenData
( 	
	@request_no varchar(30),
	@rpt_request_no	varchar(30)
	--'Pr_Request_20150410_01'
	--'RP-01-20150408-01'
)
AS

/*******************************************************************
	AIA CONFIDENTIAL MARCH 2000

	COMPASS 2000 USER STORED PROCEDURE

	STORED PROCEDURE USED FOR Load default header mapping
	
	AUTHOR		:	Hinson Liang
	DATE		:	04/10/2015
	
REVISION LOG:
PDCF		PROGRAMMER	DATE		CTRL No.	PURPOSE
------------------------------------------------------------------------------------------
			Hinson.L	04/10/2015				Initial
*********************************************************************/

SET NOCOUNT ON



--DECLARE @rpt_request_no varchar(30)

--DEBUG BEGIN
--DECLARE @request_no varchar(30), @staff_code VARchar(10)
--SELECT @request_no='Pr_Request_FM_20150424_01'
--DEBUG END

declare @sql nvarchar(max) 
declare @cGMPSDB varchar(20)
SELECT @cGMPSDB = RTRIM(param_value) FROM teflow_param_config WHERE param_code = 'GMPSDB'

DECLARE @comp_code	char(7)     	     
DECLARE @life_curr	char(3)
DECLARE @hsbmc_curr	char(3)
DECLARE @life_paymode	char(1)
DECLARE @hsbmc_paymode	char(1)
DECLARE @claim_print	char(1)
DECLARE @ibnr	decimal(5,2)
DECLARE @life_print	char(1)
DECLARE @addl_print	char(1)	     	     
DECLARE @adds_print	char(1)	     	     
DECLARE @tpdi_print	char(1)	     	     
DECLARE @ci_print	char(1)	     	     
DECLARE @life_ver	char(1)	     	     
DECLARE @life_uwver	char(1)	     	     
DECLARE @ltd_print	char(1)	     	     
DECLARE @hsb_print	char(1)	     	     
DECLARE @hsb_ver	char(1)	     	     
DECLARE @hsb_hcver	char(1)	     	     
DECLARE @hsb_uwver	char(1)	     	     
DECLARE @mc_print	char(1)
DECLARE @mc_ver	char(1)	     	     
DECLARE @mc_hcver	char(1)	     	     
DECLARE @mc_uwver	char(1)	     	     
DECLARE @cbonly_print	char(1)	     	     
DECLARE @medrateonly_print	char(1)	     	     
DECLARE @done_by	varchar(20)
DECLARE @check_by	varchar(20)
DECLARE @ws_date	datetime	     	
DECLARE @cws_date	char(10)
DECLARE @ps_date	datetime     	     
DECLARE @comm_flat	char(3)	     	     
DECLARE @sales_loading	char(5)	     	     
DECLARE @lpaymodeload_waive	char(1)	     	     
DECLARE @mpaymodeload_waive	char(1)	     	     
DECLARE @BenefitVersion varchar(30)  	     
DECLARE @med_cvg_ver	char(1)	   
DECLARE @MedBenGroup	varchar(10)
DECLARE @TotalAnn_prem	DECIMAL(16,2)
DECLARE @GroupMedSeq	VARCHAR(05)
DECLARE @OtherBenSeq	VARCHAR(05)
DECLARE @MatCode	CHAR(04)
DECLARE @MatDesc	VARCHAR(100)


SELECT @comp_code = field_2_2 FROM teflow_30_2 WHERE request_no = @request_no

SELECT @life_curr = field_5_1, @life_paymode=field_5_2,@lpaymodeload_waive=ISNULL(field_5_3,'N') FROM teflow_30_5 WHERE request_no = @request_no
SELECT @hsbmc_curr = field_6_1, @hsbmc_paymode=field_6_2, @mpaymodeload_waive=ISNULL(field_6_3,'N'),@comm_flat = ps_comm_flat,@sales_loading=isnull(field_6_5,'') FROM teflow_30_6 WHERE request_no = @request_no

SELECT @life_print = 1 FROM teflow_30_20 WHERE request_no = @request_no and field_20_4 like '%1%'
SELECT @life_print = ISNULL(@life_print,'0')
SELECT @addl_print = 1 FROM teflow_30_20 WHERE request_no = @request_no and field_20_4 like '%2%'
SELECT @addl_print = ISNULL(@addl_print,'0')
SELECT @adds_print = 1 FROM teflow_30_20 WHERE request_no = @request_no and field_20_4 like '%3%'
SELECT @adds_print = ISNULL(@adds_print,'0')
SELECT @tpdi_print = 1 FROM teflow_30_20 WHERE request_no = @request_no and field_20_4 like '%4%'
SELECT @tpdi_print = ISNULL(@tpdi_print,'0')
SELECT @ci_print = 1 FROM teflow_30_20 WHERE request_no = @request_no and field_20_4 like '%5%'
SELECT @ci_print = ISNULL(@ci_print,'0')
SELECT @ltd_print = 1 FROM teflow_30_20 WHERE request_no = @request_no and field_20_4 like '%6%'
SELECT @ltd_print = ISNULL(@ltd_print,'0')

SELECT @hsb_print=1 FROM teflow_30_21 WHERE request_no = @request_no and field_21_4 like '%1%'
SELECT @hsb_print = ISNULL(@hsb_print,'0')
SELECT @mc_print=1 FROM teflow_30_22 WHERE request_no = @request_no and field_22_4 like '%1%'
SELECT @mc_print = ISNULL(@mc_print,'0')

SELECT @life_ver = ISNULL(field_20_1,''),@life_uwver = ISNULL(field_20_3,'') FROM teflow_30_20 WHERE request_no = @request_no
SELECT @hsb_ver = ISNULL(field_21_1,''),@hsb_hcver = ISNULL(field_21_2,''), @hsb_uwver = ISNULL(field_21_3,'') FROM teflow_30_21 WHERE request_no = @request_no
SELECT @mc_ver = ISNULL(field_22_1,''),@mc_hcver = ISNULL(field_22_2,''), @mc_uwver = ISNULL(field_22_3,'') FROM teflow_30_22 WHERE request_no = @request_no

DECLARE @MedSchTemplate CHAR(01)	--1 - MC; 2 - IMC; 3 - Indemnity; 4 - Purple Card; 5 - Fullerton
SELECT @MedSchTemplate = field_4_4 FROM teflow_30_4 WHERE request_no = @request_no

SELECT @done_by = submit_staff_code, @check_by = submit_staff_code from teflow_30_1 where request_no = @request_no

SELECT @MatCode = field_23_1 FROM teflow_30_23 WHERE request_no = @request_no

--20150518 begin
--SELECT @MatDesc = RTRIM(LTRIM(REPLACE(option_label,'Cover',''))) FROM teflow_base_data_detail where master_id = '10235' AND option_value = @MatCode
SELECT @MatDesc = RTRIM(LTRIM(REPLACE(option_label,'Cover',''))) FROM teflow_base_data_detail where master_id in (select master_id from teflow_base_data_master where field_name = 'Maternity coverage') 
AND option_value = @MatCode

--20150518 end


--Set default
SELECT @claim_print = 0
SELECT @ibnr = 0
SELECT @cbonly_print = 1
SELECT @medrateonly_print = 1
SELECT @cws_date = CONVERT(CHAR(10),GETDATE(),101)
SELECT @ws_date = @cws_date
SELECT @ps_date = GETDATE()

DECLARE @rtn_code int


SELECT @sql = "EXEC <GMPSDB>..po_ebps_setupsave
@comp_code
,@life_curr
,@hsbmc_curr
,@life_paymode
,@hsbmc_paymode
,@lpaymodeload_waive
,@mpaymodeload_waive
,@life_print
,@addl_print
,@adds_print
,@tpdi_print
,@life_ver
,@life_uwver
,@ci_print
,@ltd_print
,@hsb_print
,@hsb_ver
,@hsb_uwver
,@hsb_hcver
,@comm_flat
,@sales_loading
,@mc_print
,@mc_ver
,@cbonly_print
,@done_by
,@check_by
,@cws_date
,@rtn_code
"
SELECT @sql = REPLACE(@sql,'<GMPSDB>',@cGMPSDB)
exec sp_executesql @sql, N'@comp_code	char(7)
,@life_curr	char(3)
,@hsbmc_curr	char(3)
,@life_paymode	char(1)
,@hsbmc_paymode	char(1)
,@lpaymodeload_waive	char(1)
,@mpaymodeload_waive	char(1)
,@life_print	char(1)
,@addl_print	char(1)
,@adds_print	char(1)
,@tpdi_print	char(1)
,@life_ver		char(1)
,@life_uwver	char(1)
,@ci_print		char(1)
,@ltd_print		char(1)
,@hsb_print		char(1)
,@hsb_ver		char(1)
,@hsb_uwver		char(1)
,@hsb_hcver		char(1)
,@comm_flat		char(3)
,@sales_loading	char(5)
,@mc_print		char(1)
,@mc_ver		char(1)
,@cbonly_print	char(1)
,@done_by	varchar(20)
,@check_by	varchar(20)
,@cws_date	char(10)
,@rtn_code	int'
,@comp_code
,@life_curr
,@hsbmc_curr
,@life_paymode
,@hsbmc_paymode
,@lpaymodeload_waive
,@mpaymodeload_waive
,@life_print
,@addl_print
,@adds_print
,@tpdi_print
,@life_ver
,@life_uwver
,@ci_print
,@ltd_print
,@hsb_print
,@hsb_ver
,@hsb_uwver
,@hsb_hcver
,@comm_flat
,@sales_loading
,@mc_print
,@mc_ver
,@cbonly_print
,@done_by
,@check_by
,@cws_date
,@rtn_code

DECLARE @life_printed CHAR(01)

IF @life_print = '1' OR @addl_print = '1' OR @adds_print = '1' OR @tpdi_print = '1' OR @ci_print = '1' OR @ltd_print = '1'
BEGIN
	SELECT @life_printed = '1'
END
ELSE
BEGIN
	SELECT @life_printed = '0'
END

IF @life_printed = '1'
BEGIN
	SELECT @GroupMedSeq = 'II'
	SELECT @OtherBenSeq = 'III'

	SELECT @sql = "EXEC <GMPSDB>..po_ebps_lifecost
	@comp_code
	,@life_ver
	,@life_uwver"

	SELECT @sql = REPLACE(@sql,'<GMPSDB>',@cGMPSDB)

	exec sp_executesql @sql, N'@comp_code	char(7)
	,@life_ver		char(1)
	,@life_uwver	char(1)'
	,@comp_code
	,@life_ver
	,@life_uwver
	
	SELECT @sql = "EXEC <GMPSDB>..po_ebps_print_history
	@comp_code
	,@life_ver
	,@life_uwver
	,@hsb_ver
	,@hsb_uwver
	,@hsb_hcver
	,@mc_ver
	,@life_printed
	,@hsb_print
	,@mc_print
	,@done_by
	,@check_by
	,@cws_date"
	SELECT @sql = REPLACE(@sql,'<GMPSDB>',@cGMPSDB)
	exec sp_executesql @sql, N'@comp_code	char(7)
	,@life_ver		char(1)
	,@life_uwver	char(1)
	,@hsb_ver		char(1)
	,@hsb_uwver		char(1)
	,@hsb_hcver		char(1)
	,@mc_ver		char(1)
	,@life_printed	char(1)
	,@hsb_print		char(1)
	,@mc_print		char(1)
	,@done_by	varchar(20)
	,@check_by	varchar(20)
	,@cws_date	char(10)'
	,@comp_code
	,@life_ver
	,@life_uwver
	,@hsb_ver
	,@hsb_uwver
	,@hsb_hcver
	,@mc_ver
	,@life_printed
	,@hsb_print
	,@mc_print
	,@done_by
	,@check_by
	,@cws_date
END
ELSE
BEGIN
	SELECT @GroupMedSeq = 'I'
	SELECT @OtherBenSeq = 'II'
END


--3. Gen Cover page data
DECLARE @ptCover_CompanyName nvarchar(100)
DECLARE @lann_date DATETIME
DECLARE @ab_name VARCHAR(30)


SELECT @sql = "SELECT @ptCover_CompanyName=comp_name,@lann_date=lann_date,@ab_name=ab_name FROM <GMPSDB>..t_wp_comp WHERE comp_code = @comp_code"
SELECT @sql = REPLACE(@sql,'<GMPSDB>',@cGMPSDB)
exec sp_executesql @sql, N'@comp_code char(7),@ptCover_CompanyName nvarchar(100) OUTPUT, @lann_date DATETIME OUTPUT,@ab_name VARCHAR(30) OUTPUT',@comp_code,@ptCover_CompanyName OUTPUT,@lann_date OUTPUT,@ab_name OUTPUT


SELECT @BenefitVersion = A.option_label FROM teflow_base_data_detail A, teflow_30_4 B
WHERE master_id in (SELECT master_id FROM teflow_base_data_master WHERE field_name = 'Benefit Options')
AND B.field_4_3 = A.option_value
AND B.request_no = @request_no

DELETE teflow_report_2_1 WHERE request_no=@rpt_request_no

INSERT teflow_report_2_1 
(VarName,VarValue,RemarkCode,Editable,request_no)
VALUES('@Param1',@ptCover_CompanyName,'','N',@rpt_request_no)

INSERT teflow_report_2_1 
(VarName,VarValue,RemarkCode,Editable,request_no)
VALUES('@Param2',@BenefitVersion,'','N',@rpt_request_no)

INSERT teflow_report_2_1 
(VarName,VarValue,RemarkCode,Editable,request_no)
VALUES('@Param3',CONVERT(VARCHAR(20),GETDATE(),107),'','N',@rpt_request_no)

INSERT teflow_report_2_1 
(VarName,VarValue,RemarkCode,Editable,request_no)
VALUES('@Param4',CONVERT(VARCHAR(20),@lann_date,107),'','N',@rpt_request_no)

INSERT teflow_report_2_1 
(VarName,VarValue,RemarkCode,Editable,request_no)
VALUES('@Param5',@ab_name,'','N',@rpt_request_no)

--4. Gen life BS
DELETE teflow_report_2_7 WHERE request_no = @rpt_request_no
DELETE teflow_report_2_8 WHERE request_no = @rpt_request_no
DELETE teflow_report_2_9 WHERE request_no = @rpt_request_no
DELETE teflow_report_2_10 WHERE request_no = @rpt_request_no

IF CONVERT(INT,@life_print) + CONVERT(INT,@addl_print) + CONVERT(INT,@adds_print)+CONVERT(INT,@tpdi_print)+CONVERT(INT,@ci_print)+CONVERT(INT,@ltd_print) > 0
BEGIN
	INSERT teflow_report_2_7
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@@PrintInd','Y','','N',@rpt_request_no)

	--Header
	INSERT teflow_report_2_7
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@ptCover_CompanyName',@ptCover_CompanyName,'','N',@rpt_request_no)

	INSERT teflow_report_2_7
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@life_curr',@life_curr,'','N',@rpt_request_no)

	--SELECT 'DEBUG', @rpt_request_no,'PS_BS','1',@comp_code,@life_ver,'X'
	
	--Content - Sum Assured
	INSERT teflow_report_2_8
	EXEC NOVAUspLoadBS @request_no,@rpt_request_no,'PS_BS','1',@comp_code,@life_ver,'LF',''
	
	--SELECT 'DEBUG',3

	--Content - Non-evidence limit	
	INSERT teflow_report_2_9
	EXEC NOVAUspLoadNEL @rpt_request_no,'PS_BS_NEL','1',@comp_code,@life_ver

	--Remark variable
	DECLARE @ptCImaxsa VARCHAR(50)
	SELECT @ptCImaxsa = CASE @life_curr WHEN 'HKD' THEN '$2,000,000(HKD)' WHEN 'MOP' THEN '$2,000,000 (MOP)' ELSE '$250,000 (USD)' END
	
	INSERT teflow_report_2_10
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@ptCImaxsa',@ptCImaxsa,'','Y',@rpt_request_no)
END
ELSE
BEGIN
	INSERT teflow_report_2_7
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@@PrintInd','N','','N',@rpt_request_no)
END

--5. II. Group Medical Insurance - HS
--Header
DELETE teflow_report_2_2 WHERE request_no = @rpt_request_no
DELETE teflow_report_2_4 WHERE request_no = @rpt_request_no

IF @hsb_print = 1
BEGIN
	SELECT @med_cvg_ver = @hsb_ver
	SELECT @MedBenGroup = 'IND'
END
ELSE IF @mc_print = '1'
BEGIN
	SELECT @med_cvg_ver = @mc_ver
	SELECT @MedBenGroup = 'MC'
END
ELSE
BEGIN
	SELECT @med_cvg_ver = ''
END

IF @hsb_print='1' or @mc_print = '1'
BEGIN
	INSERT teflow_report_2_2
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@@PrintInd','Y','','N',@rpt_request_no)

	INSERT teflow_report_2_2 
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@ptCover_CompanyName',@ptCover_CompanyName,'','N',@rpt_request_no)
	INSERT teflow_report_2_2 
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@hsbmc_curr',@hsbmc_curr,'','N',@rpt_request_no)

	INSERT teflow_report_2_2 
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@NonNetworkDesc',(CASE WHEN @MedSchTemplate = 2 OR @MedSchTemplate = 4 THEN '(Non-Network only)' ELSE '' END),'','N',@rpt_request_no)	
	
	INSERT teflow_report_2_2 
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@GroupMedSeq',@GroupMedSeq,'','N',@rpt_request_no)

	--SELECT 'DEBUG - 050'

	--Content
	INSERT teflow_report_2_4
	EXEC NOVAUspLoadBS @request_no,@rpt_request_no,'PS_BS','8010000000',@comp_code,@med_cvg_ver,@MedBenGroup,@MedSchTemplate

	--Remark variable
	--Nil
END
ELSE
BEGIN
	INSERT teflow_report_2_2
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@@PrintInd','N','','N',@rpt_request_no)
END

--II. Group Medical Insurance - outpatient
--Header
DELETE teflow_report_2_12 WHERE request_no = @rpt_request_no
DELETE teflow_report_2_13 WHERE request_no = @rpt_request_no
DELETE teflow_report_2_14 WHERE request_no = @rpt_request_no

IF @hsb_print='1' or @mc_print = '1'
BEGIN
	INSERT teflow_report_2_12
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@@PrintInd','Y','','N',@rpt_request_no)

	INSERT teflow_report_2_12 
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@ptCover_CompanyName',@ptCover_CompanyName,'','N',@rpt_request_no)
	INSERT teflow_report_2_12 
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@hsbmc_curr',@hsbmc_curr,'','N',@rpt_request_no)
	
	INSERT teflow_report_2_12 
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@GroupMedSeq',@GroupMedSeq,'','N',@rpt_request_no)

	--Content
	INSERT teflow_report_2_13
	EXEC NOVAUspLoadBS @request_no,@rpt_request_no,'PS_BS','8022000000',@comp_code,@med_cvg_ver,@MedBenGroup,@MedSchTemplate

	--Remark variable
	DECLARE @opmaxvisit smallint
	DECLARE @waive_OPSC_rmk varchar(250)

	IF @hsb_print = 1
	BEGIN
		SELECT @sql = "SELECT @opmaxvisit=opmaxvisit,@waive_OPSC_rmk=opsc_waive_rmk FROM <GMPSDB>..t_wp_med1 WHERE comp_code = @comp_code AND ver_no = @med_cvg_ver"
		SELECT @sql = REPLACE(@sql,'<GMPSDB>',@cGMPSDB)
		exec sp_executesql @sql, N'@comp_code char(7),@med_cvg_ver char(1),@opmaxvisit smallint OUTPUT,@waive_OPSC_rmk varchar(250) OUTPUT',@comp_code,@med_cvg_ver,@opmaxvisit OUTPUT,@waive_OPSC_rmk OUTPUT
	END
	ELSE
	BEGIN
		SELECT @sql = "SELECT @opmaxvisit=opmaxvisit,@waive_OPSC_rmk=opsc_waive_rmk FROM <GMPSDB>..t_wp_mc1 WHERE comp_code = @comp_code AND ver_no = @med_cvg_ver"
		SELECT @sql = REPLACE(@sql,'<GMPSDB>',@cGMPSDB)
		exec sp_executesql @sql, N'@comp_code char(7),@med_cvg_ver char(1),@opmaxvisit smallint OUTPUT,@waive_OPSC_rmk varchar(250) OUTPUT',@comp_code,@med_cvg_ver,@opmaxvisit OUTPUT,@waive_OPSC_rmk OUTPUT
	END

	INSERT teflow_report_2_14
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@opmaxvisit',CONVERT(VARCHAR(20),@opmaxvisit),'','N',@rpt_request_no)

	INSERT teflow_report_2_14
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@hsbmc_curr',@hsbmc_curr,'','N',@rpt_request_no)

	INSERT teflow_report_2_14
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@waive_OPSC_rmk',@waive_OPSC_rmk,'','N',@rpt_request_no)
END
ELSE
BEGIN
	INSERT teflow_report_2_12
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@@PrintInd','N','','N',@rpt_request_no)
END

--III. Other Benefits
--Header
DELETE teflow_report_2_15 WHERE request_no = @rpt_request_no
DELETE teflow_report_2_16 WHERE request_no = @rpt_request_no

IF @hsb_print='1' or @mc_print = '1'
BEGIN
	INSERT teflow_report_2_15
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@@PrintInd','Y','','N',@rpt_request_no)

	INSERT teflow_report_2_15
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@ptCover_CompanyName',@ptCover_CompanyName,'','N',@rpt_request_no)
	INSERT teflow_report_2_15
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@hsbmc_curr',@hsbmc_curr,'','N',@rpt_request_no)
	
	INSERT teflow_report_2_15 
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@OtherBenSeq',@OtherBenSeq,'','N',@rpt_request_no)

	--Content
	INSERT teflow_report_2_16
	EXEC NOVAUspLoadBS @request_no,@rpt_request_no,'PS_BS','3',@comp_code,@med_cvg_ver,@MedBenGroup,@MedSchTemplate

	--Remark variable
	--Nil
END
ELSE
BEGIN
	INSERT teflow_report_2_15
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@@PrintInd','N','','N',@rpt_request_no)
END


--5.1 SMM page
DELETE teflow_report_2_24 WHERE request_no = @rpt_request_no
IF EXISTS(SELECT * FROM teflow_report_2_4 WHERE request_no = @rpt_request_no and rowidx = 8015010000)
BEGIN
	INSERT teflow_report_2_24
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@@PrintInd','Y','','N',@rpt_request_no)
END
ELSE
BEGIN
	INSERT teflow_report_2_24
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@@PrintInd','N','','N',@rpt_request_no)
END

--5.2 Valutory Life
DELETE teflow_report_2_22 WHERE request_no = @rpt_request_no

IF EXISTS(SELECT * FROM teflow_30_4 WHERE request_no = @request_no AND field_4_2 LIKE '%L%')
BEGIN
	INSERT teflow_report_2_22
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@@PrintInd','Y','','N',@rpt_request_no)
END
ELSE
BEGIN
	INSERT teflow_report_2_22
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@@PrintInd','N','','N',@rpt_request_no)
END

--5.3 Valutory Medical
DELETE teflow_report_2_21 WHERE request_no = @rpt_request_no
DELETE teflow_report_2_23 WHERE request_no = @rpt_request_no

IF EXISTS(SELECT * FROM teflow_30_4 WHERE request_no = @request_no AND field_4_2 LIKE '%M%')
BEGIN
	INSERT teflow_report_2_21
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@@PrintInd','Y','','N',@rpt_request_no)
	INSERT teflow_report_2_23
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@@PrintInd','Y','','N',@rpt_request_no)
END
ELSE
BEGIN
	INSERT teflow_report_2_21
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@@PrintInd','N','','N',@rpt_request_no)
	INSERT teflow_report_2_23
	(VarName,VarValue,RemarkCode,Editable,request_no)
	VALUES('@@PrintInd','N','','N',@rpt_request_no)
END

--5. ER
--select * from t_wp_life_underwriting where comp_code='" & str_compcode & "' and ver_no='" & str_lifever & "' and uwver_no='" & str_lifeuwver & "'"

--SELECT * FROM t_wp_life_underwriting
--select * from t_wp_meduw_adju

--5. Gen cost summary data
DELETE teflow_report_2_18 WHERE request_no = @rpt_request_no
DELETE teflow_report_2_19 WHERE request_no = @rpt_request_no

CREATE TABLE #CostSummary_2(
	PRODSEQ	DECIMAL(10,0),
	COVGSEQ	DECIMAL(2,0),
	PRODGROUP VARCHAR(05),
	PRODNAME VARCHAR(10),
	PRODNAMEDesc1	VARCHAR(100),
	PRODNAMEDesc2	VARCHAR(100),
	COVGCODE CHAR(03),
	COVGDESC VARCHAR(200),
	plan_no CHAR(03),
	nol INT,
	SA DECIMAL(11,0) NULL,
	ann_prem_rate	DECIMAL(15,4) NULL,
	ann_prem	DECIMAL(13,2)
)

SELECT @sql = "INSERT #CostSummary_2 EXEC <GMPSDB>..UspNBLoadLifeCS @comp_code"
SELECT @sql = REPLACE(@sql,'<GMPSDB>',@cGMPSDB)
exec sp_executesql @sql, N'@comp_code char(7)',@comp_code

UPDATE #CostSummary_2 SET COVGDESC = COVGDESC + '<br>(' + @MatDesc + ')' WHERE COVGCODE = 'MAT'

--Page Header
INSERT teflow_report_2_18
(VarName,VarValue,RemarkCode,Editable,request_no)
VALUES('@@PrintInd','Y','','N',@rpt_request_no)
INSERT teflow_report_2_18
(VarName,VarValue,RemarkCode,Editable,request_no)
VALUES('@ptCover_CompanyName',@ptCover_CompanyName,'','N',@rpt_request_no)
INSERT teflow_report_2_18
(VarName,VarValue,RemarkCode,Editable,request_no)
VALUES('@hsbmc_curr',@hsbmc_curr,'','N',@rpt_request_no)

--Content

DECLARE @W_TYPE_HEADER INT
DECLARE @W_TYPE_ITEMTITLE1 INT
DECLARE @W_TYPE_ITEMTITLE2 INT
DECLARE @W_TYPE_ITEMVALUE1 INT
DECLARE @W_TYPE_ITEMVALUE2 INT

SELECT @W_TYPE_HEADER = 1		--Header
SELECT @W_TYPE_ITEMTITLE1 = 11	--Item title - level 1
SELECT @W_TYPE_ITEMTITLE2 = 12	--Item title - level 2
SELECT @W_TYPE_ITEMVALUE1 = 51	--level 1 title's value
SELECT @W_TYPE_ITEMVALUE2 = 52	--level 2 title's value

DECLARE @plan_no VARCHAR(03)
DECLARE @PRODSEQ DECIMAL(10,0)
DECLARE @COVGDESC VARCHAR(200)
DECLARE @rowidx	DECIMAL(10,0)
DECLARE @COVGSEQ INT

CREATE TABLE #PlanList(
	plan_no		CHAR(03) NOT NULL,
	plan_seq	INT IDENTITY(1,1) NOT NULL
)

INSERT #PlanList(plan_no) SELECT DISTINCT plan_no FROM #CostSummary_2

--Header
INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
VALUES (1,1,'','h0_F04',@W_TYPE_HEADER,'','N','N',@rpt_request_no)
INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
SELECT 1,1+plan_seq*2-1,plan_no,'h0_P10',@W_TYPE_HEADER,'','N','Y',@rpt_request_no FROM #PlanList
INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
SELECT 1,1+plan_seq*2,plan_no,'h0_P10',@W_TYPE_HEADER,'','N','Y',@rpt_request_no FROM #PlanList

--Content
DECLARE CUR_PRD CURSOR FOR
	SELECT DISTINCT A.PRODSEQ FROM #CostSummary_2 A ORDER BY PRODSEQ
OPEN CUR_PRD
FETCH NEXT FROM CUR_PRD INTO @PRODSEQ
WHILE @@fetch_status=0
BEGIN
	SELECT @rowidx = @PRODSEQ

	--Header 2
	INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
	SELECT DISTINCT @rowidx,1,PRODNAMEDesc1 + CASE WHEN PRODNAMEDesc2 = '' THEN '' ELSE '<BR>' + PRODNAMEDesc2 END,'h1_PRD',@W_TYPE_HEADER,'','N','Y',@rpt_request_no
	FROM #CostSummary_2 A
	WHERE PRODSEQ = @PRODSEQ

	INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
	SELECT DISTINCT @rowidx,1 + plan_seq*2-1,PRODNAMEDesc1 + CASE WHEN PRODNAMEDesc2 = '' THEN '' ELSE '<BR>' + PRODNAMEDesc2 END,'h1_PRD',@W_TYPE_HEADER,'','N','Y',@rpt_request_no
	FROM #CostSummary_2 A, #PlanList B
	WHERE PRODSEQ = @PRODSEQ
	
	INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
	SELECT DISTINCT @rowidx,1 + plan_seq*2,PRODNAMEDesc1 + CASE WHEN PRODNAMEDesc2 = '' THEN '' ELSE '<BR>' + PRODNAMEDesc2 END,'h1_PRD',@W_TYPE_HEADER,'','N','Y',@rpt_request_no
	FROM #CostSummary_2 A, #PlanList B
	WHERE PRODSEQ = @PRODSEQ

	--Header 3
	SELECT @rowidx = @rowidx + 1

		--Member Type
		INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
		SELECT DISTINCT @rowidx,1,'Member Type','h2_MT',@W_TYPE_HEADER,'','N','N',@rpt_request_no
		FROM #CostSummary_2 A
		WHERE PRODSEQ = @PRODSEQ
	
		--No. of Member (Column: 2n - 1)
		INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
		SELECT DISTINCT @rowidx,1 + plan_seq * 2 - 1,'No. of Member','h2_NOM',@W_TYPE_HEADER,'','N','N',@rpt_request_no
		FROM #CostSummary_2 A, #PlanList B
		WHERE PRODSEQ = @PRODSEQ

		--Annual Premium Rate (Column: 2n)
		INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
		SELECT DISTINCT @rowidx,1 + plan_seq * 2,'Annual Premium Rate','h2_APR',@W_TYPE_HEADER,'','N','N',@rpt_request_no
		FROM #CostSummary_2 A, #PlanList B
		WHERE PRODSEQ = @PRODSEQ

	--Detail
	DECLARE CUR_COVG CURSOR FOR
		SELECT DISTINCT COVGSEQ,COVGDESC FROM #CostSummary_2 WHERE PRODSEQ = @PRODSEQ
	OPEN CUR_COVG
	FETCH NEXT FROM CUR_COVG INTO @COVGSEQ,@COVGDESC
	WHILE @@fetch_status=0
	BEGIN
		SELECT @rowidx = @rowidx + @COVGSEQ*10

		--Member Type
		INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
		VALUES(@rowidx,1,@COVGDESC,'h3_MT',@W_TYPE_ITEMVALUE1,'','N','N',@rpt_request_no)

		--No. of Member
		INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
		SELECT @rowidx,1 + plan_seq * 2 - 1 as colidx,ISNULL(nol,0) as itemvalue,'C3_NOM',@W_TYPE_ITEMVALUE1,'','Y','N',@rpt_request_no
		FROM #PlanList A LEFT JOIN #CostSummary_2 B ON B.plan_no = A.plan_no AND B.PRODSEQ = @PRODSEQ AND COVGSEQ = @COVGSEQ

		--Annual Premium Rate
		INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
		SELECT @rowidx,1 + plan_seq * 2 as colidx,CONVERT(VARCHAR(20),CASE B.PRODGROUP WHEN 'GL' THEN CONVERT(DECIMAL(15,3),ISNULL(ann_prem_rate,0)) ELSE CONVERT(DECIMAL(15,2),ISNULL(ann_prem_rate,0)) END) as itemvalue,'C3_APR',@W_TYPE_ITEMVALUE1,'','Y','N',@rpt_request_no
		FROM #PlanList A LEFT JOIN #CostSummary_2 B ON B.plan_no = A.plan_no AND B.PRODSEQ = @PRODSEQ AND COVGSEQ = @COVGSEQ

		FETCH NEXT FROM CUR_COVG INTO @COVGSEQ,@COVGDESC
	END
	CLOSE CUR_COVG
	DEALLOCATE CUR_COVG

	--Sub-total
	SELECT @rowidx = @rowidx + 1

	INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
	VALUES(@rowidx,1,'Sub-total','h2_ST',@W_TYPE_HEADER,'','N','N',@rpt_request_no)

	INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
	SELECT @rowidx,1 + plan_seq * 2 - 1 as colidx,'','C2_ST_NOM',@W_TYPE_ITEMVALUE1,'','Y','N',@rpt_request_no
	FROM #PlanList A LEFT JOIN #CostSummary_2 B ON B.plan_no = A.plan_no AND B.PRODSEQ = @PRODSEQ
	GROUP BY (1 + plan_seq * 2 - 1)
	
	INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
	SELECT @rowidx,1 + plan_seq * 2 as colidx,SUM(ISNULL(ann_prem,0)),'C2_ST_APR',@W_TYPE_ITEMVALUE1,'','Y','N',@rpt_request_no
	FROM #PlanList A LEFT JOIN #CostSummary_2 B ON B.plan_no = A.plan_no AND B.PRODSEQ = @PRODSEQ
	GROUP BY (1 + plan_seq * 2)

	--Blank line
	SELECT @rowidx = @rowidx + 1

	INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
	VALUES(@rowidx,1,'','h2_BLANK',@W_TYPE_HEADER,'','N','N',@rpt_request_no)
		
	INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
	SELECT @rowidx,1 + plan_seq * 2 - 1 as colidx,'','h2_BLANK2',@W_TYPE_ITEMVALUE1,'','N','N',@rpt_request_no
	FROM #PlanList A LEFT JOIN #CostSummary_2 B ON B.plan_no = A.plan_no AND B.PRODSEQ = @PRODSEQ
	GROUP BY (1 + plan_seq * 2 - 1)
	
	INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
	SELECT @rowidx,1 + plan_seq * 2 as colidx,'','h2_BLANK2',@W_TYPE_ITEMVALUE1,'','N','N',@rpt_request_no
	FROM #PlanList A LEFT JOIN #CostSummary_2 B ON B.plan_no = A.plan_no AND B.PRODSEQ = @PRODSEQ
	GROUP BY (1 + plan_seq * 2)

	FETCH NEXT FROM CUR_PRD INTO @PRODSEQ
END

CLOSE CUR_PRD
DEALLOCATE CUR_PRD

--Insert grand total
SELECT @TotalAnn_prem = SUM(ISNULL(ann_prem,0)) FROM #CostSummary_2
SELECT @rowidx = @rowidx + 1

INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
VALUES(@rowidx,1,'TOTAL ANNUAL PREMIUM','h2_T',@W_TYPE_HEADER,'','N','N',@rpt_request_no)

INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
SELECT @rowidx,1 + plan_seq * 2 - 1 as colidx,'','C2_T_NOM',@W_TYPE_ITEMVALUE1,'','Y','N',@rpt_request_no
FROM #PlanList A
GROUP BY (1 + plan_seq * 2 - 1)
	
INSERT teflow_report_2_19 (rowidx,colidx,itemvalue,class,itemtype,RemarkCode,Editable,Merged,request_no)
SELECT @rowidx,1 + plan_seq * 2 as colidx,'','C2_T_APR',@W_TYPE_ITEMVALUE1,'','Y','N',@rpt_request_no
FROM #PlanList A
GROUP BY (1 + plan_seq * 2)

UPDATE A
SET A.itemvalue = @TotalAnn_prem
FROM teflow_report_2_19 A
WHERE A.request_no = @rpt_request_no
AND A.rowidx = @rowidx
AND A.colidx = (SELECT 1 + MAX(plan_seq) * 2 FROM #PlanList)


--Remark variable
--Nil


--INSERT #ReportTable(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
--VALUES(@W_HEADERROW,@W_ITEMTITLECOL_1,'h0_F04','',@W_TYPE_HEADER,NULL,'N','N')
--INSERT #ReportTable(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
--VALUES(@W_HEADERROW,@W_ITEMTITLECOL_2,'h0_F02','',@W_TYPE_HEADER,NULL,'N','N')
--INSERT #ReportTable(RowIdx,ColIdx,Class,ItemValue,ItemType,RemarkCode,Editable,Mergeable)
--VALUES(@W_HEADERROW,@W_ITEMTITLECOL_3,'h0_F03','',@W_TYPE_HEADER,NULL,'N','N')

--SELECT DISTINCT PRODSEQ FROM #CostSummary_2

--Update report no to display in online
UPDATE Teflow_30_8 SET field_8_2 = @rpt_request_no WHERE request_no = @request_no

DROP TABLE #CostSummary_2
DROP TABLE #PlanList

RETURN


