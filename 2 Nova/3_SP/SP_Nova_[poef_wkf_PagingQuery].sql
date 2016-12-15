if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[poef_wkf_PagingQuery]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [dbo].[poef_wkf_PagingQuery]
GO
/*********************** REVISION LOG: ***********************************
Version			Date			Revised by				Remark
1.0				20150304		Sting Wu				initial
**************************************************************************/
CREATE PROCEDURE [dbo].[poef_wkf_PagingQuery]
	@TableSqlString   nvarchar(Max),       -- 表Sql
	@WhereParam nvarchar(Max) = '', -- 查询条件 (注意: 不要加 where)
	@OrderString nvarchar(Max)='',      -- 排序
	@PageSize  int = 20,          -- 页尺寸
	@PageIndex int = 1          -- 页码
AS

DECLARE @strSQL   nvarchar(Max)       -- 主语句
--设置Where条件
IF @WhereParam !=''	SET @WhereParam = ' where '+ @WhereParam
	
--设置OrderBy
IF @OrderString !=''	SET @OrderString = ' Order By '+@OrderString	

--获取数据集
IF @PageIndex = 1
BEGIN 
	--如果是第一页就执行以上代码，这样会加快执行速度
	SET @strSQL =' select top ' + str(@PageSize) +' * from (' + @TableSqlString + ' ) A  ' + @WhereParam + ' ' + @OrderString
END
ELSE
BEGIN
	SET @strSQL='With OrderFreight AS (
					  select * ,row_number() over ('+@OrderString+') as Row from 
					  ('
						+@TableSqlString+
					  ') A '
	SET @strSQL=@strSQL+'  '+@WhereParam
	SET	@strSQL=@strSQL+'  )'
	SET @strSQL=@strSQL+'   select * from OrderFreight where Row between '+CAST((@PageSize*(@PageIndex-1)+1) AS varchar)+' and '+CAST((@PageSize*@PageIndex) AS varchar) 		  
END 
PRINT @strSQL
EXEC sp_executesql @strSQL
