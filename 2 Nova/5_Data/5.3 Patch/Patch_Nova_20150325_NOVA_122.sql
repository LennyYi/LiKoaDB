--2015-03-25 Sting Wu for NOVA-122

update teflow_form_section_field set event_onblur = 'IdValidation(this,0);OtherChecking(this)' 
where form_system_id in ('20259','20261','20264','20267') and field_id = 'field_9_7'

update teflow_form_section_field set event_onfocus = 'RemoveCheckingMsg(this)' 
where form_system_id in ('20259','20261','20264','20267') and field_id = 'field_9_7'