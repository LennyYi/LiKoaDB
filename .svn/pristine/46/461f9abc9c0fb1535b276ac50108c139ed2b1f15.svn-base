IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = object_id('dbo.NOVAUspGetUploadPath') and sysstat & 0xf = 4)
	DROP PROCEDURE dbo.NOVAUspGetUploadPath
GO

CREATE PROCEDURE dbo.NOVAUspGetUploadPath
( 	
	@cPath	VARCHAR(1000) OUTPUT
)
AS
/*******************************************************************
	AIA CONFIDENTIAL MARCH 2000

	COMPASS 2000 USER STORED PROCEDURE

	STORED PROCEDURE USED FOR Load product list
	
	AUTHOR		:	Hinson Liang
	DATE		:	01/15/2015
	
REVISION LOG:
PDCF		PROGRAMMER	DATE		CTRL No.	PURPOSE
------------------------------------------------------------------------------------------
			Hinson.L	01/15/2015				Initial
*********************************************************************/

SET NOCOUNT ON

SELECT @cPath = param_value FROM teflow_param_config WHERE param_code = 'upload_file_dir'

SELECT @cPath = REPLACE(@cPath,'/','\')

IF RIGHT(@cPath,1)<> '\'
BEGIN
	SELECT @cPath = @cPath + '\'
END

SELECT @cPath = @cPath + 'upload\requestform\'


RETURN


