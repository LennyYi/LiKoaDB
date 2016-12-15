--
IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[TNOVA_Product_mapping]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE dbo.[TNOVA_Product_mapping]

CREATE TABLE [dbo].[TNOVA_Product_mapping](
	[NOVA_PRODCODE] [char](5) NOT NULL,
	[NOVA_PRODCODE_Local] [nchar](20) NOT NULL,
	[NOVA_BENPLNCD] [char](3) NOT NULL,
	[NOVA_BENPLNCD_Local] [nchar](20) NOT NULL,
	[PRODCODE] [char](5) NOT NULL,
	[PRODCODE_Local] [nchar](20) NOT NULL,
	[BENPLNCD] [char](3) NOT NULL,
	[SHIP] [char](1) NOT NULL
) ON [PRIMARY]

go