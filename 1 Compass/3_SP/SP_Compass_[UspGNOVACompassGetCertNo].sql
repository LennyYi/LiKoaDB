if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[UspGNOVACompassGetCertNo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
     drop procedure [dbo].[UspGNOVACompassGetCertNo]
GO

/*********************** REVISION LOG: ***********************************
Version			Date			Revised by				Remark
1.0				20150210		Sting Wu				initial
**************************************************************************/
CREATE PROCEDURE [dbo].[UspGNOVACompassGetCertNo]
(    @cClntCode		CHAR(5), 
     @cIDNo			CHAR(18),
	 @cType         CHAR(1),
	 @cChangeEffDate CHAR(10)
)
AS
BEGIN
SET NOCOUNT ON
	
	select rtrim(CERTNO) as CERTNO,NOVA.funReplaceSpecN(NAMELAST,0) as NAMELAST,
	convert(varchar, EMPDT, 101) as EMPDT, OCCUPATION, 1 AS DEPCODE,[STATUS],
	RANK() OVER (partition by CLNTCODE, CERTNO order by CHGEFFDT desc, EFFDATE desc) ROWNO into #tempCertNo
	from tmember 
	where CLNTCODE = @cClntCode and MEMIDNO = @cIDNo and RCDSTS = 'A' and CHGEFFDT < @cChangeEffDate
	union all
	select rtrim(CERTNO) as CERTNO,NOVA.funReplaceSpecN(NAMELAST,0) as NAMELAST,
	'' as EMPDT,'' as OCCUPATION, DEPCODE,[STATUS],
	RANK() OVER (partition by CLNTCODE, CERTNO, DEPCODE order by CHGEFFDT desc, EFFDATE desc) ROWNO
	from tdependent 
	where CLNTCODE = @cClntCode and DEPIDNO = @cIDNo and RCDSTS = 'A' and CHGEFFDT < @cChangeEffDate
	
	if exists (select 1 from #tempCertNo WHERE ROWNO = 1 AND [STATUS] = 'A')
	begin
		SELECT TOP 1 CERTNO, NAMELAST, EMPDT, OCCUPATION, DEPCODE FROM #tempCertNo t WHERE ROWNO = 1 AND [STATUS] = 'A'
		RETURN
	end
	else
	begin	

        if @cType = 'S'
		   begin
				DECLARE @MAXNUM decimal(11,0)
				DECLARE @MAXCERT CHAR(10)

				if exists (select 1 from tclient where CLNTCODE = @cClntCode)
				begin
				    /*
					--if exists (select 1 from tclient where GENCERTIND = 'E')
					SELECT @MAXNUM = MAX(CERTNO) + 10000000001 from tmember where clntcode = @cClntCode AND CERTNO NOT LIKE '%[A-Z]%' AND RCDSTS = 'A'
					update tclient set  GENCERTNUM  = right(@MAXNUM,10) where clntcode = @cClntCode
					SELECT right(cast(@MAXNUM  as varchar(11)),10) as CERTNO,'' as NAMELAST, '' as EMPDT, '' as OCCUPATION, '' as DEPCODE
					*/
					DECLARE @i decimal(11,0)
					SET @i = 1
				    
	
					WHILE (@i < 9999999999)
					BEGIN
							SELECT @i = @i + 1


							BEGIN TRAN
								SELECT @MAXNUM = GENCERTNUM FROM TCLIENT WHERE CLNTCODE = @cClntCode

								IF @MAXNUM IS NULL 
								BEGIN
									COMMIT TRAN
									BREAK 
								END

								UPDATE TCLIENT SET GENCERTNUM = @MAXNUM + 1 WHERE CLNTCODE = @cClntCode
	                        COMMIT TRAN

			
							SET @MAXCERT  = right(cast((@MAXNUM+10000000001) as varchar(11)),10) 
							IF EXISTS (SELECT 1 FROM TMEMBER WHERE CLNTCODE = @cClntCode AND CERTNO = @MAXCERT)
								BEGIN
									CONTINUE
								END
							ELSE
								BEGIN
									SELECT @MAXCERT as CERTNO,'' as NAMELAST, '' as EMPDT, '' as OCCUPATION, '' as DEPCODE
									BREAK
								END
					END

				end
			end
		else
		    --- @cType = other
			begin
			     SELECT '' as CERTNO,'' as NAMELAST, '' as EMPDT, '' as OCCUPATION, '' as DEPCODE
			end 

	end
END

