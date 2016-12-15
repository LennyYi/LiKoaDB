IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.NovaUspCompassTrigger') AND sysstat & 0xf = 4)
	drop procedure dbo.NovaUspCompassTrigger
GO

CREATE PROCEDURE dbo.NovaUspCompassTrigger
(@request_no varchar(30), @staff_code VARchar(10))
AS
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	NovaUspCompassTrigger.SQL - Prepare TPOLPDTPRM table for TPOLPDTPRM_NOVA letter
        
        PROCESSING DETAILS:
        Prepare TPOLPDTPRM table for TPOLPDTPRM_NOVA letter
			
	AUTHOR      :     Issca Zhu
	DATE	    :     11/06/2014
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        5.0	  NOVA		Issca Zhu				11/06/2014	Initial Version
********************************************************************/
/*error handling variable section */
BEGIN
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
DECLARE	@cUSERID	CHAR(8)
DECLARE	@cTRANDATE	CHAR(10)
DECLARE	@cRETCODE	CHAR(4)
DECLARE	@cCALLTYPE	CHAR(1)
DECLARE	@form_system_id		VARCHAR(18) 
DECLARE @current_node_Id    varchar(10) 
DECLARE @cProgramID		varchar(60)
DECLARE	@cSubmit	CHAR(2)
DECLARE	@cWithdraw	CHAR(2)
DECLARE	@cApprove	CHAR(2)
DECLARE	@cRejected	CHAR(2)
DECLARE	@nodeHandleHours	float
DECLARE	@dtBeginTime	DATETIME
DECLARE	@dtEndTime	DATETIME
DECLARE @nextNodeId varchar(50)
DECLARE @ErrorMessage NVARCHAR(4000);  
DECLARE @ErrorSeverity INT;  
DECLARE @ErrorState INT;  
DECLARE	@cMESSAGE	NVARCHAR(MAX)	  
DECLARE @exeValue NVARCHAR(MAX)
DECLARE @flow_id DEC(18,0)

DECLARE	@COMPASSCODE VARCHAR(10)
DECLARE @CompassDB VARCHAR(20)

SELECT @COMPASSCODE = 'System001'

SELECT @cACTIVE = 'A'
SELECT @cCALLTYPE = 'N'
SELECT @cProgramID = 'NovaUspCompassTrigger'
SELECT @cSubmit ='01'
SELECT @cWithdraw = '02'
SELECT @cApprove = '03'
SELECT @cRejected = '04'

SELECT @cRETCODE = '0000'

begin try

insert into TNovaErrlogTran
select @request_no,@cProgramID,'begin',@staff_code,GETDATE()

SELECT @cUSERID=Logonid FROM teflow_user WHERE Staff_code=@staff_code

SELECT @cTRANDATE=CONVERT(CHAR(10),Submission_date,120) FROM teflow_wkf_process WHERE request_no=@request_no

insert into TNovaErrlogTran
select @request_no,@cProgramID,'call NovaUspOutRequestInfo',@staff_code,GETDATE()

EXEC dbo.NovaUspOutRequestInfo @request_no, @form_system_id OUTPUT,@current_node_Id OUTPUT, @flow_id OUTPUT

--select @current_node_Id

insert into TNovaErrlogTran
select @request_no,@cProgramID,'call NovaUspProcess',@staff_code,GETDATE()


EXEC NovaUspProcess @cTRANDATE,@form_system_id,@request_no,@current_node_Id,@staff_code, @cRETCODE OUTPUT, @cMESSAGE OUTPUT

insert into TNovaErrlogTran
select @request_no,@cProgramID,'Complete NovaUspProcess',@cRETCODE,GETDATE()

IF @cRETCODE <>'0000'
BEGIN 
	SELECT @cRETCODE = 'E001'
	GOTO EXIT_WINDOW
END

end try
begin catch
	
--	SELECT @cRETCODE = 'E004'

	--UPDATE teflow_232_SystemFW SET field_SystemFW_1 =@cRETCODE WHERE  request_no=@request_no
	

	SELECT @exeValue = 'UPDATE teflow_'+@form_system_id+"_SystemFW SET field_SystemFW_1 ='"+@cRETCODE + "' WHERE  request_no='"+@request_no+"'"
	exec sp_executesql @exeValue

	IF (@cMESSAGE = '' OR @cMESSAGE IS NULL)
		SELECT @cMESSAGE = option_label FROM teflow_base_data_detail where master_id='10138' AND option_value =  @cRETCODE
	
	insert into TNovaProcessMsg
	select @request_no,@cMESSAGE,@cRETCODE,'E','N'


	SELECT @ErrorMessage = ERROR_MESSAGE(),  
	@ErrorSeverity = ERROR_SEVERITY(),  
	@ErrorState = ERROR_STATE(); 
	
	INSERT INTO TNovaErrlogTran
	select @request_no,@cProgramID,@ErrorMessage,@staff_code,GETDATE()

	GOTO EXIT_WINDOW
end catch


NEXTPROCESS:
begin try
SELECT @dtBeginTime = GETDATE()

select @CompassDB = param_value from teflow_param_config where param_code= 'CompassDB'

SELECT @exeValue = 'EXEC '+@CompassDB+'.dbo.UspGNOVACompassProcess001 '''+@cTRANDATE+''','''
	+@request_no+''',''' + @staff_code + ''',''' + @form_system_id + ''',''' 
	+ @current_node_Id + ''',''' + @cUSERID + ''',''' + @cCALLTYPE + ''',@cRETCODE OUTPUT, @cMESSAGE OUTPUT'
	
insert into TNovaErrlogTran
select @request_no,@cProgramID,@exeValue,@staff_code,GETDATE()

exec sp_executesql @exeValue,N'@cRETCODE CHAR(4) output,@cMESSAGE NVARCHAR(MAX) output',@cRETCODE output, @cMESSAGE output

insert into TNovaErrlogTran
select @request_no,@cProgramID,'return code: '+@cRETCODE,@staff_code,GETDATE()

IF @cRETCODE <>'0000'
BEGIN 
	GOTO EXIT_WINDOW
END

SELECT @cRETCODE = NULL 

end try
begin catch
	
--	SELECT @cRETCODE = 'E004'

	SELECT @exeValue = 'UPDATE teflow_'+@form_system_id+"_SystemFW SET field_SystemFW_1 ='"+@cRETCODE + "' WHERE  request_no='"+@request_no+"'"
	exec sp_executesql @exeValue
	IF (@cMESSAGE = '' OR @cMESSAGE IS NULL)
		SELECT @cMESSAGE = option_label FROM teflow_base_data_detail where master_id='10138' AND option_value =  @cRETCODE

	insert into TNovaProcessMsg
	select @request_no,@cMESSAGE,@cRETCODE,'E','N'
	  
	SELECT @ErrorMessage = ERROR_MESSAGE(),  
	@ErrorSeverity = ERROR_SEVERITY(),  
	@ErrorState = ERROR_STATE(); 
	
	INSERT INTO TNovaErrlogTran
	select @request_no,@cProgramID,@ErrorMessage,@staff_code,GETDATE()

	GOTO EXIT_WINDOW
end catch



EXIT_WINDOW:
	
	SELECT @dtEndTime = GETDATE()

	SELECT @nodeHandleHours = DATEDIFF(ms,@dtBeginTime,@dtEndTime)
	
	IF @cRETCODE IS NOT NULL OR @cRETCODE<>'' OR  @cRETCODE <> '0000'
	BEGIN
		SELECT @exeValue = 'UPDATE teflow_'+@form_system_id+"_SystemFW SET field_SystemFW_1 ='"+@cRETCODE + "' WHERE  request_no='"+@request_no+"'"
		exec sp_executesql @exeValue
		IF (@cMESSAGE = '' OR @cMESSAGE IS NULL)
			SELECT @cMESSAGE = option_label FROM teflow_base_data_detail where master_id='10138' AND option_value =  @cRETCODE

	
		insert into TNovaProcessMsg  values (@request_no,@cMESSAGE,@cRETCODE,'E','N')
	END
	
	IF EXISTS(SELECT 1 FROM teflow_wkf_detail where flow_id=@flow_id and node_id=@current_node_Id and approver_staff_code=@COMPASSCODE)
		EXEC [poef_wkf_node_process] @form_system_id,@request_no,@current_node_Id,@COMPASSCODE,@cApprove,'',@staff_code,@nodeHandleHours,N'0.0',N'',N'',N'',@nextNodeId output

	IF EXISTS(SELECT 1 
		FROM	teflow_wkf_detail T1, 
				teflow_wkf_define T2 
		WHERE	T2.form_system_id	= @form_system_id 
		AND		t2.flow_id			= t1.flow_id 
		AND		t1.node_id			= @nextNodeId
		AND		T1.approver_staff_code = @COMPASSCODE
		AND		@cRETCODE IS NULL)
	BEGIN

		SELECT @current_node_Id = @nextNodeId
		SELECT @nextNodeId = NULL

		GOTO NEXTPROCESS
	END

RETURN

END

GO
