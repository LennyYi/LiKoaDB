if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[UspGNOVAGetClntSubInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
     drop procedure [dbo].[UspGNOVAGetClntSubInfo]
GO
/*********************** REVISION LOG: ***********************************
Version			Date			Revised by				Remark
1.0				20150304							initial
**************************************************************************/
CREATE PROCEDURE [dbo].[UspGNOVAGetClntSubInfo]
(	
	@cCLNTCODE	char(5)
)
AS
BEGIN
SET NOCOUNT ON
			
		SELECT  SUBOFFCODE,
		[ADDRESS],
		SUBOFFNAME,
		SUBOFFNAMEGEN,
		MAILCODE,
		CONTPERSON,
		USERDEFINED1,
		TELNO,
		EMAILADDR,
		BANKCODE,
		BANKBRNAME,
		BANKAC,
		CITYCODE
		FROM 
		(SELECT T1.SUBOFFCODE,
		[Address] = NOVA.funReplaceSpecN(isnull(T1.ADDRESS1,''),0) 
			+ NOVA.funReplaceSpecN(isnull(T1.ADDRESS2,''),0) 
			+ NOVA.funReplaceSpecN(isnull(T1.ADDRESS3,''),0)
			+ NOVA.funReplaceSpecN(isnull(T1.ADDRESS4,''),0),
		SUBOFFNAME = NOVA.funReplaceSpecN(SUBOFFNAME,0),
		SUBOFFNAMEGEN = NOVA.funReplaceSpecN(SUBOFFNAMEGEN,0),
		MAILCODE = NOVA.funReplaceSpecN(isnull(RTRIM(MAILCODE),''),0),
		CONTPERSON = NOVA.funReplaceSpecN(CONTPERSON,0),
		USERDEFINED1 = NOVA.funReplaceSpecN(ISNULL(USERDEFINED1,''),0),
		TELNO = NOVA.funReplaceSpecN(TELNO,0),
		EMAILADDR = NOVA.funReplaceSpecN(isnull(RTRIM(EMAILADDR),''),0),
		BANKCODE = NOVA.funReplaceSpecN(T1.BANKCODE,0),
		BANKBRNAME = NOVA.funReplaceSpecN(BANKBRNAME,0),
		BANKAC = NOVA.funReplaceSpecN(T1.BANKAC,0),
		T2.CITYCODE,
		RANK() OVER (PARTITION BY T2.CLNTCODE,T2.SUBOFFCODE,T2.BANKAC ORDER BY T2.SEQNO,T2.CITYCODE) ROWNO FROM TCLNTSUB T1 
		LEFT JOIN TBANKACCTINFO T2 ON T1.CLNTCODE = T2.CLNTCODE 
			AND T1.SUBOFFCODE = T2.SUBOFFCODE 
			AND T1.BANKAC = T2.BANKAC
		WHERE T1.CLNTCODE = @cCLNTCODE
		AND T1.SUBOFFCODE <> '100'
		AND T1.RCDSTS<>'D'
		) T WHERE ROWNO = 1 

END

