-- 20150506 Justin Bin

UPDATE TNOVAprodprem SET Premium='122' WHERE  PKGCODE LIKE '%FLAK4' AND PLANCODE='021' AND PRODCODE = '211S5'
-- set default commission_rate
delete from teflow_param_config where param_code='commission_rate' and [description] ='30319'
insert into teflow_param_config (param_code,param_name,param_value,[description],order_id)
		values('commission_rate','commission rate','PF200','30319','0')

-- set default template file
delete from teflow_param_config where param_code='MemberUpload_path' and [description]='30319'
insert into teflow_param_config (param_code,param_name,param_value,[description],order_id) 
	   values ('MemberUpload_path','Member upload template path SZ(4.0)','/download/template/MemberUpload_30319.xlsx','30319','0')
	   
	  