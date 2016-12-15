--20150306 Justin Bin added for commission&count people
--SZ
if not exists (select 1 from sys.columns where name='field_10_6' and object_id=(select object_id from sys.objects where name='teflow_20267_10' and type='U'))
begin
	alter table teflow_20267_10
	add field_10_6  numeric(10,2) null
end

if not exists (select 1 from sys.columns where name='field_10_7' and object_id=(select object_id from sys.objects where name='teflow_20267_10' and type='U'))
begin
	alter table teflow_20267_10
	add field_10_7  numeric(10,0) null
end
