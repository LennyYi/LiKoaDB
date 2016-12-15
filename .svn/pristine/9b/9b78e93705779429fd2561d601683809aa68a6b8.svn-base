-- default CLMPAYEETYPE for GD GCPA Form 20150402 Justin Bin NOVA-141
-- 20150403 add defulat clmsid, batchbillerid

begin tran
delete from nova.tpoladdh_template where  FORM_SYSTEM_ID ='20267' and CLMPAYEETYPE='I'
select top 1 * into #temp1 from nova.tpoladdh_template where FORM_SYSTEM_ID in ('0')
update #temp1 set CLMPAYEETYPE='I', FORM_SYSTEM_ID='20267',CLMSID = 'EGMD123' ,BATCHBILLERID = NULL
insert into NOVA.tpoladdh_template select * from #temp1 
drop table #temp1

commit tran