-- 20150323 Justin Bin Added
begin tran

delete from TCOMPBRNCOUNTY where COUNTYCODE='CCYZ' and COMPCODE='12' and BRANCHCODE='008'
insert into TCOMPBRNCOUNTY (COMPCODE,BRANCHCODE,BRANCHABR,COUNTYCODE,COUNTYDESC ) values ('12','008','YZ','CCYZ',N'仪征')

commit tran