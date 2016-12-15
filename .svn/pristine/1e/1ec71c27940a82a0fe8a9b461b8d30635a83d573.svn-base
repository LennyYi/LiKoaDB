
if not exists (select 1 from sys.columns where name='PREMMODAL' and object_id=(select object_id from sys.objects where name='TEFLOW_PRODUCTPLAN' and type='U'))
begin
	alter table TEFLOW_PRODUCTPLAN
	add [PREMMODAL] [decimal](13, 5) NULL
end


if not exists (select 1 from sys.columns where name='BENAMTMB' and object_id=(select object_id from sys.objects where name='TEFLOW_PRODUCTPLAN' and type='U'))
begin
	alter table TEFLOW_PRODUCTPLAN
	add [BENAMTMB] [decimal](13, 2) NULL
end


if not exists (select 1 from sys.columns where name = 'DEDUCTBEN' and object_id = object_id('teflow_productplan'))
begin
	ALTER TABLE teflow_productplan ADD  DEDUCTBEN DEC(7,2)
end

if not exists (select 1 from sys.columns where name = 'SHIP' and object_id = object_id('teflow_productplan'))
begin
	ALTER TABLE teflow_productplan ADD  SHIP CHAR(1)
end

if not exists (select 1 from sys.columns where name = 'PRMRATECD' and object_id = object_id('teflow_productplan'))
begin
	ALTER TABLE teflow_productplan ADD  PRMRATECD CHAR(5)
end 
