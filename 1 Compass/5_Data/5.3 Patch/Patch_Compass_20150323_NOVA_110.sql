--2015-03-23 Sting Wu for NOVA-110
--SZ
delete from TSYSPARMH where PARMDESC='NOVASP' and PARMTYPE in ('20259')
and VALUEUSAGE in ('USPGNOVAOFFICIALBILL_TM', 'USPGNOVAOFFICIALBILL') 

delete from T_Nova_CompassProcess where form_system_id= 20259

insert into T_Nova_CompassProcess
select form_system_id= 20259,
current_node_Id = 28,
process_sp = 'USPGNOVAAnalyseXML',
error_code = 'E004'

--JS
delete from TSYSPARMH where PARMDESC='NOVASP' and PARMTYPE in ('20261')
and VALUEUSAGE in ('USPGNOVAOFFICIALBILL_TM', 'USPGNOVAOFFICIALBILL') 

delete from T_Nova_CompassProcess where form_system_id= 20261

insert into T_Nova_CompassProcess
select form_system_id= 20261,
current_node_Id = 28,
process_sp = 'USPGNOVAAnalyseXML',
error_code = 'E004'