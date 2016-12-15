
if not exists(select 1 from sys.columns where OBJECT_id('NOVA.TBILLDETAIL_NOVA_TEMPLATE') = object_id and name = 'FYRENCODE')
	alter table NOVA.TBILLDETAIL_NOVA_TEMPLATE add  FYRENCODE char(1);