delete from teflow_base_data_master where field_name = '首年/续保'

--insert into teflow_base_data_master (field_name, type_code) values ('首年/续保','00')
--declare @master_id as decimal
--select @master_id = master_id from teflow_base_data_master where field_name = '首年/续保'
--delete from teflow_base_data_detail where master_id = @master_id
--insert into teflow_base_data_detail (master_id,option_value, option_label,status) values (@master_id, 'F' ,'首年','')
--insert into teflow_base_data_detail (master_id, option_value,option_label,status) values (@master_id, 'R' ,'续保','')

delete from teflow_form_section_field where form_system_id = 20264 and field_id = 'field_10_10'
insert into teflow_form_section_field (form_system_id,section_id,field_id,field_label,field_type,is_required,data_type,field_length,source_type,source_sql,order_id,decimal_digits,high_level,is_money ,is_singlerow,controls_width,controls_height,field_comments,comment_content,is_readonly,event_click,event_dbclick,event_onfocus,event_onblur,event_onchange,default_value,column_width,report_system_id,report_type,is_disabled,report_no)
values (20264,10,'field_10_10','首年/续保',1	,-1,1,3,0,NULL,9,0,-1,-1,-1,0,0,'','',1,'','','','','','F',NULL,0,NULL,-1,NULL) 
delete from TNovaFieldMapping where form_system_id = 20264 and to_table = 'TBILLDETAIL_NOVA' and to_field = 'FYRENCODE'
INSERT TNovaFieldMapping(form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])  VALUES(N'20264',N'teflow_20264_10',N'field_10_10',N'teflow_20264_9.id',N'TBILLDETAIL_NOVA',N'FYRENCODE',NULL,NULL,N'13')


delete from teflow_form_section_field where form_system_id = 30319 and field_id = 'field_10_10'
insert into teflow_form_section_field (form_system_id,section_id,field_id,field_label,field_type,is_required,data_type,field_length,source_type,source_sql,order_id,decimal_digits,high_level,is_money ,is_singlerow,controls_width,controls_height,field_comments,comment_content,is_readonly,event_click,event_dbclick,event_onfocus,event_onblur,event_onchange,default_value,column_width,report_system_id,report_type,is_disabled,report_no)
values (30319,10,'field_10_10','首年/续保',1	,-1,1,3,0,NULL,9,0,-1,-1,-1,0,0,'','',1,'','','','','','F',NULL,0,NULL,-1,NULL) 
delete from TNovaFieldMapping where form_system_id = 30319 and to_table = 'TBILLDETAIL_NOVA' and to_field = 'FYRENCODE'
INSERT TNovaFieldMapping(form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])  VALUES(N'30319',N'teflow_30319_10',N'field_10_10',N'teflow_30319_9.id',N'TBILLDETAIL_NOVA',N'FYRENCODE',NULL,NULL,N'13')


delete from teflow_form_section_field where form_system_id = 20261 and field_id = 'field_10_10'
insert into teflow_form_section_field (form_system_id,section_id,field_id,field_label,field_type,is_required,data_type,field_length,source_type,source_sql,order_id,decimal_digits,high_level,is_money ,is_singlerow,controls_width,controls_height,field_comments,comment_content,is_readonly,event_click,event_dbclick,event_onfocus,event_onblur,event_onchange,default_value,column_width,report_system_id,report_type,is_disabled,report_no)
values (20261,10,'field_10_10','首年/续保',1	,-1,1,3,0,NULL,9,0,-1,-1,-1,0,0,'','',1,'','','','','','F',NULL,0,NULL,-1,NULL) 
delete from TNovaFieldMapping where form_system_id = 20261 and to_table = 'TBILLDETAIL_NOVA' and to_field = 'FYRENCODE'
INSERT TNovaFieldMapping(form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])  VALUES(N'20261',N'teflow_20261_10',N'field_10_10',N'teflow_20261_9.id',N'TBILLDETAIL_NOVA',N'FYRENCODE',NULL,NULL,N'13')


delete from teflow_form_section_field where form_system_id = 30328 and field_id = 'field_10_10'
insert into teflow_form_section_field (form_system_id,section_id,field_id,field_label,field_type,is_required,data_type,field_length,source_type,source_sql,order_id,decimal_digits,high_level,is_money ,is_singlerow,controls_width,controls_height,field_comments,comment_content,is_readonly,event_click,event_dbclick,event_onfocus,event_onblur,event_onchange,default_value,column_width,report_system_id,report_type,is_disabled,report_no)
values (30328,10,'field_10_10','首年/续保',1	,-1,1,3,0,NULL,9,0,-1,-1,-1,0,0,'','',1,'','','','','','F',NULL,0,NULL,-1,NULL) 
delete from TNovaFieldMapping where form_system_id = 30328 and to_table = 'TBILLDETAIL_NOVA' and to_field = 'FYRENCODE'
INSERT TNovaFieldMapping(form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])  VALUES(N'30328',N'teflow_30328_10',N'field_10_10',N'teflow_30328_9.id',N'TBILLDETAIL_NOVA',N'FYRENCODE',NULL,NULL,N'13')

delete from teflow_form_section_field where form_system_id = 20267 and field_id = 'field_10_10'
insert into teflow_form_section_field (form_system_id,section_id,field_id,field_label,field_type,is_required,data_type,field_length,source_type,source_sql,order_id,decimal_digits,high_level,is_money ,is_singlerow,controls_width,controls_height,field_comments,comment_content,is_readonly,event_click,event_dbclick,event_onfocus,event_onblur,event_onchange,default_value,column_width,report_system_id,report_type,is_disabled,report_no)
values (20267,10,'field_10_10','首年/续保',1	,-1,1,3,0,NULL,9,0,-1,-1,-1,0,0,'','',1,'','','','','','F',NULL,0,NULL,-1,NULL) 
delete from TNovaFieldMapping where form_system_id = 20267 and to_table = 'TBILLDETAIL_NOVA' and to_field = 'FYRENCODE'
INSERT TNovaFieldMapping(form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])  VALUES(N'20267',N'teflow_20267_10',N'field_10_10',N'teflow_20267_9.id',N'TBILLDETAIL_NOVA',N'FYRENCODE',NULL,NULL,N'13')


delete from teflow_form_section_field where form_system_id = 30320 and field_id = 'field_10_10'
insert into teflow_form_section_field (form_system_id,section_id,field_id,field_label,field_type,is_required,data_type,field_length,source_type,source_sql,order_id,decimal_digits,high_level,is_money ,is_singlerow,controls_width,controls_height,field_comments,comment_content,is_readonly,event_click,event_dbclick,event_onfocus,event_onblur,event_onchange,default_value,column_width,report_system_id,report_type,is_disabled,report_no)
values (30320,10,'field_10_10','首年/续保',1 ,-1,1,3,0,NULL,9,0,-1,-1,-1,0,0,'','',1,'','','','','','F',NULL,0,NULL,-1,NULL) 
delete from TNovaFieldMapping where form_system_id = 30320 and to_table = 'TBILLDETAIL_NOVA' and to_field = 'FYRENCODE'
INSERT TNovaFieldMapping(form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])  VALUES(N'30320',N'teflow_30320_10',N'field_10_10',N'teflow_30320_9.id',N'TBILLDETAIL_NOVA',N'FYRENCODE',NULL,NULL,N'13')


delete from teflow_form_section_field where form_system_id = 30288 and field_id = 'field_10_10'
insert into teflow_form_section_field (form_system_id,section_id,field_id,field_label,field_type,is_required,data_type,field_length,source_type,source_sql,order_id,decimal_digits,high_level,is_money ,is_singlerow,controls_width,controls_height,field_comments,comment_content,is_readonly,event_click,event_dbclick,event_onfocus,event_onblur,event_onchange,default_value,column_width,report_system_id,report_type,is_disabled,report_no)
values (30288,10,'field_10_10','首年/续保',1	,-1,1,3,0,NULL,9,0,-1,-1,-1,0,0,'','',1,'','','','','','F',NULL,0,NULL,-1,NULL) 
delete from TNovaFieldMapping where form_system_id = 30288 and to_table = 'TBILLDETAIL_NOVA' and to_field = 'FYRENCODE'
INSERT TNovaFieldMapping(form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])  VALUES(N'30288',N'teflow_30288_10',N'field_10_10',N'teflow_30288_9.id',N'TBILLDETAIL_NOVA',N'FYRENCODE',NULL,NULL,N'13')

delete from teflow_form_section_field where form_system_id = 30286 and field_id = 'field_10_10'
insert into teflow_form_section_field (form_system_id,section_id,field_id,field_label,field_type,is_required,data_type,field_length,source_type,source_sql,order_id,decimal_digits,high_level,is_money ,is_singlerow,controls_width,controls_height,field_comments,comment_content,is_readonly,event_click,event_dbclick,event_onfocus,event_onblur,event_onchange,default_value,column_width,report_system_id,report_type,is_disabled,report_no)
values (30286,10,'field_10_10','首年/续保',1	,-1,1,3,0,NULL,9,0,-1,-1,-1,0,0,'','',1,'','','','','','F',NULL,0,NULL,-1,NULL) 
delete from TNovaFieldMapping where form_system_id = 30286 and to_table = 'TBILLDETAIL_NOVA' and to_field = 'FYRENCODE'
INSERT TNovaFieldMapping(form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])  VALUES(N'30286',N'teflow_30286_10',N'field_10_10',N'teflow_30286_9.id',N'TBILLDETAIL_NOVA',N'FYRENCODE',NULL,NULL,N'13')


delete from teflow_form_section_field where form_system_id = 30322 and field_id = 'field_10_10'
insert into teflow_form_section_field (form_system_id,section_id,field_id,field_label,field_type,is_required,data_type,field_length,source_type,source_sql,order_id,decimal_digits,high_level,is_money ,is_singlerow,controls_width,controls_height,field_comments,comment_content,is_readonly,event_click,event_dbclick,event_onfocus,event_onblur,event_onchange,default_value,column_width,report_system_id,report_type,is_disabled,report_no)
values (30322,10,'field_10_10','首年/续保',1	,-1,1,3,0,NULL,9,0,-1,-1,-1,0,0,'','',1,'','','','','','F',NULL,0,NULL,-1,NULL) 
delete from TNovaFieldMapping where form_system_id = 30322 and to_table = 'TBILLDETAIL_NOVA' and to_field = 'FYRENCODE'
INSERT TNovaFieldMapping(form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])  VALUES(N'30322',N'teflow_30322_10',N'field_10_10',N'teflow_30322_9.id',N'TBILLDETAIL_NOVA',N'FYRENCODE',NULL,NULL,N'13')


 delete from teflow_field_basedata where form_system_id = 20264 and field_id = 'field_10_10'
 --INSERT teflow_field_basedata(master_id,form_system_id,section_id,field_id)  VALUES(@master_id,N'20264',N'10',N'field_10_10')
 
 delete from teflow_field_basedata where form_system_id = 30319 and field_id = 'field_10_10'
 --INSERT teflow_field_basedata(master_id,form_system_id,section_id,field_id)  VALUES(@master_id,N'30319',N'10',N'field_10_10')
 
 delete from teflow_field_basedata where form_system_id = 20261 and field_id = 'field_10_10'
 --INSERT teflow_field_basedata(master_id,form_system_id,section_id,field_id)  VALUES(@master_id,N'20261',N'10',N'field_10_10')
 
 delete from teflow_field_basedata where form_system_id = 30328 and field_id = 'field_10_10'
 --INSERT teflow_field_basedata(master_id,form_system_id,section_id,field_id)  VALUES(@master_id,N'30328',N'10',N'field_10_10')
 
  delete from teflow_field_basedata where form_system_id = 20267 and field_id = 'field_10_10'
 --INSERT teflow_field_basedata(master_id,form_system_id,section_id,field_id)  VALUES(@master_id,N'20267',N'10',N'field_10_10')
 
   delete from teflow_field_basedata where form_system_id = 30320 and field_id = 'field_10_10'
 --INSERT teflow_field_basedata(master_id,form_system_id,section_id,field_id)  VALUES(@master_id,N'30320',N'10',N'field_10_10')
 
 delete from teflow_field_basedata where form_system_id = 30288 and field_id = 'field_10_10'
 --INSERT teflow_field_basedata(master_id,form_system_id,section_id,field_id)  VALUES(@master_id,N'30288',N'10',N'field_10_10')
 
  delete from teflow_field_basedata where form_system_id = 30286 and field_id = 'field_10_10'
 --INSERT teflow_field_basedata(master_id,form_system_id,section_id,field_id)  VALUES(@master_id,N'30286',N'10',N'field_10_10')
 
  delete from teflow_field_basedata where form_system_id = 30322 and field_id = 'field_10_10'
 --INSERT teflow_field_basedata(master_id,form_system_id,section_id,field_id)  VALUES(@master_id,N'30322',N'10',N'field_10_10')