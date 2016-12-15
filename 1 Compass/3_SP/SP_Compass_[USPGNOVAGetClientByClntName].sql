IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('DBO.USPGNOVAGetClientByClntName') AND SYSSTAT & 0xF = 4)
	DROP PROCEDURE DBO.USPGNOVAGetClientByClntName
GO
/*******************************************************************
	COMPASS USER STORED PROCEDURE

	SP_Compass_[USPGNOVAGetClientByClntName].sql - to get policy by client
        
    PROCESSING DETAILS:			
	AUTHOR      :     Sting Wu
	DATE	    :     04/23/2015
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
	1.0					Sting Wu				04/23/2015	Init
********************************************************************/

create procedure dbo.USPGNOVAGetClientByClntName
( @clntname nchar(60))
AS
BEGIN
	
	SET NOCOUNT ON
	SELECT  * FROM tclient WHERE RCDSTS='A' AND [STATUS]='A' AND CLNTNAME=@clntname
	
END 

