IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[teflow_20267_productplan]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	CREATE TABLE [dbo].[teflow_20267_productplan](
		[PKGPRDCD] [char](5) NOT NULL,
		[OCCUPCLASS] [char](2) NOT NULL,
		[PLANCODE] [char](3) NOT NULL,
		[PRODCODE] [char](5) NOT NULL,
		[PLANDESC] [nvarchar](80) NOT NULL,
		[NUMMEM] [int] NOT NULL,
		[ID] [decimal](9, 0) NOT NULL,
		[request_no] [varchar](30) NOT NULL
	) ON [PRIMARY]
END