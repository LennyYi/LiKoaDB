--Add by Colin Wang from Report function

--Add by Colin Wang from Report function

if not exists (select 1 from sys.columns where name='report_system_id' and object_id=(select object_id from sys.objects where name='teflow_form_section_field' and type='U'))
begin
	alter table teflow_form_section_field
	add report_system_id int NULL
end


if not exists (select 1 from sys.columns where name='report_type' and object_id=(select object_id from sys.objects where name='teflow_form_section_field' and type='U'))
begin
	alter table teflow_form_section_field
	add report_type char(1) NULL
end


if not exists (select 1 from sys.columns where name='is_disabled' and object_id=(select object_id from sys.objects where name='teflow_form_section_field' and type='U'))
begin
	alter table teflow_form_section_field
	add is_disabled int NULL
end


