--
--Created by Sting Wu
--Created at 2015-02-10
--Created for initial table in Nova

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[TNOVA_favorite]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE dbo.[TNOVA_favorite]

CREATE TABLE [dbo].[TNOVA_favorite](
	Staff_code varchar(10) not null,
	form_system_id decimal(18,0) not null
) ON [PRIMARY]

go