if object_id(N'[dbo].[funXMLReplaceSpecN]') is not null
begin
	drop function [dbo].[funXMLReplaceSpecN]
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*********************** REVISION LOG: ***********************************
Version			Date			Revised by				Remark
1.0				20150511		Sting Wu				initial
**************************************************************************/

CREATE FUNCTION [dbo].[funXMLReplaceSpecN](@input nvarchar(4000))
	RETURNS [nvarchar](4000) 
AS 
BEGIN 
	DECLARE @cResult nvarchar(4000)
	
	set @cResult = REPLACE(@input,CHAR(38),'+CHAR(38)+');--'&amp;');
	set @cResult = REPLACE(@cResult,CHAR(60),'+CHAR(60)+');--,'&lt;');
	set @cResult = REPLACE(@cResult,CHAR(62),'+CHAR(62)+');--,'&gt;');
	set @cResult = REPLACE(@cResult,CHAR(39),'+CHAR(39)+');--,'&apos;');
	set @cResult = REPLACE(@cResult,CHAR(34),'+CHAR(34)+');--,'&quot;');
	
	return RTRIM(@cResult)
END

GO


