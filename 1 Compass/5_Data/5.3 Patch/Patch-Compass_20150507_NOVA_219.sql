
if exists (select 1 from sys.objects where name = 'TMEMADDR_TEMPLATE' and type = 'U')
	drop table NOVA.TMEMADDR_TEMPLATE

select top 1 * into NOVA.TMEMADDR_TEMPLATE from TMEMADDR