if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[search_main]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
     drop procedure [dbo].[search_main]
GO
/*********************** REVISION LOG: ***********************************
Version			Date			Revised by				Remark
1.0				20150304		Colin					initial
**************************************************************************/

CREATE PROCEDURE [dbo].[search_main]
(@searchType nvarchar(20),
@searchKey nvarchar(100))
AS
BEGIN
SET NOCOUNT ON
	if(@searchType = 'policy')
	begin
		select distinct  T1.POLNO,POLDESC =RTRIM(T1.POLDESC),displaycolumn = T1.POLNO+'('+RTRIM(T1.POLDESC)+')',T2.BranchCode,T3.BUSNSRCE
			 ,packaged = (case when T3.BUSNTYPE='PACRO' or T4.PRODTYPE = 'P' then 'Y' else 'N' end)
			from TPOLICY T1 
			inner join TPOLADDH T2 ON T1.POLNO = T2.POLNO
			inner join TPOLPDT T3 on T1.POLNO = T3.POLNO
			left join TPRODUCT T4 on T3.PRODCODE = T4.PRODCODE
		where T1.POLNO like N'%'+@searchKey+'%' or T1.POLDESC like N'%'+@searchKey+'%'
		order by T1.POLNO,T2.BranchCode,packaged
	end
	
	if(@searchType = 'client')
	begin
		select distinct c.CLNTCODE,c.CLNTNAME,p.POLNO ,displaycolumn = c.CLNTCODE+'('+RTRIM(c.CLNTNAME)+')',T2.BranchCode,T3.BUSNSRCE
			 ,packaged = (case when T3.BUSNTYPE='PACRO' or T4.PRODTYPE = 'P' then 'Y' else 'N' end)
		from TCLIENT c,TPOLICY p 
			inner join TPOLADDH T2 ON p.POLNO = T2.POLNO
			inner join TPOLPDT T3 on p.POLNO = T3.POLNO
			left join TPRODUCT T4 on T3.PRODCODE = T4.PRODCODE
		where p.CLNTCODE = c.CLNTCODE and c.CLNTCODE like N'%'+@searchKey+'%' or c.CLNTNAME like N'%'+@searchKey+'%'
		order by c.CLNTCODE,c.CLNTNAME,p.POLNO ,T2.BranchCode,packaged
	end
	
	if(@searchType = 'member')
	begin
        SELECT DISTINCT  T1.CLNTCODE , T1.CERTNO, T3.POLNO,T2.CLNTNAME,T1.MEMIDNO,T1.DEPCODE,T1.STATUS,T1.SUBOFFCODE,userName = RTRIM(ISNULL(T1.NAMEFIRST,N'')) + N' ' + RTRIM(ISNULL(T1.NAMEMID,N'')) + N' ' + RTRIM(ISNULL(T1.NAMELAST,N'')),displaycolumn = T1.MEMIDNO+'('+RTRIM(ISNULL(T1.NAMEFIRST,N'')) + N' ' + RTRIM(ISNULL(T1.NAMEMID,N'')) + N' ' + RTRIM(ISNULL(T1.NAMELAST,N''))+')'
        FROM (SELECT CLNTCODE,CERTNO,'1' AS DEPCODE,MEMIDNO,NAMEFIRST,NAMEMID,NAMELAST,STATUS,SUBOFFCODE,RANK() OVER (PARTITION BY CLNTCODE,CERTNO ORDER BY CHGEFFDT DESC,EFFDATE DESC) ROWNUM 
        		FROM TMEMBER 
				WHERE RCDSTS = 'A' AND EFFDATE < GETDATE()
			 	UNION ALL 
			 	SELECT CLNTCODE,CERTNO,CAST(DEPCODE AS VARCHAR) AS DEPCODE,DEPIDNO AS MEMIDNO,NAMEFIRST,NAMEMID,NAMELAST,STATUS,
				SUBOFFCODE = (select SUBOFFCODE from (select ROW_NUMBER()over(order by CERTNO) as rn, SUBOFFCODE from TMEMBER M where M.CERTNO = CERTNO )T where T.rn=1),
				RANK() OVER (PARTITION BY CLNTCODE,CERTNO ORDER BY CHGEFFDT DESC,EFFDATE DESC) ROWNUM 
			 	FROM TDEPENDENT
				WHERE RCDSTS = 'A' AND EFFDATE < GETDATE()
			  ) T1
        INNER JOIN  TCLIENT T2 
        ON T1.CLNTCODE = T2.CLNTCODE AND ROWNUM = 1 
		AND (T1.MEMIDNO LIKE N'%'+@searchKey+'%' OR LTRIM(RTRIM((RTRIM(T1.NAMEFIRST)) + N' '+ RTRIM(T1.NAMEMID) + N' '+ RTRIM(T1.NAMELAST))) LIKE N'%'+@searchKey+'%') 
		inner join TPOLICY T3 on T3.CLNTCODE = T1.CLNTCODE and ROWNUM = 1
		order by T1.MEMIDNO asc
	end


END