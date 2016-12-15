--Add by Colin Wang from Search function

if not exists (select 1 from sys.columns where name='section_url' and object_id=(select object_id from sys.objects where name='teflow_form_section' and type='U'))
begin
	alter table teflow_form_section
	add section_url varchar(300) NULL
end


if not exists (select 1 from sys.columns where name='export_excel' and object_id=(select object_id from sys.objects where name='teflow_form_section' and type='U'))
begin
	alter table teflow_form_section
	add export_excel char(1) NULL
end

if not exists (select 1 from sys.columns where name='teflow_form_proce' and object_id=(select object_id from sys.objects where name='teflow_form_section' and type='U'))
begin
	alter table teflow_form_section
	add teflow_form_proce varchar(40) NULL
end

