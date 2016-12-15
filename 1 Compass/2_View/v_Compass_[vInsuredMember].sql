
if exists (select * from sysobjects where id = object_id('dbo.vInsuredMember') and sysstat & 0xf = 2)
	drop VIEW dbo.vInsuredMember
GO
 
CREATE VIEW [dbo].[vInsuredMember] --WITH SCHEMABINDING

AS 

SELECT	DISTINCT T2.POLNO, T1.CLNTCODE, T1.CERTNO, '1' AS DEPCODE, T1.MEMIDNO
FROM	dbo.TMEMBER		T1, 
		dbo.TMEMPTPOL	T2,
		dbo.TPOLICY		T3,
		dbo.TCLIENT		T4
WHERE	T1.CLNTCODE		= T2.CLNTCODE
AND		T1.CERTNO		= T2.CERTNO
AND		T1.EFFDATE = (SELECT MAX(TMEM2.EFFDATE)
			FROM TMEMBER TMEM2 
			WHERE TMEM2.CLNTCODE = T1.CLNTCODE 
			AND   TMEM2.CERTNO = T1.CERTNO 
			AND   TMEM2.EFFDATE <= GETDATE()
			AND   TMEM2.RCDSTS = 'A')
AND		T1.CHGEFFDT  = (SELECT MAX(TMEM2.CHGEFFDT)
			FROM TMEMBER TMEM2 
			WHERE TMEM2.CLNTCODE = T1.CLNTCODE 
			AND   TMEM2.CERTNO =   T1.CERTNO 
			AND   TMEM2.EFFDATE = T1.EFFDATE
			AND   TMEM2.RCDSTS = 'A')
AND		T1.STATUS	= 'A'
AND		T1.RCDSTS	= 'A'
AND		T2.POLNO	= T3.POLNO
AND		T3.RCDSTS	= 'A'
AND		T3.STATUS	= 'A'	--STATUS
AND		T1.CLNTCODE	= T4.CLNTCODE
AND		T4.RCDSTS	= 'A'	--STATUS
AND		T4.STATUS	= 'A'
AND		T2.CHGEFFDATE	= (SELECT MAX(T5.CHGEFFDATE) FROM TMEMPTPOL T5
					WHERE	T5.CLNTCODE 	= T2.CLNTCODE
					AND	T5.POLNO	= T2.POLNO
					AND	T5.CERTNO	= T2.CERTNO
					AND	T5.DEPCODE	= T2.DEPCODE
					AND	T5.PRODCODE	= T2.PRODCODE
					AND	T5.COVGCODE	= T2.COVGCODE
					AND	T5.BENPLNCD	= T2.BENPLNCD
					AND	T5.CHGEFFDATE	<= GETDATE()
					AND	T5.RCDSTS	= 'A')		
AND	T2.CHGEFFDT	= (SELECT MAX(T6.CHGEFFDT) FROM TMEMPTPOL T6
					WHERE	T6.CLNTCODE 	= T2.CLNTCODE
					AND	T6.POLNO	= T2.POLNO
					AND	T6.CERTNO	= T2.CERTNO
					AND	T6.DEPCODE	= T2.DEPCODE
					AND	T6.PRODCODE	= T2.PRODCODE
					AND	T6.COVGCODE	= T2.COVGCODE
					AND	T6.BENPLNCD	= T2.BENPLNCD
					AND	T6.CHGEFFDATE	= T2.CHGEFFDATE
					AND	T6.RCDSTS	= 'A')
AND	T2.RCDSTS	= 'A'
AND	T2.PRDSTATUS = 'A'

GO

--CREATE UNIQUE CLUSTERED INDEX INDEX_vInsuredMember ON dbo.vInsuredMember(MEMIDNO)

--GO