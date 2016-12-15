IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('DBO.USPGNOVAGetPolicyByClient') AND SYSSTAT & 0xF = 4)
	DROP PROCEDURE DBO.USPGNOVAGetPolicyByClient
GO
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	SP_Compass_[USPGNOVAGetPolicyByClient].sql - to get policy by client
        
    PROCESSING DETAILS:			
	AUTHOR      :     Justin Bin
	DATE	    :     04/01/2015
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
	1.0					Justin Bin				04/01/2015	Init
********************************************************************/

create procedure dbo.USPGNOVAGetPolicyByClient
(
	@clientCode char(5)
)
AS
BEGIN
	
	SET NOCOUNT ON
	SELECT  POLNO,POLDESC FROM tpolicy WHERE RCDSTS='A' AND status='A' AND clntcode=@clientCode
	
END 

