IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.NovaUspProcess') AND sysstat & 0xf = 4)
	drop procedure dbo.NovaUspProcess
GO 

CREATE PROCEDURE dbo.NovaUspProcess
(	@cTRANDATE		CHAR(10), 
	@form_system_id		VARCHAR(10),
	@request_no		VARCHAR(30),
	@current_node_Id VARCHAR(10),
	@staff_code		VARCHAR(10),
	@cRETCODE	CHAR(4) OUTPUT,
	@cRETMESSAGE	   NVARCHAR(MAX) OUTPUT
) AS
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	NovaUspProcess.SQL - Prepare xml for transfer data
        
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

declare @exeValue nvarchar(4000),@exeDeclare nvarchar(200),@error_code char(4)

begin try
	 INSERT TNovaErrlogTran (RequestNo,ProgramID,ERRORLOG,Staff_Code,RCDDTSTMP) 
     VALUES(@request_no,'NovaUspProcess',@form_system_id,@staff_code,GETDATE())
	 
	 INSERT TNovaErrlogTran (RequestNo,ProgramID,ERRORLOG,Staff_Code,RCDDTSTMP) 
     VALUES(@request_no,'NovaUspProcess',@current_node_Id,@staff_code,GETDATE())

     declare cur_Novaprocess cursor for
     
          select process_sp,error_code from TNovaProcess where 
		  form_system_id = CASE WHEN (SELECT DISTINCT 1 FROM TNovaProcess WHERE FORM_SYSTEM_ID=@form_system_id) = 1 THEN @form_system_id ELSE '0' END
		   AND current_node_Id= rtrim(@current_node_Id) ORDER BY ORDERBY
              
     open cur_Novaprocess

     FETCH NEXT FROM cur_Novaprocess INTO @exeValue,@error_code
     WHILE (@@FETCH_STATUS = 0)
     BEGIN

          set @exeValue = Cast('exec ' + @exeValue + ' ''' + @cTRANDATE + ''',''' + @form_system_id + ''','''  + @request_no + ''',''' + @staff_code + ''',@cRETCODE OUTPUT, @cRETMESSAGE OUTPUT'  as nvarchar(MAX));

          INSERT TNovaErrlogTran (RequestNo,ProgramID,ERRORLOG,Staff_Code,RCDDTSTMP) 
		  VALUES(@request_no,'NovaUspProcess',@exeValue,@staff_code,GETDATE())

          exec sp_executesql @exeValue,N'@cRETCODE CHAR(4) output, @cRETMESSAGE NVARCHAR(MAX) OUTPUT',@cRETCODE OUTPUT, @cRETMESSAGE OUTPUT
          
     FETCH NEXT FROM cur_Novaprocess INTO @exeValue,@error_code
     END

     CLOSE cur_Novaprocess 
     DEALLOCATE cur_Novaprocess

end try
begin catch
	
	DECLARE @ErrorMessage NVARCHAR(4000);  
	DECLARE @ErrorSeverity INT;  
	DECLARE @ErrorState INT;  
	
	SELECT @cRETCODE = @error_code

	if exists( select * from master.dbo.syscursors where cursor_name='cur_Novaprocess')
	BEGIN
		CLOSE cur_Novaprocess 
		DEALLOCATE cur_Novaprocess  
	END

	SELECT @ErrorMessage = ERROR_MESSAGE(),  
	@ErrorSeverity = ERROR_SEVERITY(),  
	@ErrorState = ERROR_STATE(); 
	
	INSERT INTO TNovaErrlogTran
	select @request_no,'NovaUspProcess',@ErrorMessage,@staff_code,GETDATE()

	GOTO EXIT_WINDOW

end catch

EXIT_WINDOW:

END