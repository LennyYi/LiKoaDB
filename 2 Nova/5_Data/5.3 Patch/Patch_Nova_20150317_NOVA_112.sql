--2015-03-19 Sting Wu for NOVA-112

update teflow_wkf_detail set reject_alias = '重新填写' where node_name in ('数据确认','信息确认') and flow_id 
in (select flow_id from teflow_wkf_define where form_system_id  in ('20259','20261','20264','20267'))