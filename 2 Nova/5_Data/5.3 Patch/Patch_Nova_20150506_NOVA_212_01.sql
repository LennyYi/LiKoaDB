IF EXISTS(SELECT 1 FROM sysobjects WHERE name = N'teflow_30319_Pend' AND xtype='U')
DROP TABLE teflow_30319_Pend;
GO

CREATE TABLE teflow_30319_Pend (
	PendingList   varchar(100) NULL,
	field_Pend_3  varchar(500) NULL,
	field_Pend_5 varchar(1) NULL,
	id numeric(12, 0) IDENTITY(1,1) NOT NULL,
	request_no varchar (30) NULL
) ON [PRIMARY];

Declare
 @formId varchar(10),
 @newmaster_id varchar(10);
set @formId=30319;
set @newmaster_id=10211;
begin
update  teflow_form_section  set order_id='94'  where section_remark= N'系统流程控制' and form_system_id=30319 and table_name=N'teflow_30319_SystemFW';
delete from teflow_form_section where form_system_id = @formId and section_id =  'Pend' 
Insert into teflow_form_section ( form_system_id, section_id, section_type, section_remark, table_name, ORDER_ID )  values ( 30319,  'Pend' ,  '01' ,  '照会列表' ,  'teflow_30319_Pend' ,  '93'  ); 
select * from teflow_form_section where form_system_id=30319;
delete from teflow_form_section_field where form_system_id = @formId and section_id = 'Pend' ;
Insert into teflow_form_section_field ( form_system_id, section_id, field_id, field_label, field_type, is_required, data_type, field_length, source_type, source_sql, order_id, decimal_digits, high_level, is_money, is_singlerow, controls_width, controls_height, field_comments, comment_content, is_readonly, event_click, event_dbclick, event_onfocus, event_onblur, event_onchange, default_value, column_width )  values ( 30319,  'Pend' ,  'field_Pend_3' ,  '照会内容' , 1, -1, 1, 500, 0,  '' , 3, 0, -1, -1, -1, 500, 0,  '' ,  '' , -1,  '' ,  '' ,  '' ,  '' ,  '' ,  '' , 25 ); 
Insert into teflow_form_section_field ( form_system_id, section_id, field_id, field_label, field_type, is_required, data_type, field_length, source_type, source_sql, order_id, decimal_digits, high_level, is_money, is_singlerow, controls_width, controls_height, field_comments, comment_content, is_readonly, event_click, event_dbclick, event_onfocus, event_onblur, event_onchange, default_value, column_width )  values ( 30319,  'Pend' ,  'field_Pend_5' ,  '是否完成' , 6, -1, 1, 1, 0,  '' , 5, 0, -1, -1, -1, 0, 0,  '' ,  '' , -1,  '' ,  '' ,  '' ,  '' ,  '' ,  '' , 10 ); 
Insert into teflow_form_section_field ( form_system_id, section_id, field_id, field_label, field_type, is_required, data_type, field_length, source_type, source_sql, order_id, decimal_digits, high_level, is_money, is_singlerow, controls_width, controls_height, field_comments, comment_content, is_readonly, event_click, event_dbclick, event_onfocus, event_onblur, event_onchange, default_value, column_width )  values ( 30319,  'Pend' ,  'PendingList' ,  '照会' , 7, -1, 1, 100, 0,  '' , 0, 0, -1, 0, -1, 0, 0,  '' ,  '' , -1,  '' ,  '' ,  '' ,  '' ,  '' ,  '200' , 20 ); 
insert into teflow_field_basedata values (@newmaster_id, @formId, 'Pend', 'field_Pend_5');
end;
