--
IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[teflow_report_section_field]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN

CREATE TABLE [dbo].[teflow_report_section_field](
	[report_system_id] [decimal](18, 0) NOT NULL,
	[section_id] [varchar](10) NOT NULL,
	[field_id] [varchar](50) NOT NULL,
	[field_label] [varchar](100) NULL,
	[field_type] [int] NULL,
	[is_required] [int] NULL,
	[data_type] [int] NULL,
	[field_length] [int] NULL,
	[source_type] [int] NULL,
	[source_sql] [varchar](100) NULL,
	[order_id] [int] NULL,
	[decimal_digits] [int] NULL,
	[high_level] [int] NULL,
	[is_singlerow] [int] NULL,
	[controls_width] [int] NULL,
	[controls_height] [int] NULL,
	[field_comments] [varchar](500) NULL,
	[comment_content] [varchar](500) NULL,
	[is_readonly] [int] NULL,
	[default_value] [varchar](50) NULL,
	[column_width] [int] NULL,
	[css_style] [varchar](200) NULL,
	[border] [int] NULL,
	[is_singlelabel] [int] NULL,
	[aligned] [int] NULL
	 CONSTRAINT [PK_teflow_report_section_field] PRIMARY KEY CLUSTERED 
(
	[report_system_id] ASC,
	[section_id] ASC,
	[field_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END