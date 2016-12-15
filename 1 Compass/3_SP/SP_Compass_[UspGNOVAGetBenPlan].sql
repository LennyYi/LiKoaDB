IF EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DBO.UspGNOVAGetBenPlan') AND SYSSTAT & 0xF = 4)
	DROP PROCEDURE DBO.UspGNOVAGetBenPlan
GO
SET ANSI_NULLS ON 
SET QUOTED_IDENTIFIER ON  
SET CONCAT_NULL_YIELDS_NULL ON 
SET ANSI_WARNINGS ON 
SET ANSI_PADDING ON 
GO
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	SP_Compass_[UspGNOVAGetClientByPolicyNo].sql - to get client code and client Name by Policy No
        
    PROCESSING DETAILS:			
	AUTHOR      :     Justin Bin
	DATE	    :     04/01/2015
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
	1.0					Justin Bin				04/01/2015	Init
********************************************************************/
create procedure dbo.UspGNOVAGetBenPlan(
	@cPolicyNo char(10),
	@cClientCode char(5)
)
as
begin
	select a.clntcode,a.polno,a.benplncd  from tmemptpol  a,tmember m  where a.polno=@cPolicyNo and m.clntcode=@cClientCode and a.prdstatus='A'
		and m.clntcode=a.clntcode and m.certno=a.certno and m.rcdsts='A' and m.status='A' and m.suboffcode='100' and a.suboffcode=m.suboffcode 
		and m.effdate=(select max(effdate) from tmember m1 where m1.clntcode=m.clntcode and m1.certno=m.certno and m1.suboffcode=m.suboffcode and m1.rcdsts='A')
		and m.chgeffdt=(select max(chgeffdt) from tmember m2 where m2.clntcode=m.clntcode and m2.certno=m.certno and m2.suboffcode=m.suboffcode and m2.rcdsts='A')
		and a.chgeffdate = (select max(chgeffdate) from tmemptpol b where b.clntcode=a.clntcode and b.suboffcode=a.suboffcode and b.certno=a.certno and b.polno=a.polno and b.prodcode=a.prodcode and a.depcode=b.depcode )
		and a.chgeffdt   = (select max(chgeffdt) from tmemptpol c where c.clntcode=a.clntcode and c.suboffcode=a.suboffcode and c.certno=a.certno and c.polno=a.polno and c.prodcode=a.prodcode and a.depcode=c.depcode )
 	group by a.clntcode,a.polno,a.benplncd
end 

SET ANSI_NULLS OFF 
SET QUOTED_IDENTIFIER OFF  
SET CONCAT_NULL_YIELDS_NULL OFF 
SET ANSI_WARNINGS OFF 
SET ANSI_PADDING OFF 
