--
IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[teflow_report_type]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN

CREATE TABLE [dbo].[teflow_report_type](
	[report_type_id] [char](2) NOT NULL,
	[report_type_name] [varchar](50) NOT NULL,
	[description] [varchar](100) NULL,
	 CONSTRAINT [PK_teflow_report_type] PRIMARY KEY CLUSTERED 
(
	[report_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

) ON [PRIMARY]

END