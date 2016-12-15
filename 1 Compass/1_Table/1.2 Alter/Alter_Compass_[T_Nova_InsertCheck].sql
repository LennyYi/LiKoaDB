--20150227 Sting Wu alter table for issue NOVA-16

if not exists (select 1 from sys.columns where name = 'orderby' and object_id = object_id('T_Nova_InsertCheck'))
	alter table T_Nova_InsertCheck add orderby int null