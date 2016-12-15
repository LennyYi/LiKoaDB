--20150225 Sting Wu intial

delete from TNovaProcess where form_system_id = 20259

insert into TNovaProcess
select * from (
select 20259 as form_system_id,25 as current_node_Id,'NovaUspClearError' as process_sp,'E005' as error_code,NULL as ORDERBY
union all
select 20259 as form_system_id,26 as current_node_Id,'NovaUspFLAKConvert' as process_sp,'E006' as error_code,0 as ORDERBY
union all
select 20259 as form_system_id,26 as current_node_Id,'NovaUspConvertXML' as process_sp,'E001' as error_code,1 as ORDERBY) T



--===================================================================
--20150312 SamYu intial for GCPA

select * into #TNovaProcess from TNovaProcess where form_system_id = '0'
insert into #TNovaProcess(form_system_id,current_node_Id,process_sp,error_code,ORDERBY) values('20267','26','NovaUspGCPAConvert','E006','0') 
update #TNovaProcess set form_system_id = '20267'

--select * from #TNovaProcess order by ORDERBY asc
delete from TNovaProcess where form_system_id = '20267' 
insert into TNovaProcess select * from #TNovaProcess
drop table #TNovaProcess
select * from TNovaProcess where form_system_id = '20267' order by ORDERBY asc