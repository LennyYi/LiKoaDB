IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = object_id('dbo.UspGNOVASDLoadDefHdrMap') and sysstat & 0xf = 4)
	DROP PROCEDURE dbo.UspGNOVASDLoadDefHdrMap
GO

CREATE PROCEDURE dbo.UspGNOVASDLoadDefHdrMap
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

DECLARE @cNOVAREQNO VARCHAR(30)

SELECT @cNOVAREQNO = MAX(NOVAREQNO) FROM TNOVA_SDRequest A
WHERE A.POLNO = @cPOLNO
AND A.SubmitDATE = (SELECT MAX(SubmitDATE) FROM TNOVA_SDRequest A1
			WHERE A1.POLNO = A.POLNO
			)

SELECT HDRNAME,FIELDNAME,PRODCODE FROM TNOVA_SDHdrMap
WHERE NOVAREQNO = @cNOVAREQNO

RETURN


