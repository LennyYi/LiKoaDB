--
IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[TRptRemark]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN

CREATE TABLE [dbo].[TRptRemark](
	[RemarkCode] [varchar](6) NOT NULL,
	[RemarkContent] nvarchar(max) NULL
	 CONSTRAINT [PK_TRptRemark] PRIMARY KEY CLUSTERED 
(
	[RemarkCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END