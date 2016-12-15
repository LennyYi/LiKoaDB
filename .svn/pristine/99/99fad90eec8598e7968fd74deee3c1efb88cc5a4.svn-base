IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('DBO.UspGNOVAGetProdPlanByPolNoAndEffDate') AND SYSSTAT & 0xF = 4)
	DROP PROCEDURE DBO.UspGNOVAGetProdPlanByPolNoAndEffDate
GO
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	SP_Compass_[UspGNOVAGetProdPlanByPolNoAndEffDate].sql - to get client code and client Name by Policy No
        
    PROCESSING DETAILS:			
	AUTHOR      :     Justin Bin
	DATE	    :     04/01/2015
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
	1.0					Justin Bin				04/01/2015	Init
********************************************************************/

create proc dbo.UspGNOVAGetProdPlanByPolNoAndEffDate
(
     @cPolicyNo char(10),
     @effDate 	char(10)
)
as
BEGIN
	if exists (select 1 from tpolpdt t1 
		inner join tproduct t2 on t1.PRODCODE = t2.PRODCODE 
			and t1.POLNO = @cPolicyNo
			and t1.EFFDATE <= @effDate 
			and t2.PRODTYPE = 'P')
	begin--Package Product
		select t3.PRODTYPE,t1.POLNO,PRODCDESC = NOVA.funReplaceSpecN(ISNULL(t3.PRODCDESC,''),0),t2.PRODCODE,t1.BENPLNCD,t4.PLNDESC from (
			select DISTINCT POLNO,BENPLNCD,rank() over (partition by POLNO, BENPLNCD order by CHGEFFDATE DESC, CHGEFFDT DESC) as rowno 
			from tmemptpol where POLNO = @cPolicyNo and CHGEFFDATE <= @effDate) t1 
		inner join (select polno,prodcode,RANK() OVER(partition by polno,prodcode order by effdate desc) as rowno 
				from tpolpdt where POLNO = @cPolicyNo and EFFDATE <= @effDate) t2 on t1.POLNO = t2.POLNO and  t1.rowno = 1
		inner join (select distinct polno,BENPLNCD,PLNDESC,RANK() OVER(partition by POLNO, BENPLNCD order by EFFDATE DESC) as rowno 
				from TPOLPDTPLN where POLNO = @cPolicyNo and EFFDATE <= @effDate) t4 on t1.POLNO = t4.POLNO and t1.BENPLNCD = t4.BENPLNCD and t4.rowno = 1 
		inner join tproduct t3 on t2.PRODCODE = t3.PRODCODE and t2.rowno = 1 and t3.PRODTYPE = 'P'
	end
	else
	begin--Tailor-make Product
		select t3.PRODTYPE,t1.POLNO,PRODCDESC = NOVA.funReplaceSpecN(ISNULL(t3.PRODCDESC,''),0),t2.PRODCODE,t1.BENPLNCD,t4.PLNDESC from (
			select DISTINCT POLNO,PRODCODE,BENPLNCD,rank() over (partition by POLNO,PRODCODE,BENPLNCD order by CHGEFFDATE DESC, CHGEFFDT DESC) as rowno 
			from tmemptpol where POLNO = @cPolicyNo and CHGEFFDATE <= @effDate) t1 
		inner join (select polno,prodcode,RANK() OVER(partition by polno,prodcode order by effdate desc) as rowno 
				from tpolpdt where POLNO = @cPolicyNo and EFFDATE <= @effDate) t2 on t1.PRODCODE = t2.PRODCODE and  t1.rowno = 1
		inner join (select distinct polno,prodcode,BENPLNCD,PLNDESC,RANK() OVER(partition by POLNO, PRODCODE, BENPLNCD order by EFFDATE DESC) as rowno 
				from TPOLPDTPLN where POLNO = @cPolicyNo and EFFDATE <= @effDate) t4 on t1.POLNO = t4.POLNO and t1.PRODCODE = t4.PRODCODE 
					and t1.BENPLNCD = t4.BENPLNCD and t4.rowno = 1 
		inner join tproduct t3 on t2.PRODCODE = t3.PRODCODE and t2.rowno = 1 order by t1.BENPLNCD asc
		
	end
END 


