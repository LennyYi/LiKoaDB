IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.NovaUspJQFSHConvert') AND sysstat & 0xf = 4)
	drop procedure dbo.NovaUspJQFSHConvert
GO


/****** Object:  StoredProcedure [dbo].[NovaUspJQFSHConvert]    Script Date: 5/18/2015 10:12:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[NovaUspJQFSHConvert]
(	@cTRANDATE		    CHAR(10), 
	@form_system_id		VARCHAR(10),
	@request_no		    VARCHAR(30),
	@staff_code		    VARCHAR(10),
	@cRETCODE	        CHAR(4)      OUTPUT,
	@cRETMESSAGE      VARCHAR(MAX) OUTPUT
) AS
/*******************************************************************
	COMPASS 2000 USER STORED PROCEDURE

	NovaUspFLAKConvert.SQL - Prepare xml for transfer data
        
        PROCESSING DETAILS:
        Prepare XML file for 
			
	AUTHOR    :     Colin Wang
	DATE	    :     05/07/2015
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        1.0	  NOVA		Colin Wang				05/07/2015	Initial Version
********************************************************************/
/*error handling variable section */
BEGIN

begin try
	DELETE FROM teflow_product     WHERE request_no=@request_no 
	DELETE FROM teflow_productplan WHERE request_no=@request_no 

	DECLARE @cProdcode CHAR(5) 
	DECLARE	@cPlancode CHAR(3)
	DECLARE @i INT


	insert teflow_product (PKGPRDCD, PRODCODE,ID, REQUEST_NO)
	select DISTINCT 'JQFSH',PRODUCT_CODE,0,request_no
	from teflow_30322_12 
	where request_no=@request_no 
	AND (
		isnull(RTRIM(field_12_1),'')+
		isnull(RTRIM(field_12_2),'')+
		isnull(RTRIM(field_12_3),'')+
		isnull(RTRIM(field_12_4),'')+
		isnull(RTRIM(field_12_5),'')
		) != ''
	--AND (NULLIF(RTRIM(field_12_1),'')+NULLIF(RTRIM(field_12_2),'')+NULLIF(RTRIM(field_12_3),'')+NULLIF(RTRIM(field_12_4),'')+NULLIF(RTRIM(field_12_5),'')) IS NOT NULL


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

	--field_4_14:ְ ҵ �� �� 
	--field_4_15:�� �� ӵ �� �� �� ҽ �� 
	--field_4_2: ְ ҵ �� �� 
	--field_4_3: �� �� �� �� �� 
	
	--build working table with row_number function to identify plan relation with section 12
	select row_number() OVER (ORDER BY id ASC) AS row_id, *  into #teflow_30322_4 from  teflow_30322_4 t1
	where T1.request_no=@request_no 


    --PLAN 01
	INSERT teflow_productplan ( PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no, SHIP)
	select DISTINCT T2.Product_id,field_4_14, '001', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = 1
	AND   T1.product_code = '201C1' AND field_12_1 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '001', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = 1
	AND   T1.product_code = '211D1' AND field_12_1 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '001', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = 1
	AND   T1.product_code = '211S5' AND field_12_1 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '001', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = 1
	AND   T1.product_code = '211D2' AND field_12_1 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '001', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = 1
	AND   T1.product_code = '311S3' AND field_12_1 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '001', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = 1
	AND   T1.product_code = '214S1' AND field_12_1 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '001', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = 1
	AND   T1.product_code = '301C2' AND field_12_1 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '001', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = 1
	AND   T1.product_code = '301S1' AND field_12_1 is not null


  --PLAN 02
	INSERT teflow_productplan ( PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no, SHIP)
	select DISTINCT T2.Product_id,field_4_14, '002', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '2'
	AND   T1.product_code = '201C1' AND field_12_2 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '002', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '2'
	AND   T1.product_code = '211D1' AND field_12_2 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '002', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '2'
	AND   T1.product_code = '211S5' AND field_12_2 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '002', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '2'
	AND   T1.product_code = '211D2' AND field_12_2 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '002', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '2'
	AND   T1.product_code = '311S3' AND field_12_2 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '002', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '2'
	AND   T1.product_code = '214S1' AND field_12_2 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '002', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '2'
	AND   T1.product_code = '301C2' AND field_12_2 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '002', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '2'
	AND   T1.product_code = '301S1' AND field_12_2 is not null


  --PLAN 03
	INSERT teflow_productplan ( PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no, SHIP)
	select DISTINCT T2.Product_id,field_4_14, '003', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '3'
	AND   T1.product_code = '201C1' AND field_12_3 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '003', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '3'
	AND   T1.product_code = '211D1' AND field_12_3 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '003', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '3'
	AND   T1.product_code = '211S5' AND field_12_3 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '003', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '3'
	AND   T1.product_code = '211D2' AND field_12_3 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '003', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '3'
	AND   T1.product_code = '311S3' AND field_12_3 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '003', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '3'
	AND   T1.product_code = '214S1' AND field_12_3 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '003', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '3'
	AND   T1.product_code = '301C2' AND field_12_3 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '003', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '3'
	AND   T1.product_code = '301S1' AND field_12_3 is not null


  --PLAN 04
	INSERT teflow_productplan ( PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no, SHIP)
	select DISTINCT T2.Product_id,field_4_14, '004', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '4'
	AND   T1.product_code = '201C1' AND field_12_4 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '004', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '4'
	AND   T1.product_code = '211D1' AND field_12_4 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '004', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '4'
	AND   T1.product_code = '211S5' AND field_12_4 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '004', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '4'
	AND   T1.product_code = '211D2' AND field_12_4 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '004', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '4'
	AND   T1.product_code = '311S3' AND field_12_4 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '004', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '4'
	AND   T1.product_code = '214S1' AND field_12_4 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '004', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '4'
	AND   T1.product_code = '301C2' AND field_12_4 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '004', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '4'
	AND   T1.product_code = '301S1' AND field_12_4 is not null


  --PLAN 04
	INSERT teflow_productplan ( PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no, SHIP)
	select DISTINCT T2.Product_id,field_4_14, '005', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '5'
	AND   T1.product_code = '201C1' AND field_12_5 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '005', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '5'
	AND   T1.product_code = '211D1' AND field_12_5 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '005', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '5'
	AND   T1.product_code = '211S5' AND field_12_5 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '005', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '5'
	AND   T1.product_code = '211D2' AND field_12_5 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '005', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '5'
	AND   T1.product_code = '311S3' AND field_12_5 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '005', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '5'
	AND   T1.product_code = '214S1' AND field_12_5 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '005', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '5'
	AND   T1.product_code = '301C2' AND field_12_5 is not null
	union all
	select DISTINCT T2.Product_id,field_4_14, '005', T1.PRODUCT_CODE, ISNULL(field_4_2,''), ISNULL(field_4_3,'0'), 0, T1.request_no, T2.field_4_15
	from teflow_30322_12 T1, #teflow_30322_4 T2 
	where T1.request_no=@request_no 
	AND   T2.request_no=T2.request_no
	AND   T2.row_id = '5'
	AND   T1.product_code = '301S1' AND field_12_5 is not null


	--------------------------
	--update benamtmb begin --
	--------------------------
	UPDATE	T1 
	SET		BENAMTMB = field_12_1
	FROM	teflow_productplan T1,
			teflow_30322_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '001'
	AND		LIMIT_CODE	= 'SA'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no

	UPDATE	T1 
	SET		BENAMTMB = field_12_1
	FROM	teflow_productplan T1,
			teflow_30322_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '001'
	AND		LIMIT_CODE	= 'OHS'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no



	UPDATE	T1 
	SET		BENAMTMB = field_12_2
	FROM	teflow_productplan T1,
			teflow_30322_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '002'
	AND		LIMIT_CODE	= 'SA'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no

	UPDATE	T1 
	SET		BENAMTMB = field_12_2
	FROM	teflow_productplan T1,
			teflow_30322_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '002'
	AND		LIMIT_CODE	= 'OHS'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no


	UPDATE	T1 
	SET		BENAMTMB = field_12_3
	FROM	teflow_productplan T1,
			teflow_30322_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '003'
	AND		LIMIT_CODE	= 'SA'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no

	UPDATE	T1 
	SET		BENAMTMB = field_12_3
	FROM	teflow_productplan T1,
			teflow_30322_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '003'
	AND		LIMIT_CODE	= 'OHS'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no



	UPDATE	T1 
	SET		BENAMTMB = field_12_4
	FROM	teflow_productplan T1,
			teflow_30322_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '004'
	AND		LIMIT_CODE	= 'SA'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no


	UPDATE	T1 
	SET		BENAMTMB = field_12_4
	FROM	teflow_productplan T1,
			teflow_30322_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '004'
	AND		LIMIT_CODE	= 'OHS'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no



	UPDATE	T1 
	SET		BENAMTMB = field_12_5
	FROM	teflow_productplan T1,
			teflow_30322_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '005'
	AND		LIMIT_CODE	= 'SA'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no

	UPDATE	T1 
	SET		BENAMTMB = field_12_5
	FROM	teflow_productplan T1,
			teflow_30322_12	T2
	WHERE	T1.PRODCODE = T2.PRODUCT_CODE
	AND		T1.PLANCODE	= '005'
	AND		LIMIT_CODE	= 'OHS'
	AND		T1.request_no= @request_no
	AND		T2.request_no= @request_no

	--------------------------
	--update prmratecd begin--
	--------------------------

    --update prmratecd in prouctplan for ratetype for occppuation class
	update t2 set prmratecd = t1.ratecode 
	FROM TNovaProdRateCd T1, teflow_productplan T2 
	WHERE T2.request_no= @request_no
	and   T1.PRODCODE = T2.PRODCODE
	AND   T1.OCCCLASSS <= T2.OCCUPCLASS
	AND   T1.OCCCLASSE >= T2.OCCUPCLASS
	AND   T1.BeneAmt    = T2.BENAMTMB
	AND   T1.RATETYPE   = 'O'
	AND	  T1.FORM_SYSTEM_ID = @form_system_id


    --update prmratecd in prouctplan for ratetype for occppuation class and ship &
	update t2 set prmratecd = t1.ratecode 
	FROM TNovaProdRateCd T1, teflow_productplan T2
	WHERE T2.request_no= @request_no
	and   T1.PRODCODE = T2.PRODCODE
	AND   T1.OCCCLASSS <= T2.OCCUPCLASS
	AND   T1.OCCCLASSE >= T2.OCCUPCLASS
	AND   T1.BeneAmt    = T2.BENAMTMB
	AND   T1.SHIP       = T2.SHIP
	AND   T1.RATETYPE   = 'S'
	AND	  T1.FORM_SYSTEM_ID = @form_system_id


    drop table #teflow_30322_4
	
	--------------------------
	--update ID begin--
	--------------------------

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
	select @request_no,'NovaUspJQFSHConvert',@ErrorMessage,@staff_code,GETDATE()

	GOTO EXIT_WINDOW

end catch

EXIT_WINDOW:

END