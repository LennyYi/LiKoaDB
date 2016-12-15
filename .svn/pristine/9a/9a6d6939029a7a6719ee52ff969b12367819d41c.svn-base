--
IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[teflow_report_script]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

BEGIN
CREATE TABLE [dbo].[teflow_report_script](
	[report_system_id] [decimal](18, 0) NOT NULL,
	[script] nvarchar(max) NULL,
	 CONSTRAINT [PK_teflow_report_script] PRIMARY KEY CLUSTERED 
(
	[report_system_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END