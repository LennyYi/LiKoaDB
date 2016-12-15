if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[UspGNOVAGetClntInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
     drop procedure [dbo].[UspGNOVAGetClntInfo]
GO
/*********************** REVISION LOG: ***********************************
Version			Date			Revised by				Remark
1.0				20150304						initial
**************************************************************************/
CREATE PROCEDURE [dbo].[UspGNOVAGetClntInfo]
(	
	@cCLNTCODE	char(5),
	@cCLNTNAME	nchar(60)
)
AS
BEGIN
SET NOCOUNT ON

		SELECT T1.CLNTCODE,
		[Address] = NOVA.funReplaceSpecN(isnull(T1.ADDRESS1,''),0) 
			+ NOVA.funReplaceSpecN(isnull(T1.ADDRESS2,''),0) 
			+ NOVA.funReplaceSpecN(isnull(T1.ADDRESS3,''),0)
			+ NOVA.funReplaceSpecN(isnull(T1.ADDRESS4,''),0),
		TELNO = NOVA.funReplaceSpecN(T1.TELNO,0),
		MAILCODE = NOVA.funReplaceSpecN(isnull(RTRIM(T1.MAILCODE),''),0),
		EMAILADDR = NOVA.funReplaceSpecN(isnull(RTRIM(T1.EMAILADDR),''),0),
		CLNTNAME = NOVA.funReplaceSpecN(T1.CLNTNAME,0),
		CLNTNAMEGEN = NOVA.funReplaceSpecN(T1.CLNTNAMEGEN,0),
		CONTPERSON = NOVA.funReplaceSpecN(T1.CONTPERSON,0),
		SICCODE = NOVA.funReplaceSpecN(T1.SICCODE,0),
		TAXID = NOVA.funReplaceSpecN(T1.TaxID,0),
		BANKAC = NOVA.funReplaceSpecN(T1.BANKAC,0),
		BANKCODE = NOVA.funReplaceSpecN(T1.BANKCODE,0),
		BANKBRNAME = NOVA.funReplaceSpecN(T1.BANKBRNAME,0),
		PRMRFBANKACCT = NOVA.funReplaceSpecN(T1.PRMRFBANKACCT,0),
		PRMRFBANKCODE = NOVA.funReplaceSpecN(T1.PRMRFBANKCODE,0),
		PRMRFBANKBRNAME = NOVA.funReplaceSpecN(T1.PRMRFBANKBRNAME,0),
		PAYEENAME = NOVA.funReplaceSpecN(T1.PAYEENAME,0),
		CITYCODE = isnull(RTRIM(T2.CITYCODE),''),
		T1.[STATUS],
		STATEFFDT1 = convert(varchar, T1.STATEFFDT, 101),
		STATEFFDT2 = convert(varchar, T1.STATEFFDT, 23),
		USERDEFINED1 = NOVA.funReplaceSpecN(isnull(T3.USERDEFINED1,''),0)
		FROM TCLIENT T1  
		INNER JOIN TCLNTSUB T3 ON T1.CLNTCODE = T3.CLNTCODE 
			AND T3.SUBOFFCODE = '100'
			AND (T1.CLNTNAME = @cCLNTNAME OR @cCLNTNAME=N'') 
			AND (T1.CLNTCODE = @cCLNTCODE OR @cCLNTCODE='') 
			AND T1.RCDSTS<>'D'
		LEFT JOIN (SELECT MIN(CITYCODE) AS CITYCODE,CLNTCODE FROM TBANKACCTINFO GROUP BY CLNTCODE) T2 ON T1.CLNTCODE = T2.CLNTCODE
END


