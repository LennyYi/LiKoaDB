IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.NovaUspBJXTAConvert') AND sysstat & 0xf = 4)
	drop procedure dbo.NovaUspBJXTAConvert
GO

/****** Object:  StoredProcedure [dbo].[NovaUspBJXTAConvert]    Script Date: 2015/5/7 16:24:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[NovaUspBJXTAConvert]
(	@cTRANDATE		CHAR(10), 
	@form_system_id		VARCHAR(10),
	@request_no		VARCHAR(30),
	@staff_code		VARCHAR(10),
	@cRETCODE	CHAR(4) OUTPUT,
	@cRETMESSAGE    VARCHAR(MAX) OUTPUT
) AS
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	NovaUspFLAKConvert.SQL - Prepare xml for transfer data
        
        PROCESSING DETAILS:
        Prepare XML file for 
			
	AUTHOR      :     Colin Wang
	DATE	    :     05/07/2015
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        1.0	  NOVA		Colin Wang				05/07/2015	Initial Version
********************************************************************/
/*error handling variable section */
BEGIN

begin try
	DELETE FROM teflow_product WHERE request_no=@request_no 
	DELETE FROM teflow_productplan WHERE request_no=@request_no 

	DECLARE @cProdcode CHAR(5) 
	DECLARE	@cPlancode CHAR(3)
	DECLARE @i INT


	insert teflow_product (PKGPRDCD, PRODCODE,ID, REQUEST_NO)
	select DISTINCT 'BJXTA',PRODUCT_CODE,0,request_no
	from teflow_30320_12 
	where request_no=@request_no 
	AND (NULLIF(RTRIM(field_12_1),'')+NULLIF(RTRIM(field_12_2),'')+NULLIF(RTRIM(field_12_3),'')+NULLIF(RTRIM(field_12_4),'')+NULLIF(RTRIM(field_12_5),'')) IS NOT NULL


	SELECT @i = 1

	declare cur_converProduct cursor for 

	select  PRODCODE
	from teflow_product where request_no = @request_no
	order by PRODCODE

	open cur_converProduct	

	FETCH NEXT FROM cur_converProduct INTO @cProdcode
	WHILE (@@FETCH_STATUS = 0)
	BEGIN


		UPDATE teflow_product SET id = @i where  request_no = @request_no and  PRODCODE =@cProdcode

		SELECT @i = @i+1

		FETCH NEXT FROM cur_converProduct INTO @cProdcode
	END

	CLOSE cur_converProduct 
	DEALLOCATE cur_converProduct  


	INSERT teflow_productplan ( PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no)
	select DISTINCT 'BJXTA',field_4_22,'001',T1.PRODUCT_CODE,ISNULL(field_4_2,''),ISNULL(field_4_3,'0'),0,T1.request_no from teflow_30320_12 T1, 
	teflow_30320_4 T2 where T1.request_no=@request_no 
	AND T2.request_no=@request_no 
	AND NULLIF(RTRIM(field_12_1),'') IS NOT NULL
	
	INSERT teflow_productplan ( PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no)
	select DISTINCT 'BJXTA',field_4_22,'002',T1.PRODUCT_CODE,ISNULL(field_4_2,''),ISNULL(field_4_3,'0'),0,T1.request_no from teflow_30320_12 T1, 
	teflow_30320_4 T2 where T1.request_no=@request_no 
	AND T2.request_no=@request_no 
	AND NULLIF(RTRIM(field_12_2),'') IS NOT NULL

	INSERT teflow_productplan ( PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no)
	select DISTINCT 'BJXTA',field_4_22,'003',T1.PRODUCT_CODE,ISNULL(field_4_2,''),ISNULL(field_4_3,'0'),0,T1.request_no from teflow_30320_12 T1, 
	teflow_30320_4 T2 where T1.request_no=@request_no 
	AND T2.request_no=@request_no 
	AND NULLIF(RTRIM(field_12_3),'') IS NOT NULL

	INSERT teflow_productplan ( PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no)
	select DISTINCT 'BJXTA',field_4_22,'004',T1.PRODUCT_CODE,ISNULL(field_4_2,''),ISNULL(field_4_3,'0'),0,T1.request_no from teflow_30320_12 T1, 
	teflow_30320_4 T2 where T1.request_no=@request_no 
	AND T2.request_no=@request_no 
	AND NULLIF(RTRIM(field_12_4),'') IS NOT NULL

	INSERT teflow_productplan ( PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no)
	select DISTINCT 'BJXTA',field_4_22,'005',T1.PRODUCT_CODE,ISNULL(field_4_2,''),ISNULL(field_4_3,'0'),0,T1.request_no from teflow_30320_12 T1, 
	teflow_30320_4 T2 where T1.request_no=@request_no 
	AND T2.request_no=@request_no 
	AND NULLIF(RTRIM(field_12_5),'') IS NOT NULL

	UPDATE	T1 
	SET		BENAMTMB = field_12_1
	FROM	teflow_productplan T1,
			teflow_30320_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '001'
	AND		LIMIT_CODE	= 'SA'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no


	UPDATE	T1 
	SET		PREMMODAL = field_12_1
	FROM	teflow_productplan T1,
			teflow_30320_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '001'
	AND		LIMIT_CODE	= 'RATE'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no

	UPDATE	T1 
	SET		BENAMTMB = field_12_2
	FROM	teflow_productplan T1,
			teflow_30320_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '002'
	AND		LIMIT_CODE	= 'SA'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no


	UPDATE	T1 
	SET		PREMMODAL = field_12_2
	FROM	teflow_productplan T1,
			teflow_30320_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '002'
	AND		LIMIT_CODE	= 'RATE'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no

	UPDATE	T1 
	SET		BENAMTMB = field_12_3
	FROM	teflow_productplan T1,
			teflow_30320_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '003'
	AND		LIMIT_CODE	= 'SA'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no


	UPDATE	T1 
	SET		PREMMODAL = field_12_3
	FROM	teflow_productplan T1,
			teflow_30320_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '003'
	AND		LIMIT_CODE	= 'RATE'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no
	

	UPDATE	T1 
	SET		BENAMTMB = field_12_4
	FROM	teflow_productplan T1,
			teflow_30320_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '004'
	AND		LIMIT_CODE	= 'SA'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no


	UPDATE	T1 
	SET		PREMMODAL = field_12_4
	FROM	teflow_productplan T1,
			teflow_30320_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '004'
	AND		LIMIT_CODE	= 'RATE'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no

	UPDATE	T1 
	SET		BENAMTMB = field_12_5
	FROM	teflow_productplan T1,
			teflow_30320_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '005'
	AND		LIMIT_CODE	= 'SA'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no


	UPDATE	T1 
	SET		PREMMODAL = field_12_5
	FROM	teflow_productplan T1,
			teflow_30320_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '005'
	AND		LIMIT_CODE	= 'RATE'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no

	SELECT @i = 1

	declare cur_converProductPlan cursor for 

	select  PRODCODE,PLANCODE
	from teflow_productplan where request_no = @request_no
	order by PLANCODE,PRODCODE

	open cur_converProductPlan	

	FETCH NEXT FROM cur_converProductPlan INTO @cProdcode, @cPlancode
	WHILE (@@FETCH_STATUS = 0)
	BEGIN


		UPDATE teflow_productplan SET id = @i where  request_no = @request_no and  PRODCODE =@cProdcode and PLANCODE=@cPlancode

		SELECT @i = @i+1

		FETCH NEXT FROM cur_converProductPlan INTO @cProdcode, @cPlancode
	END

	CLOSE cur_converProductPlan 
	DEALLOCATE cur_converProductPlan  


end try
begin catch
	if exists( select * from master.dbo.syscursors where cursor_name='cur_converProductPlan')
	BEGIN
		CLOSE cur_converProductPlan 
		DEALLOCATE cur_converProductPlan  
	END
	if exists( select * from master.dbo.syscursors where cursor_name='cur_converProduct')
	BEGIN
		CLOSE cur_converProduct 
		DEALLOCATE cur_converProduct  
	END
	
	DECLARE @ErrorMessage NVARCHAR(4000);  
	DECLARE @ErrorSeverity INT;  
	DECLARE @ErrorState INT;  
	
	SELECT @cRETCODE = '9999'

	SELECT @ErrorMessage = ERROR_MESSAGE(),  
	@ErrorSeverity = ERROR_SEVERITY(),  
	@ErrorState = ERROR_STATE(); 
	
	INSERT INTO TNovaErrlogTran
	select @request_no,'NovaUspBJXTAConvert',@ErrorMessage,@staff_code,GETDATE()

	GOTO EXIT_WINDOW

end catch

EXIT_WINDOW:

END