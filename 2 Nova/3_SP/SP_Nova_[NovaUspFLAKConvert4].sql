IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.NovaUspFLAKConvert4') AND sysstat & 0xf = 4)
	drop procedure dbo.NovaUspFLAKConvert4
GO

/****** Object:  StoredProcedure [dbo].[NovaUspFLAKConvert4]    Script Date: 2015/5/4 16:24:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[NovaUspFLAKConvert4]
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
			
	AUTHOR      :     Justin Bin
	DATE	    :     04/29/2015
	PIRNO	    :	  

	REVISION LOG:
	VERSION	  PIRNO		PROGRAMMER	REMARK		DATE		PURPOSE
        5.0	  NOVA		Justin Bin				04/28/2015	Initial Version
        				Justin Bin				058/11/2015	add default value for columns(PREMMODAL,BENAMTMB)
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
	select distinct field_4_19,left(prodcode,5),0,request_no 
	from teflow_30319_4 unpivot (prodcode for prodField in (field_4_9, 
	field_4_10,field_4_11,field_4_12,field_4_13,field_4_14,field_4_15,field_4_16,field_4_17,field_4_20))b
	where request_no=@request_no AND prodcode<>''


	if(exists (select 1 from teflow_product where request_no=@request_no and PRODCODE='211DX')) 
	begin
		insert into teflow_product(PKGPRDCD,PRODCODE,ID,request_no) values('FLAK4','211D3','0',@request_no)
		insert into teflow_product(PKGPRDCD,PRODCODE,ID,request_no) values('FLAK4','211D4','0',@request_no)
		insert into teflow_product(PKGPRDCD,PRODCODE,ID,request_no) values('FLAK4','211D5','0',@request_no)
		insert into teflow_product(PKGPRDCD,PRODCODE,ID,request_no) values('FLAK4','211D6','0',@request_no)
		delete from teflow_product where request_no=@request_no and PRODCODE='211DX'
	end

	if(exists (select 1 from teflow_product where request_no=@request_no and PRODCODE='360SX'))
	begin
		insert into teflow_product(PKGPRDCD,PRODCODE,ID,request_no) values('FLAK4','360S1','0',@request_no)
		insert into teflow_product(PKGPRDCD,PRODCODE,ID,request_no) values('FLAK4','360S2','0',@request_no)
		insert into teflow_product(PKGPRDCD,PRODCODE,ID,request_no) values('FLAK4','301S2','0',@request_no)
		delete from teflow_product where request_no=@request_no and PRODCODE='360SX'
	end


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



	insert teflow_productplan(PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no,PREMMODAL,BENAMTMB ) 
	select field_4_19,isnull(field_4_8,'') as OCCUPCLASS,plan_id,left(prodcode,5),field_4_2,field_4_3,id,request_no,0,0 
	from teflow_30319_4 unpivot (prodcode for prodField in (field_4_9, 
	field_4_10,field_4_11,field_4_12,field_4_13,field_4_14,field_4_15,field_4_16,field_4_17,field_4_20))b
	where request_no=@request_no AND prodcode<>''

	select * from teflow_productplan 
	if(exists (select 1 from teflow_productplan where request_no=@request_no and PRODCODE='211DX')) 
	begin
		insert into teflow_productplan(PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no,PREMMODAL,BENAMTMB ) 
				select b.PKGPRDCD,b.OCCUPCLASS,b.PLANCODE,'211D3',b.PLANDESC,b.NUMMEM,b.ID,b.request_no,0,0 from teflow_productplan b where b.request_no=@request_no and b.PRODCODE='211DX'
		insert into teflow_productplan(PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no,PREMMODAL,BENAMTMB ) 
				select b.PKGPRDCD,b.OCCUPCLASS,b.PLANCODE,'211D4',b.PLANDESC,b.NUMMEM,b.ID,b.request_no,0,0 from teflow_productplan b where b.request_no=@request_no and b.PRODCODE='211DX'
		insert into teflow_productplan(PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no,PREMMODAL,BENAMTMB ) 
				select b.PKGPRDCD,b.OCCUPCLASS,b.PLANCODE,'211D5',b.PLANDESC,b.NUMMEM,b.ID,b.request_no,0,0 from teflow_productplan b where b.request_no=@request_no and b.PRODCODE='211DX'
		insert into teflow_productplan(PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no,PREMMODAL,BENAMTMB ) 
				select b.PKGPRDCD,b.OCCUPCLASS,b.PLANCODE,'211D6',b.PLANDESC,b.NUMMEM,b.ID,b.request_no,0,0 from teflow_productplan b where b.request_no=@request_no and b.PRODCODE='211DX'
		delete from teflow_productplan where request_no=@request_no and PRODCODE='211DX'
	end

	if(exists (select 1 from teflow_productplan where request_no=@request_no and PRODCODE='360SX'))
	begin
		insert into teflow_productplan(PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no,PREMMODAL,BENAMTMB ) 
				select b.PKGPRDCD,b.OCCUPCLASS,b.PLANCODE,'360S1',b.PLANDESC,b.NUMMEM,b.ID,b.request_no,0,0 from teflow_productplan b where b.request_no=@request_no and b.PRODCODE='360SX'
		insert into teflow_productplan(PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no,PREMMODAL,BENAMTMB ) 
				select b.PKGPRDCD,b.OCCUPCLASS,b.PLANCODE,'360S2',b.PLANDESC,b.NUMMEM,b.ID,b.request_no,0,0 from teflow_productplan b where b.request_no=@request_no and b.PRODCODE='360SX'
		insert into teflow_productplan(PKGPRDCD,OCCUPCLASS,PLANCODE,PRODCODE,PLANDESC,NUMMEM,ID,request_no,PREMMODAL,BENAMTMB ) 
				select b.PKGPRDCD,b.OCCUPCLASS,b.PLANCODE,'301S2',b.PLANDESC,b.NUMMEM,b.ID,b.request_no,0,0 from teflow_productplan b where b.request_no=@request_no and b.PRODCODE='360SX'
		delete from teflow_productplan where request_no=@request_no and PRODCODE='360SX'
	end

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
	
	DECLARE @ErrorMessage NVARCHAR(4000);  
	DECLARE @ErrorSeverity INT;  
	DECLARE @ErrorState INT;  
	
	SELECT @cRETCODE = '9999'

	SELECT @ErrorMessage = ERROR_MESSAGE(),  
	@ErrorSeverity = ERROR_SEVERITY(),  
	@ErrorState = ERROR_STATE(); 
	
	INSERT INTO TNovaErrlogTran
	select @request_no,'NovaUspFLAKConvert4',@ErrorMessage,@staff_code,GETDATE()

	GOTO EXIT_WINDOW

end catch

EXIT_WINDOW:

END