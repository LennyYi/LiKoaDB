--Created by Sting Wu
--Created at 2015-02-10
--Created for initial table in Compass

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[T_Nova_CompassProcess]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE dbo.[T_Nova_CompassProcess]

create table T_Nova_CompassProcess
(
	[form_system_id]	[int]	NOT NULL,
	[current_node_Id]	[int]	NOT NULL,
	[process_sp]		[varchar](100) NULL,
	[error_code]		[char](4)	NULL
) 

go