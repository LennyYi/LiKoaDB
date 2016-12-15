
UPDATE TNOVAFIELDMAPPING SET from_table  = CONCAT('Teflow_' , rtrim(form_system_id) , '_2' ) ,from_field  = 'field_2_10', Mul_Field = CONCAT('Teflow_' , rtrim(form_system_id) , '_11.id' ) WHERE to_table = 'TBANKACCTINFO' AND to_field = 'PAYEENAME'
UPDATE TNOVAFIELDMAPPING SET from_table  = CONCAT('Teflow_' , rtrim(form_system_id) , '_2' ) ,from_field  = 'field_2_10', Mul_Field = CONCAT('Teflow_' , rtrim(form_system_id) , '_11.id' ) WHERE to_table = 'tclntsub' AND to_field = 'PAYEENAME'
