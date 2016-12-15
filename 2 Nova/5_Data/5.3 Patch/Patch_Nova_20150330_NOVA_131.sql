--2015-03-30 Sting Wu for NOVA-11
delete from teflow_base_data_detail where master_id = 10131
delete from teflow_base_data_master where master_id = 10131

update teflow_field_basedata set master_id = 10133 where form_system_id in (20261,20259,20264,20267) and master_id = '10131'  