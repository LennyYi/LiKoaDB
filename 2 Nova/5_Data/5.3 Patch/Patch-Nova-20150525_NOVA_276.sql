delete from teflow_param_config where param_code = 'MemberUpload_path' and description = '30320';
insert into teflow_param_config (param_code, param_name, param_value, description, order_id) values ( 'MemberUpload_path', 'Member upload template path BJXTA', '/download/template/MemberUpload_30320.xlsx', '30320', 0 );
