
update teflow_form_section_field set is_required = -1
where form_system_id = 30286
and field_id = 'field_02_25';

update teflow_form_section_field set is_required = -1
where form_system_id = 30286
and field_id in ('field_2_1','field_2_3','field_2_5','field_2_6','field_2_7','field_2_8');

update teflow_form_section_field set is_required = -1
where form_system_id = 30286
and field_id = 'field_4_2';

update teflow_form_section_field set is_required = -1
where form_system_id = 30286
and field_id = 'field_9_10';


delete from teflow_base_data_detail where master_id = 112 and option_value =  'S';
insert into  teflow_base_data_detail values(112, 'S', N'银行', null);
