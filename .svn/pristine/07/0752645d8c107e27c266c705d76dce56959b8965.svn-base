--
IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[teflow_report_instance]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE dbo.[teflow_report_instance]

CREATE TABLE [dbo].[teflow_report_instance](
	[report_system_id] [int] NOT NULL,
	[form_request_no] [varchar](30) NULL,
	[report_no] [varchar](50) NULL,
	[repost_vsersion] [int] NULL
) ON [PRIMARY]

go



