--DROP TABLE TNOVA_SDRequest

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.TNOVA_SDRequest'))
BEGIN
	CREATE TABLE dbo.TNOVA_SDRequest(
		NOVAREQNO varchar(30) NOT NULL,
		ReqBy	CHAR(08) NOT NULL,
		SubmitDATE	DATETIME NOT NULL,
		ApproveDATE	DATETIME NULL,
		POLNO char(10) NOT NULL,
		BILLPRDFR char(10) NOT NULL,
		FILEPATH varchar(500) NULL

		CONSTRAINT [PK_TNOVA_SDRequest] PRIMARY KEY CLUSTERED 
		(
			[NOVAREQNO] ASC
		)
	)
END

--Add GROWTHDEF
IF NOT EXISTS (SELECT TC.NAME FROM DBO.SYSCOLUMNS TC WHERE TC.ID = OBJECT_ID('DBO.TNOVA_SDRequest') AND TC.NAME = N'GROWTHDEF')
BEGIN
	ALTER TABLE DBO.TNOVA_SDRequest ADD GROWTHDEF VARCHAR(20) NOT NULL CONSTRAINT DF_TNOVA_SDRequest_GROWTHDEF DEFAULT 'CHGSTATUS'
END

IF NOT EXISTS (SELECT TC.NAME FROM DBO.SYSCOLUMNS TC WHERE TC.ID = OBJECT_ID('DBO.TNOVA_SDRequest') AND TC.NAME = N'ASSIGNDATE')
BEGIN
	ALTER TABLE DBO.TNOVA_SDRequest ADD ASSIGNDATE CHAR(10) NULL
END