IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.NovaUspClearError') AND sysstat & 0xf = 4)
	drop procedure dbo.NovaUspClearError
GO

CREATE PROCEDURE dbo.NovaUspClearError
(	@cTRANDATE		CHAR(10), 
	@form_system_id		VARCHAR(10),
	@request_no		VARCHAR(30),
	@staff_code		VARCHAR(10),
	@cRETCODE	CHAR(4) OUTPUT,
	@cRETMESSAGE    VARCHAR(MAX) OUTPUT
) AS
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDUREas

	NovaUspClearError.SQL - Prepare xml for transfer data
        
        PROCESSING DETAILS:
        Prepare XML file for 
			
	AUTHOR      :     Sting Wu
	DATE	    :     11/12/2014
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        5.0	  NOVA		Sting Wu				11/12/2014	Initial Version
********************************************************************/
/*error handling variable section */
BEGIN

begin try

DECLARE @exeValue NVARCHAR(MAX)

UPDATE  TNovaProcessMsg SET MsgReadIND ='Y' where request_no = @request_no and MsgReadIND = 'N'

SELECT @cRETCODE = ''

SELECT @exeValue = 'UPDATE teflow_'+@form_system_id+"_SystemFW SET field_SystemFW_1 ='"+@cRETCODE + "' WHERE  request_no='"+@request_no+"'"
exec sp_executesql @exeValue

SELECT @exeValue = 'UPDATE teflow_'+@form_system_id+"_SystemFW SET field_SystemFW_8 =NULL WHERE  request_no='"+@request_no+"'"
exec sp_executesql @exeValue

SELECT @cRETCODE = '0000'

end try
begin catch
	
	DECLARE @ErrorMessage NVARCHAR(4000);  
	DECLARE @ErrorSeverity INT;  
	DECLARE @ErrorState INT;  
	
	SELECT @cRETCODE = '9999'

	SELECT @ErrorMessage = ERROR_MESSAGE(),  
	@ErrorSeverity = ERROR_SEVERITY(),  
	@ErrorState = ERROR_STATE(); 
	
	INSERT INTO TNovaErrlogTran
	select @request_no,'NovaUspClearError',@ErrorMessage,@staff_code,GETDATE()

	GOTO EXIT_WINDOW

end catch

EXIT_WINDOW:

END