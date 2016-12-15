IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[teflow_nova_ErrlogTran]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE dbo.[teflow_nova_ErrlogTran]

create table teflow_nova_ErrlogTran (
	RequestNo		varchar(30)		NULL,
	ProgramID		varchar(60)		NULL,
	ERRORLOG		nvarchar(3000)	NULL,
	Staff_Code		VARchar(10)			NULL,
	RCDDTSTMP		datetime		NULL
)