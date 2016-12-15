-- 20150215 Justin Bin, Initial
-- 20150303	Justin Bin, Modified, remove the hardcode server name, change the select method into insert method
begin tran
IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'NOVA.heworksheet_template') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE NOVA.heworksheet_template
begin	
SELECT '0' as FORM_SYSTEM_ID,* into NOVA.heworksheet_template FROM heworksheet WHERE 1=2


INSERT NOVA.heworksheet_template(FORM_SYSTEM_ID,eseqno,ecategory,etype,esubtype,eref,member_id,prov_cd,
ereftran,erefline,edesc,e_sta,econfidtl,create_dt,create_usr,rcddtstmp,rcdusrid,
polno,clntcode,certno,depcode,EffDate,ExpiryDate)  
VALUES('0',N'9999999999',N'POLICY',N'AML',N'AML',N'0000000001',NULL,NULL,NULL,NULL,N'低风险',N'A',N'N',GETDATE(),UPPER(SUSER_SNAME()),
GETDATE(),UPPER(SUSER_SNAME()),N'0000000001',NULL,NULL,NULL,NULL,NULL)

end
commit tran
