if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[peof_create_PMASR]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [dbo].[peof_create_PMASR]
GO

create proc dbo.peof_create_PMASR
(@request_no varchar(50),
@staff_code char(5)
)
as

begin
   declare 
	@prj_code char (7),
	@chg_ctl_no char (2),
	@prj_type char (2),
	@Region_code varchar(10),
	@company char (2),
	@appl char (20),
	@rqt char (25),
	@rqt_email char (50),
	@pln_date char(10),
	@prj_desc char (125),
	@prj_dedail varchar(1000),
	@prj_dictor char (25),
	@prj_dictor_email char (50),
	@prj_ld_id char (7),
	@priority char (1),
	@charge_type char (2),
	@desired_cmpl_date char(10),
	@est_strt_date char(10),
	@est_cmpl_date char(10),
	@need_pacii char(2),
	@charge_rate_type_id int,
	@upload_to_pacii char(1),
	@generate_pacii_data char(1),
	@lc_type_code char(2),
	@cc1 char(4),
	@perc1 tinyint,
	@cc2 char(4),
	@perc2 tinyint,
	@cc3 char(4),
	@perc3 tinyint,
	@cc4 char(4),
	@perc4 tinyint,
	@cc5 char(4),
	@perc5 tinyint,
	@cc6 char(4),
	@perc6 tinyint,
	@bill_approach char(1)
	
   declare 
	@prj_ld_id_card_no char(18),@status char(2),@ks_approved char(2),@ks_used char(1),
	@atl_start datetime, @atl_finish datetime,@atl_hour decimal(7,1),@atl_cost decimal(11,2),
	@est_sys_hour decimal(7,1),
	@est_sys_cost decimal(9,2),
	@est_prg_hour decimal(7,1),
	@est_prg_cost decimal(9,2),
	@est_tot_hour decimal(7,1),
	@est_tot_cost decimal(9,2),
	@machine_time decimal(7,1),
	@infr_fee decimal(9,2),
	@prj_tot_est_hour decimal(7,1),
	@prj_tot_est_cost decimal(9,2)

   select @charge_rate_type_id=2,
    	@upload_to_pacii='Y',
    	@generate_pacii_data='Y',
    	@lc_type_code='',
    	@prj_type='',
        @bill_approach='P'

   if @chg_ctl_no='00'
	select @status='00'
   else
   begin
	select @status='01'
	select @atl_start=atl_start,@atl_finish=atl_finish,@atl_hour=atl_hour,@atl_cost=atl_cost, 
		@est_sys_hour=est_sys_hour,
		@est_sys_cost=est_sys_cost,
		@est_prg_hour=est_prg_hour,
		@est_prg_cost=est_prg_cost,
		@est_tot_hour=est_tot_hour,
		@est_tot_cost=est_tot_cost,
		@machine_time=machine_time,
		@infr_fee=infr_fee,
		@prj_tot_est_hour=prj_tot_est_hour,
		@prj_tot_est_cost=prj_tot_est_cost
	from db_pma.dbo.tpma_project 
	where prj_code=@prj_code and chg_ctl_no=right(rtrim(('00'+convert(varchar(2),(convert(int,@chg_ctl_no)-1)))),2)
   end

   select @rqt=staff_name, @rqt_email=email from tpma_staffbasic where staff_code=@staff_code

   select @prj_code=field_02_8,
    	@chg_ctl_no=field_02_10,
    	@Region_code=region,
    	@company=srcompany_id,
    	@appl=field_02_1,
    	@pln_date=convert(char(10),field_02_14,101),
    	@prj_desc=field_02_5,
    	@prj_dedail=field_02_29,
    	@prj_dictor=field_02_18,
    	@prj_dictor_email='',
    	@priority=priority,
    	@charge_type=charge_type
   from teflow_108_02 where request_no=@request_no

   select	
    	@est_tot_hour=field_07_1,
    	@est_tot_cost=field_07_2,
    	@machine_time=0,
    	@infr_fee=0,
    	@prj_tot_est_hour=field_07_1,
    	@prj_tot_est_cost=field_07_2
   from teflow_108_07 where request_no=@request_no

   select @est_sys_hour=sum(field_05_4), @est_sys_cost=sum(field_05_5)
   from teflow_108_05 where request_no=@request_no and field_05_6 in ('02','03')

   select @est_prg_hour=sum(field_05_4),@est_prg_cost=sum(field_05_5)
   from teflow_108_05 where request_no=@request_no and field_05_6 in ('01')

   select @prj_ld_id=b.logon_id,
    	@prj_ld_id_card_no=b.id_card
   from teflow_108_06 a,tpma_staffbasic b
   where a.request_no=@request_no and a.field_06_2=rtrim(b.pacii_id)

   if @prj_ld_id is null
	   select @prj_ld_id='ASNPXX1', @prj_ld_id_card_no='00015'

   select @desired_cmpl_date=convert(char(10),field_06_4,101),
    	@est_strt_date=convert(char(10),field_06_3,101),
    	@est_cmpl_date=convert(char(10),field_06_4,101)
   from teflow_108_06 
   where request_no=@request_no 

/*
	select * from teflow_108_02 
	select * from teflow_108_03
	select * from teflow_108_04
	select * from teflow_108_05
	select * from teflow_108_06
	select * from teflow_108_07
	select * from db_pma.dbo.tpma_project where prj_code='1234567'
	select * from db_pma.dbo.tpma_prj_costctr where prj_code='1234567'
	select * from db_pma.dbo.tpma_prj_code where prj_code='1234567'

	delete from db_pma.dbo.tpma_project where prj_code='1234567'
	delete from db_pma.dbo.tpma_prj_costctr where prj_code='1234567'
	delete from db_pma.dbo.tpma_prj_code where prj_code='1234567'

exec peof_create_PMASR 'IT_SR_08062009_03 ','C0097'
*/


 if not exists(select 1 from db_pma.dbo.tpma_project where prj_code=@prj_code and chg_ctl_no=@chg_ctl_no)
   insert db_pma.dbo.tpma_project(
    	prj_code ,
    	chg_ctl_no ,
    	prj_type ,
    	Region_code ,
    	company_no ,
    	appl ,
    	rqt ,
    	rqt_email ,
    	pln_date ,
    	prj_desc ,
    	desc_detail,
    	prj_dictor ,
    	prj_dictor_email ,
    	prj_ld_id ,
    	prj_ld_id_card_no ,
    	priority ,
    	charge_type ,
    	desired_cmpl_date,
	est_strt_date,
	est_cmpl_date,
    	est_sys_hour,
    	est_sys_cost,
    	est_prg_hour,
    	est_prg_cost,
    	est_tot_hour,
    	est_tot_cost,
    	machine_time,
    	infr_fee,
    	prj_tot_est_hour,
    	prj_tot_est_cost,
    	atl_start,
    	atl_finish,
    	atl_hour,
    	atl_cost,
    	status,
    	charge_rate_type_id,
    	upload_to_pacii,
    	generate_pacii_data,
    	lc_type_code,
        bill_approach
    	)
    values (@prj_code,
    	@chg_ctl_no,
    	@prj_type,
    	@Region_code,
    	@company,
    	@appl,
    	@rqt,
    	@rqt_email,
    	@pln_date,
    	@prj_desc,
    	@prj_dedail,
    	@prj_dictor,
    	@prj_dictor_email,
    	@prj_ld_id,
    	@prj_ld_id_card_no,
    	@priority,
    	@charge_type,
    	@desired_cmpl_date,
	@est_strt_date,
	@est_cmpl_date,
    	@est_sys_hour,
    	@est_sys_cost,
    	@est_prg_hour,
    	@est_prg_cost,
    	@est_tot_hour,
    	@est_tot_cost,
    	@machine_time,
    	@infr_fee,
    	@prj_tot_est_hour,
    	@prj_tot_est_cost,
    	@atl_start,
    	@atl_finish,
    	@atl_hour,
    	@atl_cost,
    	@status,
    	@charge_rate_type_id,
    	@upload_to_pacii,
    	@generate_pacii_data,
    	@lc_type_code,
        @bill_approach
    	)

		
	declare sr_cc CURSOR
	for 
	Select cost_center as cc,field_04_3 as perc from teflow_108_04 where request_no=@request_no order by field_04_3 desc
	
	open sr_cc
	fetch sr_cc into @cc1,@perc1
	
	while(@@FETCH_STATUS=0)
	begin
	    if @perc1>0 and not exists (select 1 from db_pma.dbo.tpma_prj_costctr where prj_code=@prj_code and chg_ctl_no=@chg_ctl_no and cst_ctr_code=@cc1)
    		insert db_pma.dbo.tpma_prj_costctr(prj_code,chg_ctl_no,cst_ctr_code,chrg_percent) values(@prj_code,@chg_ctl_no,@cc1,@perc1)
    	    fetch sr_cc into @cc1,@perc1
	end
	
	close sr_cc
	deallocate sr_cc

end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

