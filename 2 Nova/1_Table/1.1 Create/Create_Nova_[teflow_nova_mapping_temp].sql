--

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[teflow_nova_mapping_temp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE dbo.[teflow_nova_mapping_temp]

create table teflow_nova_mapping_temp 
( to_table varchar(30) null,
to_field varchar(30)  null,
key_field varchar(30)  null,
id varchar(30)  null,
value nvarchar(2000)  null,
[order] [decimal](10, 2) null, 
request_no varchar(30) null
)
