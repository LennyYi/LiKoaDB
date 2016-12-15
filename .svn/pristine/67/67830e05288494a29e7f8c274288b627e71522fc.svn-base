IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.NovaUspConvertXML') AND sysstat & 0xf = 4)
	drop procedure dbo.NovaUspConvertXML
GO

CREATE PROCEDURE dbo.NovaUspConvertXML
(	@cTRANDATE		CHAR(10), 
	@form_Id		VARCHAR(10),
	@request_no		VARCHAR(30),
	@staff_code		VARCHAR(10),
	@cRETURNCODE	CHAR(4) OUTPUT,
	@cRETMESSAGE    VARCHAR(MAX) OUTPUT
) AS
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	NovaUspConvertXML.SQL - Prepare xml for transfer data
        
        PROCESSING DETAILS:
        Prepare XML file for 
			
	AUTHOR      :     Sting Wu
	DATE	    :     11/12/2014
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        5.0	  NOVA		Sting Wu				11/12/2014	Initial Version
********************************************************************/
/*error handling variable section */
BEGIN

begin try

declare @toTable nvarchar(20),@toField nvarchar(20),@lastTable nvarchar(20),@key_field nvarchar(20),
	@exeValue nvarchar(MAX),@exeValue2 nvarchar(MAX),@xml nvarchar(max),@outparam nvarchar(100),
	@rowNo int,@xml2 nvarchar(max)
declare @sql nvarchar(max)
DECLARE @CompassDB VARCHAR(20)

delete from TNovaFieldMapping_temp where request_no = @request_no;


set @lastTable = ''
set @xml = '<form form_system_id='''+CAST(@form_Id AS VARCHAR)+''' request_no='''+@request_no+'''>'
set @xml2 = ''
set @sql = ''


declare cur_insertTMP cursor for 

select N'insert into TNovaFieldMapping_temp
		 select distinct '''+ to_table +N''' AS to_table,
				'''+ to_field +N''' AS to_field,
				'''+ isnull(key_field,N'') +N''' AS key_field,' +
		(CASE WHEN isnull(Mul_field,'') <> '' THEN isnull(Mul_field,N'')
			ELSE N'0' END) + ' AS id,' +
		(CASE WHEN isnull(from_table,'') = '' THEN N'value = '''+ from_field+ N'''' 
			WHEN isnull(datetype,N'') = N'datetime' THEN N'value = convert(varchar,'+ from_field + N',121) '
			ELSE N'value = '+ from_field 
		END) + ',' + cast([order] as varchar) + ' AS [order], '''+ @request_no + N''' [request_no]' +
		(CASE WHEN isnull(from_table,'') = '' THEN N'' 
			ELSE N' from ' + from_table 
			+ (CASE WHEN mul_field like '%[.]%' THEN (N' cross join (select DISTINCT ' + Mul_field + N' from ' 
					+ SUBSTRING(Mul_field, 0, PATINDEX('%[.]%',Mul_field))+ N' where request_no = '''+@request_no+N''') '
					+ SUBSTRING(Mul_field, 0, PATINDEX('%[.]%',Mul_field))) ELSE '' END )
			+ N' where request_no = '''+@request_no+N'''' END)
		from TNovaFieldMapping where form_system_id = @form_Id order by [order]
			
open cur_insertTMP	

FETCH NEXT FROM cur_insertTMP INTO @exeValue2
WHILE (@@FETCH_STATUS = 0)
BEGIN

	exec sp_executesql @exeValue2


FETCH NEXT FROM cur_insertTMP INTO @exeValue2;
END

CLOSE cur_insertTMP 
DEALLOCATE cur_insertTMP  


declare cur_convertXML cursor for 

select isnull(to_table,'') as to_table,
	isnull(to_field,'') as to_field,
	isnull(key_field,'') as key_field,
	isnull(dbo.funXMLReplaceSpecN(value),'') as value,
	RANK() over(partition by to_table,id order by to_table,id,to_field) as ROWNO 
from TNovaFieldMapping_temp where request_no = @request_no
order by [order],to_table,id,to_field

open cur_convertXML	

FETCH NEXT FROM cur_convertXML INTO @toTable,@toField,@key_field,@exeValue,@rowNo
WHILE (@@FETCH_STATUS = 0)
BEGIN

	if(@toTable = @lastTable)
	begin
		if(@rowNo = 1 and @xml2 <>'')
			set @xml2 =@xml2 + '</item>' 
		
		if(@rowNo = 1)
			set @xml2 =@xml2 + '<item>' 
		
		if(@key_field<>'')
			set @xml2 =@xml2 + '<' + @toField  + ' key='''+@key_field+'''>' + @exeValue + '</' + @toField + '>' 
		else
			set @xml2 =@xml2 + '<' + @toField  + '>' + @exeValue + '</' + @toField + '>' 
			
	end
	else
	begin
		if(@rowNo = 1 and @xml2 <>'')
			set @xml2 =@xml2 + '</item>' 
			
		if(@lastTable = '')
			set @xml2 =@xml2 + '<' + @toTable + '>'
		else
			set @xml2 =@xml2 + '</' + @lastTable + '>' + '<' + @toTable + '>'

		if(@rowNo = 1)
			set @xml2 =@xml2 + '<item>' 
		
		if(@key_field<>'')
			set @xml2 =@xml2 + '<' + @toField  + ' key='''+@key_field+'''>' + @exeValue + '</' + @toField + '>' 
		else
			set @xml2 =@xml2 + '<' + @toField  + '>' + @exeValue + '</' + @toField + '>' 
			
	end
	
	set @lastTable = @toTable
	
	FETCH NEXT FROM cur_convertXML INTO @toTable,@toField,@key_field,@exeValue,@rowNo;
END

CLOSE cur_convertXML 
DEALLOCATE cur_convertXML  

set @xml =@xml + @xml2 +'</item></' + @lastTable + '></form>'

delete from TNovaTXMLConvert where request_no= @request_no
insert into TNovaTXMLConvert
select convert(xml,@xml) as NovaXML,@request_no as request_no 

select @CompassDB = param_value from teflow_param_config where param_code= 'CompassDB'

select @sql = 'delete from '+@CompassDB+'..T_Nova_TXMLConvert where request_no = '''+@request_no+''';
insert into '+@CompassDB+'..T_Nova_TXMLConvert
select NovaXML,request_no from TNovaTXMLConvert where request_no = '''+@request_no+'''';

exec sp_executesql @sql

end try
begin catch
	
	DECLARE @ErrorMessage NVARCHAR(4000);  
	DECLARE @ErrorSeverity INT;  
	DECLARE @ErrorState INT;  
	
	SELECT @cRETURNCODE = '9999'

	if exists( select * from master.dbo.syscursors where cursor_name='cur_insertTMP')
	BEGIN	
		CLOSE cur_insertTMP 
		DEALLOCATE cur_insertTMP  
	END

	if exists( select * from master.dbo.syscursors where cursor_name='cur_convertXML')
	BEGIN
		CLOSE cur_convertXML 
		DEALLOCATE cur_convertXML  
	END

	SELECT @ErrorMessage = ERROR_MESSAGE(),  
	@ErrorSeverity = ERROR_SEVERITY(),  
	@ErrorState = ERROR_STATE(); 
	
	INSERT INTO TNovaErrlogTran
	--select @request_no,'NovaUspConvertXML',@ErrorMessage,@staff_code,GETDATE()
    select @request_no,'NovaUspConvertXML',CONCAT(@ErrorMessage,char(13), '******* value2', char(13) , @exeValue2 ,char(13), '******* value1', char(13), @exeValue),@staff_code,GETDATE()

	GOTO EXIT_WINDOW

end catch

EXIT_WINDOW:

END