--Created by Sting Wu
--Created at 2015-02-10
--Created for initial table in Compass

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[T_Nova_ErrlogTran]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE dbo.[T_Nova_ErrlogTran]

create table T_Nova_ErrlogTran (
	RequestNo		varchar(30)		NULL,
	ProgramID		varchar(60)		NULL,
	ERRORLOG		nvarchar(3000)	NULL,
	RCDUSRID		char(8)			NULL,
	RCDDTSTMP		datetime		NULL
)
go
