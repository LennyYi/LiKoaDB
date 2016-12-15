
IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[TNovaProdRateCd]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	DROP TABLE dbo.[TNovaProdRateCd]
END


CREATE TABLE [dbo].[TNovaProdRateCd](
	[ProdCode] [char](5) NULL,
	[ProdName] [char](50) NULL,
	[LimitCode] [char](50) NULL,
	[RateType] [char](1) NULL,
	[RateCode] [char](5) NULL,
	[OccClassS] [char](1) NULL,
	[OccClassE] [char](1) NULL,
	[Ship] [char](1) NULL,
	[AgeMin] [int] NULL ,
	[AgeMax] [int] NULL ,
	[BeneAmt] DEC(13,2) NULL ,
	[FORM_SYSTEM_ID] [decimal](18, 0) NULL
) ON [PRIMARY]

GO
