--2015-03-04 Sting Wu
begin tran

delete from teflow_param_config where param_code = 'MemberUpload_path'

INSERT teflow_param_config(param_code,param_name,param_value,description,order_id)  
VALUES(N'MemberUpload_path',N'Member upload template path GD(Package)',N'/download/template/MemberUpload_20264.xlsx',N'20264',N'0')
INSERT teflow_param_config(param_code,param_name,param_value,description,order_id)  
VALUES(N'MemberUpload_path',N'Member upload template path JS',N'/download/template/MemberUpload_20261.xlsx',N'20261',N'0')
INSERT teflow_param_config(param_code,param_name,param_value,description,order_id)  
VALUES(N'MemberUpload_path',N'Member upload template path GD(GCPA)',N'/download/template/MemberUpload_20267.xlsx',N'20267',N'0')
INSERT teflow_param_config(param_code,param_name,param_value,description,order_id)  
VALUES(N'MemberUpload_path',N'Member upload template path SZ',N'/download/template/MemberUpload_20259.xlsx',N'20259',N'0')

commit
-- =============================================

--select * from teflow_param_config
delete from teflow_param_config where param_code='least_insurance_charge'
insert into teflow_param_config(param_code,param_name,param_value,description,order_id) values('least_insurance_charge','least_insurance_charge','1500','Least total insurance charge',0)

--20150309 Justin Bin Added
delete from teflow_param_config where param_code='commission_rate'
insert into teflow_param_config (param_code,param_name,param_value,[description],order_id) values ('commission_rate','commission rate','PF200','20264',0)
insert into teflow_param_config (param_code,param_name,param_value,[description],order_id) values ('commission_rate','commission rate','PF200','20261',0)
insert into teflow_param_config (param_code,param_name,param_value,[description],order_id) values ('commission_rate','commission rate','PF200','20259',0)
insert into teflow_param_config (param_code,param_name,param_value,[description],order_id) values ('commission_rate','commission rate','PF200','20267',0)


-- ========================================================
--Sting Wu 2015-03-10

delete from teflow_param_config where param_name = 'dateFormat' or param_code = 'dateFormat'

INSERT teflow_param_config(param_code,param_name,param_value,[description],order_id)  VALUES(N'dateFormat',N'dateFormat',N'yyyy/MM/dd',N'',N'0')


-- Justin Bin 2015-3-18
delete from teflow_param_config where param_code='form_rows'

insert into teflow_param_config (param_code,param_name,param_value,[description],order_id) values ('form_rows','form rows','','the rows of the form','0')