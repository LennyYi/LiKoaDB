if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[poeSR_create_PMASR]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [dbo].[poeSR_create_PMASR]
GO

--exec poeSR_create_PMASR 'IT_SR_09292009_05','C0097'
--exec poeSR_create_PMASR_31 'IT_SR_09252009_01','C0097'
--select * from tpma_project where prj_code='4292057'
--delete from tpma_project where prj_code='4292057'
--select * from db_pma..tpma_project where prj_code='4292057'
--exec poeSR_create_PMASR_detail 'IT_SR_09292009_05','C0097','db_pma'

create proc dbo.poeSR_create_PMASR
(@request_no varchar(50),
@staff_code char(5)
)
as

declare @company_id varchar(10),@sp_name varchar(180),@serverlink varchar(100)
--declare @request_no varchar(50),@staff_code char(5)
--select @request_no='IT_SR_09252009_01',@staff_code='C0097'
select @company_id=company_id from teflow_108_01 where request_no=@request_no
select @serverlink=serverlink from teflow_eSR_serverlink where org_id=@company_id

select @sp_name= 'poeSR_create_PMASR_detail'
--select @company_id as '@company_id'
--select @sp_name as '22'
if exists (select 1 from sysobjects where name=@sp_name)
begin
	select @sp_name = 'exec ' + @sp_name + ' ''' + @request_no + ''',''' + @staff_code + ''',''' + @serverlink + ''''  
	exec (@sp_name)
end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

