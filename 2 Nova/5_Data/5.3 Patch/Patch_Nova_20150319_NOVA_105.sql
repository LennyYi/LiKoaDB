-- 20150319 Justin Bin
-- 20150324 Justin Bin , Change 1/2 3/4 to 12 34

begin tran
delete from teflow_base_data_master where master_id='10188'
set identity_insert teflow_base_data_master on
insert into teflow_base_data_master (master_id,field_name,type_code) values ('10188','GCPA职业等级','01')

delete from teflow_base_data_detail where master_id='10188'
insert into teflow_base_data_detail (master_id,option_value,option_label,[status]) values ('10188','12','Class 1/2','A')
insert into teflow_base_data_detail (master_id,option_value,option_label,[status]) values ('10188','34','Class 3/4','A')

delete from teflow_field_basedata where form_system_id='20267' and section_id='4' and field_id='field_4_2'
insert into teflow_field_basedata (master_id,form_system_id,section_id,field_id) values ('10188','20267','4','field_4_2')

commit tran
