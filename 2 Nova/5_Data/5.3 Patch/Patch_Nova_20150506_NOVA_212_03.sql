begin tran
DECLARE @master_id int;
set @master_id=10229;
begin
SET IDENTITY_INSERT teflow_base_data_master   ON
INSERT teflow_base_data_master(master_id,field_name,type_code) VALUES( @master_id,'PendingFormList','01');
SET IDENTITY_INSERT teflow_base_data_master   OFF
INSERT teflow_base_data_detail VALUES( @master_id,30319,'福乐安康4.0',NULL);
INSERT teflow_base_data_detail VALUES( @master_id,20264,'广东组合产品',NULL);
commit
end;

--select option_value from teflow_base_data_detail where master_id=(select master_id from teflow_base_data_master where field_name='PendingFormList' );