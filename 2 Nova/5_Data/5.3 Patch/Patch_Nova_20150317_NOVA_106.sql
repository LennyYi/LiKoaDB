--2015-03-17 Sting Wu for task NOVA-106

delete t1 from teflow_base_data_detail t1 inner join teflow_base_data_master t2 on t1.master_id = t2.master_id 
and t2.field_name = 'GCPA产品计划' and t1.option_label = '计划8-5级'