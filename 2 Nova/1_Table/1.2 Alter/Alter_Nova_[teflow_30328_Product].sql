-- 20150525 Justin Bin
if exists (select 1 from sys.columns where name='field_Product_10' and [object_id] =(select id from sysobjects where name='teflow_30328_product'))
	alter table teflow_30328_product alter column  field_Product_10 varchar(10)
else
	alter table teflow_30328_product add  field_Product_10 varchar(10)