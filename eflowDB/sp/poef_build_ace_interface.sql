if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[poef_build_ace_interface]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[poef_build_ace_interface]
GO

CREATE PROCEDURE dbo.poef_build_ace_interface
 AS

if exists (select 1 from teflow_operate_log where operate_staff_code='System' and operate_description='Build interface with ACE' and convert(varchar(50),operate_date)=convert(varchar(50),getdate()))
	return
else   
	insert teflow_operate_log (operate_staff_code,operate_date,operate_type,operate_description) select 'System',getdate(),'04','Build interface with ACE'

create table #temp1
(
request_no	varchar(50) null,	
form_system_id int null,
request_staff_code varchar(10) null,	
ace_date	datetime null
)

select * into #temp2 from teflow_ace_interface where 1=2

insert #temp1 select a.request_no, b.form_system_id,a.request_staff_code, getdate() 
	from teflow_wkf_process a, teflow_wkf_define b
	where a.flow_id = b.flow_id
		and b.form_system_id between 87 and 95
		and a.status='04'
		and a.request_no not in (select request_no from teflow_ace_epayid_history)

---For General_Items 87	 begin
insert #temp2 (epay_id,dc_id) select b.request_no,b.id from #temp1 a, teflow_87_06 b where a.request_no=b.request_no 

update a 
set a.ANAL_T0=isnull(left(c.field_06_9,4),''), 
    a.ANAL_T2=isnull(left(c.field_06_3,3),''), 
    a.ANAL_T3=isnull(left(c.field_06_5,3),''), 
    a.ANAL_T4=isnull(left(c.field_06_4,2),''),
    a.ANAL_T1=isnull(left(c.field_06_13,15),''),
    a.ANAL_T5=isnull(left(c.field_06_14,15),''),
    a.DB_CODE=isnull(left(ltrim(c.field_06_12),3),''),
    a.TREFERENCE='AA14',
    a.CONV_CODE=isnull(left(c.field_06_6,3),''), 
    a.DESCRIPTION=isnull(left(c.field_06_7,20),''),
    a.D_C=isnull(left(c.field_06_1,1), ''),
    a.OTH_AMT=isnull(c.field_06_8, 0),
    a.ACCNT_CODE=isnull((select min(rtrim(code)) from teflow_payment_sunac_code where c.field_06_11+' ' like rtrim(code)+' %' group by code),'')
--    a.ACCNT_CODE=isnull(left(c.field_06_11,charindex(' ', c.field_06_11)),'')
from #temp2 a, #temp1 b, teflow_87_06 c
where a.epay_id=b.request_no
	and a.epay_id=c.request_no
	and a.dc_id=c.id
	and b.form_system_id=87

update a 
set a.TRANS_DATE=substring(convert(char(10),c.field_05_24,111),1,4)+substring(convert(char(10),c.field_05_24,111),6,2)+substring(convert(char(10),c.field_05_24,111),9,2),
    a.PERIOD=substring(convert(char(10),c.field_05_24,111),1,4)+'0'+substring(convert(char(10),c.field_05_24,111),6,2)
from #temp2 a, #temp1 b, teflow_87_05 c
where a.epay_id=b.request_no
	and a.epay_id=c.request_no
	and b.form_system_id=87
---For General_Items  end

---For Transportation 88 begin
insert #temp2 (epay_id,dc_id) select b.request_no,b.id from #temp1 a, teflow_88_06 b where a.request_no=b.request_no


update a 
set a.ANAL_T0=isnull(left(c.field_06_9,4),''), 
    a.ANAL_T2=isnull(left(c.field_06_3,3),''), 
    a.ANAL_T3=isnull(left(c.field_06_5,3),''), 
    a.ANAL_T4=isnull(left(c.field_06_4,2),''),
    a.ANAL_T1=isnull(left(c.field_06_13,15),''),
    a.ANAL_T5=isnull(left(c.field_06_14,15),''),
    a.DB_CODE=isnull(left(ltrim(c.field_06_12),3),''),
    a.TREFERENCE='AA12',
    a.CONV_CODE=isnull(left(c.field_06_6,3),''), 
    a.DESCRIPTION=isnull(left(c.field_06_7,20),''),
    a.D_C=isnull(left(c.field_06_1,1), ''),
    a.OTH_AMT=isnull(c.field_06_8, 0),
    a.ACCNT_CODE=isnull((select min(rtrim(code)) from teflow_payment_sunac_code where c.field_06_11+' ' like rtrim(code)+' %' group by code),'')
from #temp2 a, #temp1 b, teflow_88_06 c
where a.epay_id=b.request_no
	and a.epay_id=c.request_no
	and a.dc_id=c.id
	and b.form_system_id=88

update a 
set a.TRANS_DATE=substring(convert(char(10),c.field_05_24,111),1,4)+substring(convert(char(10),c.field_05_24,111),6,2)+substring(convert(char(10),c.field_05_24,111),9,2),
    a.PERIOD=substring(convert(char(10),c.field_05_24,111),1,4)+'0'+substring(convert(char(10),c.field_05_24,111),6,2)
from #temp2 a, #temp1 b, teflow_88_05 c
where a.epay_id=b.request_no
	and a.epay_id=c.request_no
	and b.form_system_id=88
---For Transportation end

---For Entertainment 89 begin
insert #temp2 (epay_id,dc_id) select b.request_no,b.id from #temp1 a, teflow_89_06 b where a.request_no=b.request_no

update a 
set a.ANAL_T0=isnull(left(c.field_06_9,4),''), 
    a.ANAL_T2=isnull(left(c.field_06_3,3),''), 
    a.ANAL_T3=isnull(left(c.field_06_5,3),''), 
    a.ANAL_T4=isnull(left(c.field_06_4,2),''),
    a.ANAL_T1=isnull(left(c.field_06_13,15),''),
    a.ANAL_T5=isnull(left(c.field_06_14,15),''),
    a.DB_CODE=isnull(left(ltrim(c.field_06_12),3),''),
    a.TREFERENCE='AA13',
    a.CONV_CODE=isnull(left(c.field_06_6,3),''), 
    a.DESCRIPTION=isnull(left(c.field_06_7,20),''),
    a.D_C=isnull(left(c.field_06_1,1), ''),
    a.OTH_AMT=isnull(c.field_06_8, 0),
    a.ACCNT_CODE=isnull((select min(rtrim(code)) from teflow_payment_sunac_code where c.field_06_11+' ' like rtrim(code)+' %' group by code),'')
from #temp2 a, #temp1 b, teflow_89_06 c
where a.epay_id=b.request_no
	and a.epay_id=c.request_no
	and a.dc_id=c.id
	and b.form_system_id=89

update a 
set a.TRANS_DATE=substring(convert(char(10),c.field_05_24,111),1,4)+substring(convert(char(10),c.field_05_24,111),6,2)+substring(convert(char(10),c.field_05_24,111),9,2),
    a.PERIOD=substring(convert(char(10),c.field_05_24,111),1,4)+'0'+substring(convert(char(10),c.field_05_24,111),6,2)
from #temp2 a, #temp1 b, teflow_89_05 c
where a.epay_id=b.request_no
	and a.epay_id=c.request_no
	and b.form_system_id=89
---For Entertainment end


---For Private_Car 90 begin
insert #temp2 (epay_id,dc_id) select b.request_no,b.id from #temp1 a, teflow_90_06 b where a.request_no=b.request_no

update a 
set a.ANAL_T0=isnull(left(c.field_06_9,4),''), 
    a.ANAL_T2=isnull(left(c.field_06_3,3),''), 
    a.ANAL_T3=isnull(left(c.field_06_5,3),''), 
    a.ANAL_T4=isnull(left(c.field_06_4,2),''),
    a.ANAL_T1=isnull(left(c.field_06_13,15),''),
    a.ANAL_T5=isnull(left(c.field_06_14,15),''),
    a.DB_CODE=isnull(left(ltrim(c.field_06_12),3),''),
    a.TREFERENCE='AA16',
    a.CONV_CODE=isnull(left(c.field_06_6,3),''), 
    a.DESCRIPTION=isnull(left(c.field_06_7,20),''),
    a.D_C=isnull(left(c.field_06_1,1), ''),
    a.OTH_AMT=isnull(c.field_06_8, 0),
    a.ACCNT_CODE=isnull((select min(rtrim(code)) from teflow_payment_sunac_code where c.field_06_11+' ' like rtrim(code)+' %' group by code),'')
from #temp2 a, #temp1 b, teflow_90_06 c
where a.epay_id=b.request_no
	and a.epay_id=c.request_no
	and a.dc_id=c.id
	and b.form_system_id=90

update a 
set a.TRANS_DATE=substring(convert(char(10),c.field_05_24,111),1,4)+substring(convert(char(10),c.field_05_24,111),6,2)+substring(convert(char(10),c.field_05_24,111),9,2),
    a.PERIOD=substring(convert(char(10),c.field_05_24,111),1,4)+'0'+substring(convert(char(10),c.field_05_24,111),6,2)
from #temp2 a, #temp1 b, teflow_90_05 c
where a.epay_id=b.request_no
	and a.epay_id=c.request_no
	and b.form_system_id=90
---For Private_Car end


---For General_Payment for Supplier 91 begin
insert #temp2 (epay_id,dc_id) select b.request_no,b.id from #temp1 a, teflow_91_06 b where a.request_no=b.request_no

update a 
set a.ANAL_T0=isnull(left(c.field_06_9,4),''), 
    a.ANAL_T2=isnull(left(c.field_06_3,3),''), 
    a.ANAL_T3=isnull(left(c.field_06_5,3),''), 
    a.ANAL_T4=isnull(left(c.field_06_4,2),''),
    a.ANAL_T1=isnull(left(c.field_06_13,15),''),
    a.ANAL_T5=isnull(left(c.field_06_14,15),''),
    a.DB_CODE=isnull(left(ltrim(c.field_06_12),3),''),
    a.TREFERENCE='AA22',
    a.CONV_CODE=isnull(left(c.field_06_6,3),''), 
    a.DESCRIPTION=isnull(left(c.field_06_7,20),''),
    a.D_C=isnull(left(c.field_06_1,1), ''),
    a.OTH_AMT=isnull(c.field_06_8, 0),
    a.ACCNT_CODE=isnull((select min(rtrim(code)) from teflow_payment_sunac_code where c.field_06_11+' ' like rtrim(code)+' %' group by code),'')
from #temp2 a, #temp1 b, teflow_91_06 c
where a.epay_id=b.request_no
	and a.epay_id=c.request_no
	and a.dc_id=c.id
	and b.form_system_id=91

update a 
set a.TRANS_DATE=substring(convert(char(10),c.field_05_24,111),1,4)+substring(convert(char(10),c.field_05_24,111),6,2)+substring(convert(char(10),c.field_05_24,111),9,2),
    a.PERIOD=substring(convert(char(10),c.field_05_24,111),1,4)+'0'+substring(convert(char(10),c.field_05_24,111),6,2)
from #temp2 a, #temp1 b, teflow_91_05 c
where a.epay_id=b.request_no
	and a.epay_id=c.request_no
	and b.form_system_id=91
---For General_Payment	 end


---For Office_Rental 92 begin
insert #temp2 (epay_id,dc_id) select b.request_no,b.id from #temp1 a, teflow_92_06 b where a.request_no=b.request_no

update a 
set a.ANAL_T0=isnull(left(c.field_06_9,4),''), 
    a.ANAL_T2=isnull(left(c.field_06_3,3),''), 
    a.ANAL_T3=isnull(left(c.field_06_5,3),''), 
    a.ANAL_T4=isnull(left(c.field_06_4,2),''),
    a.ANAL_T1=isnull(left(c.field_06_13,15),''),
    a.ANAL_T5=isnull(left(c.field_06_14,15),''),
    a.DB_CODE=isnull(left(ltrim(c.field_06_12),3),''),
    a.TREFERENCE='AA21',
    a.CONV_CODE=isnull(left(c.field_06_6,3),''), 
    a.DESCRIPTION=isnull(left(c.field_06_7,20),''),
    a.D_C=isnull(left(c.field_06_1,1), ''),
    a.OTH_AMT=isnull(c.field_06_8, 0),
    a.ACCNT_CODE=isnull((select min(rtrim(code)) from teflow_payment_sunac_code where c.field_06_11+' ' like rtrim(code)+' %' group by code),'')
from #temp2 a, #temp1 b, teflow_92_06 c
where a.epay_id=b.request_no
	and a.epay_id=c.request_no
	and a.dc_id=c.id
	and b.form_system_id=92

update a 
set a.TRANS_DATE=substring(convert(char(10),c.field_05_24,111),1,4)+substring(convert(char(10),c.field_05_24,111),6,2)+substring(convert(char(10),c.field_05_24,111),9,2),
    a.PERIOD=substring(convert(char(10),c.field_05_24,111),1,4)+'0'+substring(convert(char(10),c.field_05_24,111),6,2)
from #temp2 a, #temp1 b, teflow_92_05 c
where a.epay_id=b.request_no
	and a.epay_id=c.request_no
	and b.form_system_id=92
---For Office_Rental	 end


---For Cash_Advance 94 begin
insert #temp2 (epay_id,dc_id) select b.request_no,b.id from #temp1 a, teflow_94_06 b where a.request_no=b.request_no

update a 
set a.ANAL_T0=isnull(left(c.field_06_9,4),''), 
    a.ANAL_T2=isnull(left(c.field_06_3,3),''), 
    a.ANAL_T3=isnull(left(c.field_06_5,3),''), 
    a.ANAL_T4=isnull(left(c.field_06_4,2),''),
    a.ANAL_T1=isnull(left(c.field_06_13,15),''),
    a.ANAL_T5=isnull(left(c.field_06_14,15),''),
    a.DB_CODE=isnull(left(ltrim(c.field_06_12),3),''),
    a.TREFERENCE='AA15',
    a.CONV_CODE=isnull(left(c.field_06_6,3),''), 
    a.DESCRIPTION=isnull(left(c.field_06_7,20),''),
    a.D_C=isnull(left(c.field_06_1,1), ''),
    a.OTH_AMT=isnull(c.field_06_8, 0),
    a.ACCNT_CODE=isnull((select min(rtrim(code)) from teflow_payment_sunac_code where c.field_06_11+' ' like rtrim(code)+' %' group by code),'')
from #temp2 a, #temp1 b, teflow_94_06 c
where a.epay_id=b.request_no
	and a.epay_id=c.request_no
	and a.dc_id=c.id
	and b.form_system_id=94

update a 
set a.TRANS_DATE=substring(convert(char(10),c.field_05_24,111),1,4)+substring(convert(char(10),c.field_05_24,111),6,2)+substring(convert(char(10),c.field_05_24,111),9,2),
    a.PERIOD=substring(convert(char(10),c.field_05_24,111),1,4)+'0'+substring(convert(char(10),c.field_05_24,111),6,2)
from #temp2 a, #temp1 b, teflow_94_05 c
where a.epay_id=b.request_no
	and a.epay_id=c.request_no
	and b.form_system_id=94
---For Cash_Advance 94 end

---For Travel 95 begin
insert #temp2 (epay_id,dc_id) select b.request_no,b.id from #temp1 a, teflow_95_06 b where a.request_no=b.request_no

update a 
set a.ANAL_T0=isnull(left(c.field_06_9,4),''), 
    a.ANAL_T2=isnull(left(c.field_06_3,3),''), 
    a.ANAL_T3=isnull(left(c.field_06_5,3),''), 
    a.ANAL_T4=isnull(left(c.field_06_4,2),''),
    a.ANAL_T1=isnull(left(c.field_06_13,15),''),
    a.ANAL_T5=isnull(left(c.field_06_14,15),''),
    a.DB_CODE=isnull(left(ltrim(c.field_06_12),3),''),
    a.TREFERENCE='AA11',
    a.CONV_CODE=isnull(left(c.field_06_6,3),''), 
    a.DESCRIPTION=isnull(left(c.field_06_7,20),''),
    a.D_C=isnull(left(c.field_06_1,1), ''),
    a.OTH_AMT=isnull(c.field_06_8, 0),
    a.ACCNT_CODE=isnull((select min(rtrim(code)) from teflow_payment_sunac_code where c.field_06_11+' ' like rtrim(code)+' %' group by code),'')
from #temp2 a, #temp1 b, teflow_95_06 c
where a.epay_id=b.request_no
	and a.epay_id=c.request_no
	and a.dc_id=c.id
	and b.form_system_id=95

update a 
set a.TRANS_DATE=substring(convert(char(10),c.field_05_24,111),1,4)+substring(convert(char(10),c.field_05_24,111),6,2)+substring(convert(char(10),c.field_05_24,111),9,2),
    a.PERIOD=substring(convert(char(10),c.field_05_24,111),1,4)+'0'+substring(convert(char(10),c.field_05_24,111),6,2)
from #temp2 a, #temp1 b, teflow_95_05 c
where a.epay_id=b.request_no
	and a.epay_id=c.request_no
	and b.form_system_id=95

---For Travel 95	 end

---For company code and city code
update a 
set a.COMPANY_CODE=c.comp_code,
    a.CITY_CODE=c.city_code
from #temp2 a, teflow_comp_city_t6map c
where a.DB_CODE=c.t6_code

update #temp2 set COMPANY_CODE='' where COMPANY_CODE is null
update #temp2 set CITY_CODE='' where CITY_CODE is null

---For D_C
--delete from #temp2 where isnull(ACCNT_CODE,'')='' or isnull(D_C,'')='' or isnull(COMPANY_CODE,'')=''
update #temp2 set D_C='D' where D_C='1'
update #temp2 set D_C='C' where D_C='2'


---For fixed value
update #temp2 
set BANK_NO='',
    POLICY_CODE='',
    ANAL_T6='', 
    ANAL_T7='', 
    ANAL_T8='', 
    ANAL_T9='',
    TREFERENCE='AA8',
    WB_TREFERENCE='',
    WB_JRNAL_NO='',
    WB_FLAG='',
    DUE_DATE='',
    ASSET_IND='',
    ASSET_SUB='',
    ASSET_CODE='',
    AMOUNT=0,
    CONV_RATE=0,
    JRNAL_SRCE='epay',
    JRNAL_TYPE='AA',
    ALLOCATION='',
    WB_ERR_DESC=''

update a 
set a.TRANS_DATE=substring(convert(char(10),c.handle_date,111),1,4)+substring(convert(char(10),c.handle_date,111),6,2)+substring(convert(char(10),c.handle_date,111),9,2),
    a.PERIOD=substring(convert(char(10),c.handle_date,111),1,4)+'0'+substring(convert(char(10),c.handle_date,111),6,2)
from #temp2 a, teflow_wkf_process_trace c
where a.epay_id=c.request_no and c.handle_type='05'
	and c.process_id=(select max(process_id) from teflow_wkf_process_trace where request_no=c.request_no)

update #temp2 
set PERIOD=substring(convert(char(10),dateadd(dd,5,TRANS_DATE),111),1,4)+'0'+substring(convert(char(10),dateadd(dd,5,TRANS_DATE),111),6,2)
where substring(TRANS_DATE,7,2) in ('29','30','31')

---For Batch No
update #temp2 set BATCH_NO='8'+right(period,2)

update a 
set a.BATCH_NO='9'+right(a.period,2)
from #temp2 a, teflow_wkf_process b, tpma_staffbasic c
where a.epay_id=b.request_no and b.request_staff_code=c.staff_code and c.org_id='Z07003'



insert teflow_ace_epayid_history select request_no, ace_date from #temp1
insert teflow_ace_interface select * from #temp2

drop table #temp1
drop table #temp2

/*

select * from teflow_form where form_system_id between 87 and 95
select * from teflow_form_section_field where form_system_id between 87 and 95 and section_id='06'
select * from teflow_form_section_field where form_system_id between 87 and 95 and section_id='07'
select * from teflow_wkf_process where flow_id in (select flow_id from teflow_wkf_define where form_system_id between 87 and 95) 
select * from dbo.teflow_ace_epayid_history
select * from teflow_ace_interface
delete from dbo.teflow_ace_epayid_history
delete from dbo.teflow_ace_interface
exec dbo.poef_build_ace_interface
select * from teflow_operate_log where operate_staff_code='System' and operate_description='Build interface with ACE'
select * from teflow_comp_city_t6map
*/


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


