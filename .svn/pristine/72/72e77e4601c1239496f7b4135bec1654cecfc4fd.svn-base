-- 20150402 Justin Bin NOVA-139
begin tran
delete from TNovaFieldMapping where to_table = 'tclntsub' 
									and to_field = 'SICCODE' 
									and form_system_id in (select form_system_id from teflow_form where form_id in ('GCPA_Form','NBForm','FlexSZ_NBForm','JS_NBForm','NBForm_SH','NBForm_BJ'))
insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select form_system_id
		,'from_table'='teflow_'+cast(form_system_id as varchar)+'_02'
		,'from_field'='field_02_8'
		,'Mul_Field'='Teflow_'+cast(form_system_id as varchar)+'_11.id'
		,'to_table'='TCLNTSUB'
		,'to_field'='SICCODE'
		,'datetype'=''
		,'key_field'=''
		,'order'='1'
from teflow_form where form_id in ('GCPA_Form','NBForm','FlexSZ_NBForm','JS_NBForm','NBForm_SH','NBForm_BJ')

commit tran
