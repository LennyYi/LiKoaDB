if exists (select 1 from sys.columns where name='field_10_10' and [object_id] =(select id from sysobjects where name='teflow_30328_10'))
	alter table teflow_30328_10 alter column  field_10_10 varchar(2)
else
	alter table teflow_30328_10 add  field_10_10 varchar(2)