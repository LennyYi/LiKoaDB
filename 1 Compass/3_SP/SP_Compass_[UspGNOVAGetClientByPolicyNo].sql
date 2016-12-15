IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('DBO.USPGNOVAGetClientByPolicyNo') AND SYSSTAT & 0xF = 4)
	DROP PROCEDURE DBO.USPGNOVAGetClientByPolicyNo
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

create procedure dbo.USPGNOVAGetClientByPolicyNo(
     @cPolicyNo char(10)
)
as

BEGIN

declare @clientCode varchar(10)


select POLDESC = NOVA.funReplaceSpecN(isnull(p.poldesc,''),0),
	CLNTNAME = NOVA.funReplaceSpecN(isnull(a.clntname,''),0),
	[STATUS] = p.[status],
	CLNTCODE = p.clntcode,
	BILLPRDTO = convert(varchar, b.billprdto, 23), 
	NOTES = '['+NOVA.funReplaceSpecN(n.NOTE,0)+ ']',
	BUSNSRCE = c.busnsrce,
	COMMCODE = c.commcode,
	BRANCHCODE = d.BRANCHCODE,
	COUNTYCODE = d.COUNTYCODE ,
	SRVAE = d.SRVAE,
	ProducerInfo ='[{ }'+ (select distinct ',{','"PRDUCODE":"'+pc.PRDUCODE,
											 '","PRDUNAME":"'+NOVA.funReplaceSpecN(isnull(pr.PRDUNAME,''),0),
											 '","AGTOFFCODE":"'+NOVA.funReplaceSpecN(isnull(pr.AGTOFFCODE,''),0),
											 '","AGYCODE":"'+NOVA.funReplaceSpecN(isnull(pr.AGYCODE,''),0),
											 '","TELNO":"'+NOVA.funReplaceSpecN(isnull(pr.TELNO,''),0),
											 '","PRDUSHRPC":"'+NOVA.funReplaceSpecN(CONVERT(char(10), pc.PRDUSHRPC*100),0),'"}'
							from TPOLPDTCOM pc 
							left join TPRODUCER pr on pc.PRDUCODE=pr.PRDUCODE 
								and pr.[STATUS]='A' 
								and pr.RCDSTS='A'  
							where pc.POLNO=@cPolicyNo and pc.RCDSTS='A'  for xml path('') ) +']'
from tpolicy p 
	inner join tclient a on a.CLNTCODE = P.CLNTCODE and p.polno=@cPolicyNo AND p.rcdsts='A'
	left join tpolnote n on p.POLNO = n.POLNO and n.RCDSTS='A' 
	left join (select max(PAIDTODATE) as billprdto,POLNO from TPOLFINCL where POLNO = @cPolicyNo and RCDSTS = 'A' group by POLNO) b on p.POLNO=b.POLNO
	left join (select top 1 polno, BUSNSRCE,COMMCODE from TPOLPDT 
		where polno=@cPolicyNo and status='A' and rcdsts='A' and PRODCODE in (select distinct PRODCODE from tproduct where PRODTYPE in ('A','P'))) c on c.POLNO=p.polno
	left join (select (t2.BRANCHCODE + ' - ' + t2.BRANCHSHORT) as BRANCHCODE ,COUNTYCODE,t1.SRVAE,t1.POLNO from TPOLADDH t1 
			inner join tpolicy t3 on t1.POLNO = t3.POLNO  and t1.POLNO=@cPolicyNo
			inner join TCOMPBRANCH t2 on t1.BRANCHCODE = t2.BRANCHCODE and t2.COMPCODE = t3.COMPCODE
			) d on p.POLNO=d.POLNO
group by p.poldesc,a.clntname,p.[status],p.clntcode,b.billprdto,n.NOTE,c.BUSNSRCE,c.COMMCODE, d.BRANCHCODE ,d.COUNTYCODE ,d.SRVAE

END 


