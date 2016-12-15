IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.USPGNOVAGENTPOLPDTFLAK') AND sysstat & 0xf = 4)
	drop procedure dbo.USPGNOVAGENTPOLPDTFLAK
GO

SET ANSI_NULLS ON 
SET QUOTED_IDENTIFIER ON  
SET CONCAT_NULL_YIELDS_NULL ON 
SET ANSI_WARNINGS ON 
SET ANSI_PADDING ON
GO

CREATE PROCEDURE dbo.USPGNOVAGENTPOLPDTFLAK
(@request_no		VARCHAR(30))
AS
BEGIN
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	USPGNOVAGENTPOLPDTFLAK.SQL - Prepare TMEMPTPOL table for TMEMPTPOL_NOVA letter
        
        PROCESSING DETAILS:
        Prepare TMEMPTPOL table for TMEMPTPOL_NOVA letter
			
	AUTHOR      :     Issca Zhu
	DATE	    :     11/06/2014
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        5.0	  NOVA		Issca Zhu				11/06/2014	Initial Version
********************************************************************/
/*error handling variable section */
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
DECLARE @XML XML 
DECLARE	@CLNTCODE	CHAR(1)
DECLARE	@cCLNTCODE	CHAR(5)
DECLARE	@cPOLNO		CHAR(10)
DECLARE	@cCERTNO	VARCHAR(10)
DECLARE @cProgramID VARCHAR(60)
DECLARE	@EFFDATE	DATETIME
DECLARE	@cMEM		CHAR(3)
DECLARE	@cSUBOFFCODE CHAR(3)
DECLARE	@cCNTYCODE	CHAR(3)
DECLARE	@cBANKAC	NCHAR(80)
DECLARE	@cBANKBRNAME NCHAR(100)
DECLARE	@cBANKCODE	CHAR(4)
DECLARE	@cPAYEENAME NCHAR(128)
DECLARE	@cPRMRFBANKCODE CHAR(4)
DECLARE	@cPRMRFBANKACCT NCHAR(80)
DECLARE @cPRMRFBANKBRNAME NCHAR(128)

SELECT @cACTIVE = 'A'

SET ANSI_NULLS ON 
SET QUOTED_IDENTIFIER ON  
SET CONCAT_NULL_YIELDS_NULL ON 
SET ANSI_WARNINGS ON 
SET ANSI_PADDING ON

--SELECT * FROM TPOLPDT_NOVA WHERE REQUESTNO='FlexSZ_NBForm_12252014_06'


DECLARE @cProdcode CHAR(5) 
DECLARE	@cPlancode CHAR(3)
DECLARE	@cCOMPAREPLAN	VARCHAR(2000)
DECLARE @cCOMPAREPROD	VARCHAR(2000)
DECLARE @exeValue NVARCHAR(MAX)

SELECT @cCOMPAREPLAN = NULL
SELECT @cCOMPAREPROD = NULL


declare cur_DeleteProductPlan cursor for 

select  DISTINCT SUBPRODCODE,BENPLNCD, POLNO
from TPOLPDT_NOVA where REQUESTNO = @request_no
order by BENPLNCD,SUBPRODCODE

open cur_DeleteProductPlan	

FETCH NEXT FROM cur_DeleteProductPlan INTO @cProdcode, @cPlancode, @cPOLNO
WHILE (@@FETCH_STATUS = 0)
BEGIN

	IF @cProdcode IS NULL OR RTRIM(@cProdcode) = ''
	BEGIN
		IF @cCOMPAREPLAN IS NULL
			SELECT @cCOMPAREPLAN = ''''+@cPlancode+''''
		ELSE 
			SELECT @cCOMPAREPLAN = @cCOMPAREPLAN + ','+''''+@cPlancode+''''


		SELECT @cCOMPAREPROD = ''


	END
	ELSE
	BEGIN
		IF @cCOMPAREPLAN IS NULL
			SELECT @cCOMPAREPLAN = ''''+@cProdcode+@cPlancode+''''
		ELSE 
			SELECT @cCOMPAREPLAN = @cCOMPAREPLAN + ','+''''+@cProdcode+@cPlancode+''''

	   IF @cCOMPAREPROD IS NULL
			SELECT @cCOMPAREPROD = ''''+@cProdcode+''''
		ELSE 
			SELECT @cCOMPAREPROD = @cCOMPAREPROD + ','+''''+@cProdcode+''''

	END


	FETCH NEXT FROM cur_DeleteProductPlan INTO @cProdcode, @cPlancode,@cPOLNO
END

CLOSE cur_DeleteProductPlan 
DEALLOCATE cur_DeleteProductPlan  


IF @cProdcode IS NULL OR RTRIM(@cProdcode) = ''
BEGIN

	SELECT @exeValue = 'DELETE FROM TPOLPDTLIMIT WHERE BENPLNCD NOT IN ('+@cCOMPAREPLAN+') AND POLNO='+''''+@cPOLNO+''''
	exec sp_executesql @exeValue
	
	SELECT @exeValue = 'DELETE FROM TPOLPDTBEN WHERE BENPLNCD NOT IN ('+@cCOMPAREPLAN+') AND POLNO='+''''+@cPOLNO+''''
	exec sp_executesql @exeValue
	
	SELECT @exeValue = 'DELETE FROM TPOLPDTPRM WHERE BENPLNCD NOT IN ('+@cCOMPAREPLAN+') AND POLNO='+''''+@cPOLNO+''''
	exec sp_executesql @exeValue
	
	SELECT @exeValue = 'DELETE FROM TPOLPDTPLN WHERE BENPLNCD NOT IN ('+@cCOMPAREPLAN+') AND POLNO='+''''+@cPOLNO+''''
	exec sp_executesql @exeValue
	
	SELECT @exeValue = 'DELETE FROM TPOLPDTPLNH WHERE BENPLNCD NOT IN ('+@cCOMPAREPLAN+') AND POLNO='+''''+@cPOLNO+''''
	exec sp_executesql @exeValue

END
ELSE
BEGIN
	SELECT @exeValue = 'DELETE FROM TPOLPDTLIMIT WHERE PRODCODE + BENPLNCD NOT IN ('+@cCOMPAREPLAN+') AND POLNO='+''''+@cPOLNO+''''
	exec sp_executesql @exeValue
	
	SELECT @exeValue = 'DELETE FROM TPOLPDTBEN WHERE PRODCODE + BENPLNCD NOT IN ('+@cCOMPAREPLAN+') AND POLNO='+''''+@cPOLNO+''''
	exec sp_executesql @exeValue
	
	SELECT @exeValue = 'DELETE FROM TPOLPDTPRM WHERE PRODCODE + BENPLNCD NOT IN ('+@cCOMPAREPLAN+') AND POLNO='+''''+@cPOLNO+''''
	exec sp_executesql @exeValue
	
	SELECT @exeValue = 'DELETE FROM TPOLPDTPLN WHERE PRODCODE + BENPLNCD NOT IN ('+@cCOMPAREPLAN+') AND POLNO='+''''+@cPOLNO+''''
	exec sp_executesql @exeValue
	
	SELECT @exeValue = 'DELETE FROM TPOLPDTPLNH WHERE PRODCODE + BENPLNCD NOT IN ('+@cCOMPAREPLAN+') AND POLNO='+''''+@cPOLNO+''''
	exec sp_executesql @exeValue
	

	SELECT @exeValue = 'DELETE FROM TPOLPDTCOM WHERE PRODCODE NOT IN ('+@cCOMPAREPROD+') AND POLNO='+''''+@cPOLNO+''''
	exec sp_executesql @exeValue
	
	SELECT @exeValue = 'DELETE FROM TPOLPDTCOV WHERE PRODCODE  NOT IN ('+@cCOMPAREPROD+') AND POLNO='+''''+@cPOLNO+''''
	exec sp_executesql @exeValue
	
	SELECT @exeValue = 'DELETE FROM TPOLPDTADJ WHERE PRODCODE  NOT IN ('+@cCOMPAREPROD+') AND POLNO='+''''+@cPOLNO+''''
	exec sp_executesql @exeValue
	
	SELECT @exeValue = 'DELETE FROM TPOLPDTH WHERE PRODCODE NOT IN ('+@cCOMPAREPROD+') AND POLNO='+''''+@cPOLNO+''''
	exec sp_executesql @exeValue
	
	SELECT @exeValue = 'DELETE FROM TPOLPDT WHERE PRODCODE NOT IN ('+@cCOMPAREPROD+') AND POLNO='+''''+@cPOLNO+''''
	exec sp_executesql @exeValue
END

	--	DELETE FROM TPOLPDTCOM		WHERE  PRODCODE <>@cProdcode AND POLNO=@cPOLNO
	--	DELETE FROM TPOLPDTCOV		WHERE  PRODCODE <>@cProdcode AND POLNO=@cPOLNO
	--	DELETE FROM TPOLPDTADJ		WHERE  PRODCODE <>@cProdcode AND POLNO=@cPOLNO
	--	DELETE FROM TPOLPDTH		WHERE  PRODCODE <>@cProdcode AND POLNO=@cPOLNO
	--	DELETE FROM TPOLPDT			WHERE  PRODCODE <>@cProdcode AND POLNO=@cPOLNO

	--END
	--ELSE
	--BEGIN


	--END


EXIT_WINDOW:

SET ANSI_NULLS OFF 
SET QUOTED_IDENTIFIER OFF  
SET CONCAT_NULL_YIELDS_NULL OFF 
SET ANSI_WARNINGS OFF 
SET ANSI_PADDING OFF 

	RETURN

END

SET ANSI_NULLS OFF 
SET QUOTED_IDENTIFIER OFF  
SET CONCAT_NULL_YIELDS_NULL OFF 
SET ANSI_WARNINGS OFF 
SET ANSI_PADDING OFF 
GO