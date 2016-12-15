IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = object_id('dbo.NOVAUspSDReject') and sysstat & 0xf = 4)
	DROP PROCEDURE dbo.NOVAUspSDReject
GO

CREATE PROCEDURE dbo.NOVAUspSDReject
( 	
	@request_no varchar(30), @staff_code VARchar(10)
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
			Hinson.L	03/27/2015				Add summary section
*********************************************************************/

SET NOCOUNT ON

DELETE teflow_6_5 WHERE request_no = @request_no
DELETE teflow_6_4 WHERE request_no = @request_no
DELETE teflow_6_3 WHERE request_no = @request_no
--20150327 BEGIN
DELETE teflow_6_6 WHERE request_no = @request_no
--20150327 END

RETURN


