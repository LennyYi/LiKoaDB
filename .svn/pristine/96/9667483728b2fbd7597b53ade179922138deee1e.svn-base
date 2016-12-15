--
IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[teflow_nova_mapping]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE dbo.[teflow_nova_mapping]

CREATE TABLE [dbo].[teflow_nova_mapping](
	[form_system_id] [int] NOT NULL,
	[from_table] [varchar](13) NULL,
	[from_field] [varchar](200) NULL,
	[Mul_Field] [varchar](200) NULL,
	[to_table] [varchar](200) NULL,
	[to_field] [varchar](200) NULL,
	[datetype] [varchar](8) NULL,
	[key_field] [varchar](20) NULL,
	[order] [decimal](10, 2) NULL
) ON [PRIMARY]

go