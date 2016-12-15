/****** Object:  UserDefinedFunction [NOVA].[funReplaceSpecN]    Script Date: 2/6/2015 1:35:15 PM ******/
if object_id(N'[NOVA].[funReplaceSpecN]') is not null
begin
	drop function [NOVA].[funReplaceSpecN]
end
go
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*********************** REVISION LOG: ***********************************
Version			Date			Revised by				Remark
1.0				20150301								initial
**************************************************************************/

CREATE FUNCTION [NOVA].[funReplaceSpecN](@input nvarchar(4000),@withSpace bit)
	RETURNS [nvarchar](4000) 
AS 
BEGIN 
	DECLARE @cResult nvarchar(4000)
	
	--C25762 BEGIN
	DECLARE @i  INTEGER
	DECLARE @iLen INTEGER
	DECLARE @StrR NCHAR(80)

	SET @i=0
	SET @iLen = LEN(@input)
	
	SET @StrR = @input

	WHILE (@i < @iLen)
	BEGIN
		IF SUBSTRING(@input,len(@input)-@i,1) = CHAR(32) OR SUBSTRING(@input,len(@input)-@i,1)  = NCHAR(32) 
		OR SUBSTRING(@input,len(@input)-@i,1) = CHAR(9)  OR SUBSTRING(@input,len(@input)-@i,1)  = NCHAR(9)
		OR SUBSTRING(@input,len(@input)-@i,1) = CHAR(13)  OR SUBSTRING(@input,len(@input)-@i,1) = NCHAR(13)
		OR SUBSTRING(@input,len(@input)-@i,1) = CHAR(32)  OR SUBSTRING(@input,len(@input)-@i,1) = NCHAR(32)
		BEGIN 
			SET @i = @i + 1
			SET @StrR = SUBSTRING(@input,0,len(@input)-@i+1) 
		END
		ELSE
		BEGIN
			SET @StrR=@StrR
			BREAK
		END
	END
	
	SET @StrR = RTRIM(@StrR)
	--C25762 END
	
	if @withSpace >0 
		set @cResult= REPLACE(REPLACE(REPLACE(REPLACE(@StrR,CHAR(9),''),CHAR(13),''),CHAR(10),''),CHAR(32),'')
	else
	BEGIN
		set @cResult= REPLACE(REPLACE(REPLACE(@StrR,CHAR(9),''),CHAR(13),''),CHAR(10),'')
	END
		
	return RTRIM(@cResult)
END



GO


