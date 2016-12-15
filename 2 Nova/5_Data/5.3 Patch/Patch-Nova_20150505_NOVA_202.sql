delete from teflow_base_data_detail where master_id = (select master_id 
	from teflow_base_data_master where field_name = 'ErrorMessage')

declare @master_id decimal
select @master_id = master_id from teflow_base_data_master where field_name = 'ErrorMessage'

insert into teflow_base_data_detail (master_id,option_value,option_label,[status]) values (@master_id,'E000','人员信息存在超龄或者黑名单人员, 请核查!',null)
insert into teflow_base_data_detail (master_id,option_value,option_label,[status]) values (@master_id,'E001','数据转化错误,请联系技术支持!',null)
insert into teflow_base_data_detail (master_id,option_value,option_label,[status]) values (@master_id,'E002','表单验证不通过, 请核查!',null)
insert into teflow_base_data_detail (master_id,option_value,option_label,[status]) values (@master_id,'E004','数据插入COMPASS错误，请联系技术支持!',null)
insert into teflow_base_data_detail (master_id,option_value,option_label,[status]) values (@master_id,'E005','在当前表单中人员身份证号码重复',null)
insert into teflow_base_data_detail (master_id,option_value,option_label,[status]) values (@master_id,'E006','在当前表单中人员被保险编号重复',null)
insert into teflow_base_data_detail (master_id,option_value,option_label,[status]) values (@master_id,'W001','身份证号码与另外的表单重复',null)
insert into teflow_base_data_detail (master_id,option_value,option_label,[status]) values (@master_id,'W002','人员在Nova表单中存在重复投保',null)
insert into teflow_base_data_detail (master_id,option_value,option_label,[status]) values (@master_id,'W010','表达存在照会信息',null)

