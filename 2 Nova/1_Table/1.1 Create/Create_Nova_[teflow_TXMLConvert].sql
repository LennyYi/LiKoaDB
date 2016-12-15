--
IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[teflow_TXMLConvert]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE dbo.[teflow_TXMLConvert]

CREATE TABLE [dbo].[teflow_TXMLConvert](
	[NovaXML] [xml] NULL,
	[request_no] [varchar](30) NULL
) ON [PRIMARY]

go
