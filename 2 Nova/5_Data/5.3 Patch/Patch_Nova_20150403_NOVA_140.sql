--2015-04-03 Sting Wu	for NOVA-140
sp_RENAME 'teflow_20259_9.PlanCodeMem_id', 'MemPlan_id', 'COLUMN'
go

sp_RENAME 'teflow_20259_4.PlanCode_id' , 'Plan_id' , 'COLUMN'
go

update teflow_system_field set field_label = '保险产品',
field_type = '05', 
data_sql = 'SELECT DISTINCT a.NOVA_PRODCODE option_value , a.NOVA_PRODCODE_Local option_label   FROM TNovaProductMapping a where form_System_id = @formid'
where field_id = 'Product_id'


update teflow_system_field set field_label = '人员保险产品',
field_type = '05', 
data_sql = 'SELECT DISTINCT a.NOVA_PRODCODE option_value , a.NOVA_PRODCODE_Local option_label   FROM TNovaProductMapping a where form_System_id = @formid'
where field_id = 'MemProduct_id'


update teflow_system_field set field_label = '产品计划',
field_type = '05', 
data_sql = 'SELECT DISTINCT NOVA_BENPLNCD option_value , NOVA_BENPLNCD_Local option_label FROM TNovaProductMapping WHERE form_System_id = @formid'
where field_id = 'Plan_id'


update teflow_system_field set field_label = '人员产品计划',
field_type = '05', 
data_sql = 'SELECT DISTINCT NOVA_BENPLNCD option_value , NOVA_BENPLNCD_Local option_label FROM TNovaProductMapping WHERE form_System_id = @formid'
where field_id = 'MemPlan_id'


delete from teflow_system_field where field_id in ('PlanCode_id','PlanCodeMem_id')

update TNovaFieldMapping set from_field = 'MemPlan_id' where from_field = 'PlanCodeMem_id'
update TNovaFieldMapping set from_field = 'Plan_id'  where from_field = 'PlanCode_id'

update teflow_form_section_field set field_id = 'MemPlan_id' where form_system_id = 20259 and field_id = 'PlanCodeMem_id'

update teflow_form_section_field set field_id = 'Plan_id' where form_system_id = 20259 and field_id = 'PlanCode_id'

GO