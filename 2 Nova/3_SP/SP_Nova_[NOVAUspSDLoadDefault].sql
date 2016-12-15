IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = object_id('dbo.NOVAUspSDLoadDefault') and sysstat & 0xf = 4)
	DROP PROCEDURE dbo.NOVAUspSDLoadDefault
GO

CREATE PROCEDURE dbo.NOVAUspSDLoadDefault
( 	
	@cPOLNO		char(10)
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

SELECT field_2_5 AS 'NewMemDef' FROM teflow_6_2 A
WHERE field_2_1 = @cPOLNO
AND request_no = (SELECT MAX(request_no) FROM teflow_6_2 B
			WHERE B.field_2_1 = A.field_2_1
			AND ISNULL(B.field_2_5,'')<>''
			)

RETURN


