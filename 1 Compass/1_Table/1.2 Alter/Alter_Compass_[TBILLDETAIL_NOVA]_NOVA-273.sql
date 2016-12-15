
if not exists(select 1 from sys.columns where OBJECT_id('TBILLDETAIL_NOVA') = object_id and name = 'FYRENCODE')
	alter table TBILLDETAIL_NOVA add  FYRENCODE char(1);