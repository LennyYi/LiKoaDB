-- 20150526 Justin Bin
if exists (select 1 from sys.columns where name='field_planDetail_5' and [object_id] =(select id from sysobjects where name='teflow_30328_planDetail'))
	alter table teflow_30328_planDetail alter column  field_planDetail_5 numeric(10, 2) NULL
else
	alter table teflow_30328_planDetail add  field_planDetail_5 numeric(10, 2) NULL
	
if exists (select 1 from sys.columns where name='field_planDetail_6' and [object_id] =(select id from sysobjects where name='teflow_30328_planDetail'))
	alter table teflow_30328_planDetail alter column  field_planDetail_6 numeric(10, 2) NULL
else
	alter table teflow_30328_planDetail add  field_planDetail_6 numeric(10, 2) NULL

	
if exists (select 1 from sys.columns where name='field_planDetail_7' and [object_id] =(select id from sysobjects where name='teflow_30328_planDetail'))
	alter table teflow_30328_planDetail alter column  field_planDetail_7 numeric(10, 2) NULL
else
	alter table teflow_30328_planDetail add  field_planDetail_7 numeric(10, 2) NULL