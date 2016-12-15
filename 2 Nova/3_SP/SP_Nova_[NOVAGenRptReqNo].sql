IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = object_id('dbo.NOVAGenRptReqNo') and sysstat & 0xf = 4)
	DROP PROCEDURE dbo.NOVAGenRptReqNo
GO

CREATE PROCEDURE dbo.NOVAGenRptReqNo
( 	
	@form_request_no        NVARCHAR(200),
	@report_no NVARCHAR(100) OUTPUT 
)
AS
DECLARE @form_system_id nvarchar(100)
DECLARE @current_date varchar(100)
DECLARE @field_2_2 varchar(100)
DECLARE @field_20_4 varchar(100)
DECLARE @field_20_3 varchar(100)
DECLARE @field_20_1 varchar(100)
DECLARE @field_21_1 varchar(100)
DECLARE @field_21_2 varchar(100)
DECLARE @field_21_4 varchar(100)

DECLARE @seqno varchar(100)
/*******************************************************************
	AIA CONFIDENTIAL MARCH 2000

	COMPASS 2000 USER STORED PROCEDURE

	STORED PROCEDURE USED FOR Load default header mapping
	
	AUTHOR		:	 Tytron Xie
	DATE		:	 2015/05/26
	
REVISION LOG:
PDCF		PROGRAMMER	DATE		CTRL No.	PURPOSE
------------------------------------------------------------------------------------------
			Tytron.X  2015/05/26		        Initial
*********************************************************************/
BEGIN
   SELECT @current_date=CONVERT(varchar(100), GETDATE(), 112)
	SELECT @form_system_id =form_system_id FROM teflow_wkf_define where flow_id in 
	(select flow_id from teflow_wkf_process where request_no = @form_request_no)
	IF @form_system_id = 30
		BEGIN
			select @field_2_2=field_2_2 from teflow_30_2 
			SELECT @seqno = COUNT(*)+1 FROM teflow_report_instance WHERE report_no LIKE @field_2_2+'_'+@current_date+'%'
			SET @report_no = @field_2_2+'_'+@current_date+'_'+@seqno
			SELECT @field_20_4=field_20_4 FROM teflow_30_20
			SELECT @field_20_1=field_20_1 FROM teflow_30_20
			SELECT @field_20_3=field_20_3 FROM teflow_30_20
			SELECT @field_21_1=field_21_1 FROM teflow_30_21
			SELECT @field_21_2=field_21_2 FROM teflow_30_21
			SELECT @field_21_4=field_21_4 FROM teflow_30_21
			
			IF @seqno < 10
			BEGIN
				SET @seqno = '0' + @seqno
				SET @report_no = @field_2_2+'_'+@current_date+'_'+@seqno
			END
			
			IF @field_20_4 is not null 
			BEGIN
				SET @report_no = @report_no + '_L'+@field_20_1+@field_20_3
			END 
			IF @field_21_4 is not null 
			BEGIN
				SET @report_no = @report_no + '_M'+@field_21_1+@field_21_2+@field_20_3   
			END
		END
END


