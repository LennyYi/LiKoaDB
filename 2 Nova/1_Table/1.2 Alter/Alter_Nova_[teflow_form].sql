--Add by Lenny yi from Nova_303 add submitAlias column and saveAlias column
if not exists (select 1 from sys.columns where name='submitAlias' and object_id=(select object_id from sys.objects where name='teflow_form' and type='U'))
begin
	alter table teflow_form
	add submitAlias varchar(12) NULL
end

if not exists (select 1 from sys.columns where name='saveAlias' and object_id=(select object_id from sys.objects where name='teflow_form' and type='U'))
begin
	alter table teflow_form
	add saveAlias varchar(12) NULL
end

