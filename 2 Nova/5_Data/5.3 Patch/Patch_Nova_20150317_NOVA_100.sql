--2015-03-17 Sting Wu for task NOVA-100

update teflow_form_section_field set default_value = '061' where form_system_id in (20259,20261,20264,20267) and field_id = 'field_9_6'

declare @dbName varchar(1000),@sql nvarchar(1000)

select @dbName = param_value from teflow_param_config where param_code = 'CompassDB'

select @sql = N'update t1 set t1.MEMNATION = ''061'' from '+ @dbName + N'..tmember t1 
inner join teflow_20264_02 t2 on t1.clntcode = t2.field_02_16 collate SQL_Latin1_General_CP1_CI_AS
	and t2.field_02_16 is not null and t2.field_02_16 <> ''''
	and t1.MEMNATION = ''086'' '

exec sp_executesql @sql

select @sql = N'update '+ @dbName + N'.NOVA.TMEMBER_TEMPLATE SET MEMNATION=''061'' WHERE MEMNATION = ''86'' OR MEMNATION = ''086'' '

exec sp_executesql @sql