IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.UspGNOVACompassProcess001') AND sysstat & 0xf = 4)
     drop procedure dbo.UspGNOVACompassProcess001
GO

CREATE PROCEDURE [dbo].[UspGNOVACompassProcess001]
(    @cTRANDATE         CHAR(10), 
     @request_no        VARCHAR(30),
     @staff_code        VARCHAR(10),
     @form_system_id    VARCHAR(18),
     @current_node_Id VARCHAR(10),
     @cUSERID      CHAR(8),
     @cCALLTYPE         CHAR(1),  --  O - Online, B -- Batch
     @cRETCODE     CHAR(4) OUTPUT,
	 @cRETMESSAGE	   NVARCHAR(MAX) OUTPUT
) AS
BEGIN
/*******************************************************************
     COMPASS 2000 USER STORED PROCEDURE

     UspGNOVACompassProcess001.SQL - Prepare TPOLPDTPLN table for TPOLPDTPLN_NOVA letter
        
        PROCESSING DETAILS:
        Prepare TPOLPDTPLN table for TPOLPDTPLN_NOVA letter
              
     AUTHOR      :     Issca Zhu
     DATE     :     11/06/2014
     PIRNO         :       

     REVISION LOG:
     VERSION     PIRNO       PROGRAMMER    REMARK        DATE      PURPOSE
        5.0     NOVA        Issca Zhu               11/06/2014    Initial Version
********************************************************************/
/*error handling variable section */
DECLARE @ErrFrom   CHAR(20)
DECLARE @ErrMsg         CHAR(65)
DECLARE @ErrData   CHAR(45)
DECLARE @ErrCode        INT
DECLARE @StoreProcInd   CHAR(1)
DECLARE   @cMSGID       CHAR(5)
/*DECLARE VARIABLES AND CONSTANTS*/
DECLARE   @cACTIVE  CHAR(1)
DECLARE   @cDELETED CHAR(1)
DECLARE   @cYES         CHAR(1)
DECLARE   @cNO      CHAR(1)
DECLARE   @cSubmit  CHAR(2)
DECLARE   @cApproved    CHAR(2)
DECLARE   @cApprove CHAR(2)
DECLARE   @cRejected    CHAR(2)
DECLARE   @COMPASSCODE VARCHAR(10)
DECLARE   @dtBeginTime  DATETIME
DECLARE   @dtEndTime    DATETIME
DECLARE   @nodeHandleHours   float
DECLARE @nextNodeId varchar(50)
declare @exeValue nvarchar(4000),@exeDeclare nvarchar(200),@error_code char(4)

SELECT @cACTIVE = 'A'
SELECT @COMPASSCODE = 'System001'

SELECT @cSubmit ='01'
SELECT @cApproved = '02'
SELECT @cApprove = '03'
SELECT @cRejected = '04'

SELECT @dtBeginTime = GETDATE()
SELECT @cRETCODE = '0000'

begin try

	 INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
     VALUES(@request_no,'UspGNOVACompassProcess001',@form_system_id,@cUSERID,GETDATE())
	 
	 INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
     VALUES(@request_no,'UspGNOVACompassProcess001',@current_node_Id,@cUSERID,GETDATE())

     declare cur_Compassprocess cursor for
     
          select process_sp,error_code from T_Nova_CompassProcess 
		  where form_system_id = CASE WHEN (SELECT DISTINCT 1 FROM T_Nova_CompassProcess WHERE FORM_SYSTEM_ID=@form_system_id) = 1 THEN @form_system_id ELSE '0' END
              AND current_node_Id= rtrim(@current_node_Id) 
              
     open cur_Compassprocess

     FETCH NEXT FROM cur_Compassprocess INTO @exeValue,@error_code
     WHILE (@@FETCH_STATUS = 0)
     BEGIN 

          set @exeValue = Cast('exec ' + @exeValue + ' ''' + @cTRANDATE + ''',''' + @request_no + ''',''' + @staff_code + ''',''' + @cUSERID + ''',''' + @cCALLTYPE + ''',@cRETCODE OUTPUT, @cRETMESSAGE OUTPUT'  as nvarchar(MAX));

          INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
     VALUES(@request_no,'UspGNOVACompassProcess001',@exeValue,@cUSERID,GETDATE())

          exec sp_executesql @exeValue,N'@cRETCODE CHAR(4) output, @cRETMESSAGE NVARCHAR(MAX) OUTPUT',@cRETCODE OUTPUT, @cRETMESSAGE OUTPUT
          
     FETCH NEXT FROM cur_Compassprocess INTO @exeValue,@error_code
     END

     CLOSE cur_Compassprocess 
     DEALLOCATE cur_Compassprocess

end try
begin catch
     
     DECLARE @ErrorMessage NVARCHAR(4000);  
     DECLARE @ErrorSeverity INT;  
     DECLARE @ErrorState INT;  
       
     SELECT @ErrorMessage = ERROR_MESSAGE(),  
     @ErrorSeverity = ERROR_SEVERITY(),  
     @ErrorState = ERROR_STATE();  


     SELECT @cRETCODE = @error_code
 
     INSERT T_Nova_ErrlogTran (RequestNo,ProgramID,ERRORLOG,RCDUSRID,RCDDTSTMP) 
     VALUES(@request_no,'UspGNOVACompassProcess001','error sp:' + @exeValue + CHAR(13) + 'error code:' + @cRETCODE + CHAR(13) + 'error message:' +
              @ErrorMessage,@cUSERID,GETDATE())
     
	 CLOSE cur_Compassprocess 
     DEALLOCATE cur_Compassprocess

     GOTO EXIST
     
end catch

EXIST:

	 If @cRETCODE <> '0000'
		SELECT @cRETCODE = @error_code

END

return 

