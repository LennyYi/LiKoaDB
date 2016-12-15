if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[UspGNOVAGetMemByUserNameMemIDNo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
     drop procedure [dbo].[UspGNOVAGetMemByUserNameMemIDNo]
GO
/*********************** REVISION LOG: ***********************************
Version			Date			Revised by				Remark
1.0				20150331		Sting				initial
**************************************************************************/
CREATE PROCEDURE [dbo].[UspGNOVAGetMemByUserNameMemIDNo]
(	
	@cClntCode				CHAR(5),
	@cPOLNO					CHAR(10),
	@cChangeEffDate         CHAR(10),
	@cMEMIDNO				CHAR(18),
	@cNAMELAST				NVARCHAR(30) 
)
AS
BEGIN
SET NOCOUNT ON

	SELECT DISTINCT T1.CLNTCODE, 
	T1.SUBOFFCODE, 
	T1.CERTNO, 
	NAMELAST = NOVA.funReplaceSpecN(isnull(T1.NAMELAST,''),0), 
	ADDR = NOVA.funReplaceSpecN(isnull(T2.ADDRESS1,''),0) 
		+ NOVA.funReplaceSpecN(isnull(T2.ADDRESS2,''),0) 
		+ NOVA.funReplaceSpecN(isnull(T2.ADDRESS3,''),0),
	MEMIDNO = NOVA.funReplaceSpecN(isnull(T1.MEMIDNO,''),0)
	FROM (SELECT DISTINCT T1.CLNTCODE, T1.SUBOFFCODE, T1.CERTNO, T1.NAMELAST, T1.MEMIDNO,
			RANK() OVER(PARTITION BY T1.CLNTCODE, T1.CERTNO ORDER BY T1.CHGEFFDT DESC,T1.EFFDATE DESC) AS MEMROWNUM
		FROM TMEMBER T1 WHERE T1.CLNTCODE = @cClntCode AND T1.EFFDATE <= @cChangeEffDate AND (T1.MEMIDNO = @cMEMIDNO OR T1.NAMELAST = @cNAMELAST) 
			AND T1.RCDSTS = 'A') T1
	inner join (SELECT DISTINCT CLNTCODE,CERTNO,PRDSTATUS,RANK() OVER(PARTITION BY CLNTCODE, CERTNO, DEPCODE, POLNO, PRODCODE, BENPLNCD, COVGCODE, SUBOFFCODe 
		order by CHGEFFDATE desc, CHGEFFDT desc) ROWNUM from tmemptpol where CLNTCODE = @cClntCode AND POLNO = @cPOLNO and CHGEFFDATE <= @cChangeEffDate  
			and RCDSTS = 'A' ) T3 on t3.clntcode = t1.CLNTCODE and t3.certno = t1.CERTNO AND T3.PRDSTATUS = 'A' AND T1.MEMROWNUM = 1  AND T3.ROWNUM = 1  
	left join TMEMADDR T2 on T1.CLNTCODE = T2.CLNTCODE and T1.CERTNO = T2.CERTNO 
END