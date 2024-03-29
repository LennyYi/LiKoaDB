-- 20150416 Justin Bin Patched
begin tran
-- update new
update  teflow_base_data_detail set option_label=option_value+' - Class'+option_value where master_id=(select top 1 master_id  from teflow_base_data_master where field_name='职业等级')

declare @oldMasterId decimal(18,0),@id decimal(18,0)
set @oldMasterId=(select top 1 master_id  from teflow_base_data_master where field_name='职业等级(江苏)')
delete from teflow_base_data_master where master_id=@oldMasterId

--set identity_insert [teflow_base_data_master] on
insert into teflow_base_data_master (field_name,type_code ) values ('职业等级(江苏)','01')
select @id=@@IDENTITY 

delete from teflow_base_data_detail where master_id=@oldMasterId 
insert into teflow_base_data_detail (master_id,option_value,option_label,[status] ) values (@id,'1','1','')
insert into teflow_base_data_detail (master_id,option_value,option_label,[status] ) values (@id,'2','2','')
insert into teflow_base_data_detail (master_id,option_value,option_label,[status] ) values (@id,'3','3','')
insert into teflow_base_data_detail (master_id,option_value,option_label,[status] ) values (@id,'4','4','')
insert into teflow_base_data_detail (master_id,option_value,option_label,[status] ) values (@id,'5','5','')

delete from teflow_field_basedata where form_system_id='20261' and field_id ='field_9_15' and section_id='9'
insert into teflow_field_basedata (master_id,form_system_id,section_id,field_id ) values (@id,'20261','9','field_9_15')

commit tran