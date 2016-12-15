--Created by Sting Wu
--Created at 2015-02-10
--Created for initial table in Compass

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[T_Nova_InsertCheck]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE dbo.[T_Nova_InsertCheck]

CREATE TABLE [dbo].[T_Nova_InsertCheck](
	[tableName] [varchar](200) NULL,
	[insert_Script] [nvarchar](4000) NULL,
	[request_no] [varchar](30) NULL,
	orderby int null
) ON [PRIMARY]

go
