--20150215 Justin Bin intial
-- 20150303 Justin Bin Changed: 1. add mapping for 20261,20259,20267, 2. add mapping field polno,create_usr
begin tran
delete from TNovaFieldMapping where [order]='14' and form_system_id='20264'

insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select 
'20264' as form_system_id,
'teflow_20264_02' as from_table,
'case when field_02_30 =''L'' then N''低风险'' 
		when field_02_30 =''M'' then N''中风险'' 
		when field_02_30 =''H'' then N''高风险'' end' as from_field, 
'' as Mul_field,
'heworksheet' as to_table,
'edesc' as to_field, 
'' as datetype,
'' as key_field,
14 as 'order'


insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select 
'20264' as form_system_id,
'teflow_20264_02' as from_table,
'field_02_6' as from_field, 
'' as mul_field,
'heworksheet' as to_table,
'eseqno' as to_field ,
'' as datetype,
'' as key_field,
14 as 'order'

insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select 
'20264' as form_system_id,
'teflow_20264_02' as from_table,
'field_02_6' as from_field, 
'' as mul_field,
'heworksheet' as to_table,
'polno' as to_field ,
'' as datetype,
'' as key_field,
14 as 'order'

insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select 
'20264' as form_system_id,
'teflow_20264_02' as from_table,
'field_02_28' as from_field, 
'' as mul_field,
'heworksheet' as to_table,
'create_usr' as to_field ,
'' as datetype,
'' as key_field,
14 as 'order'

COMMIT TRAN

-- 20261 js
begin tran
delete from TNovaFieldMapping where [order]='14' and form_system_id='20261'

insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select 
'20261' as form_system_id,
'teflow_20261_02' as from_table,
'case when field_02_30 =''L'' then N''低风险'' 
		when field_02_30 =''M'' then N''中风险'' 
		when field_02_30 =''H'' then N''高风险'' end' as from_field, 
'' as Mul_field,
'heworksheet' as to_table,
'edesc' as to_field, 
'' as datetype,
'' as key_field,
14 as 'order'


insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select 
'20261' as form_system_id,
'teflow_20261_02' as from_table,
'field_02_6' as from_field, 
'' as mul_field,
'heworksheet' as to_table,
'eseqno' as to_field ,
'' as datetype,
'' as key_field,
14 as 'order'

insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select 
'20261' as form_system_id,
'teflow_20261_02' as from_table,
'field_02_6' as from_field, 
'' as mul_field,
'heworksheet' as to_table,
'polno' as to_field ,
'' as datetype,
'' as key_field,
14 as 'order'

insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select 
'20261' as form_system_id,
'teflow_20261_02' as from_table,
'field_02_28' as from_field, 
'' as mul_field,
'heworksheet' as to_table,
'create_usr' as to_field ,
'' as datetype,
'' as key_field,
14 as 'order'

COMMIT TRAN

-- 20259 sz
begin tran
delete from TNovaFieldMapping where [order]='14' and form_system_id='20259'

insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select 
'20259' as form_system_id,
'teflow_20259_02' as from_table,
'case when field_02_30 =''L'' then N''低风险'' 
		when field_02_30 =''M'' then N''中风险'' 
		when field_02_30 =''H'' then N''高风险'' end' as from_field, 
'' as Mul_field,
'heworksheet' as to_table,
'edesc' as to_field, 
'' as datetype,
'' as key_field,
14 as 'order'


insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select 
'20259' as form_system_id,
'teflow_20259_02' as from_table,
'field_02_6' as from_field, 
'' as mul_field,
'heworksheet' as to_table,
'eseqno' as to_field ,
'' as datetype,
'' as key_field,
14 as 'order'

insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select 
'20259' as form_system_id,
'teflow_20259_02' as from_table,
'field_02_6' as from_field, 
'' as mul_field,
'heworksheet' as to_table,
'polno' as to_field ,
'' as datetype,
'' as key_field,
14 as 'order'

insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select 
'20259' as form_system_id,
'teflow_20259_02' as from_table,
'field_02_28' as from_field, 
'' as mul_field,
'heworksheet' as to_table,
'create_usr' as to_field ,
'' as datetype,
'' as key_field,
14 as 'order'

COMMIT TRAN

--
begin tran
delete from TNovaFieldMapping where [order]='14' and form_system_id='20267'

insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select 
'20267' as form_system_id,
'teflow_20264_02' as from_table,
'case when field_02_30 =''L'' then N''低风险'' 
		when field_02_30 =''M'' then N''中风险'' 
		when field_02_30 =''H'' then N''高风险'' end' as from_field, 
'' as Mul_field,
'heworksheet' as to_table,
'edesc' as to_field, 
'' as datetype,
'' as key_field,
14 as 'order'


insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select 
'20267' as form_system_id,
'teflow_20267_02' as from_table,
'field_02_6' as from_field, 
'' as mul_field,
'heworksheet' as to_table,
'eseqno' as to_field ,
'' as datetype,
'' as key_field,
14 as 'order'

insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select 
'20267' as form_system_id,
'teflow_20267_02' as from_table,
'field_02_6' as from_field, 
'' as mul_field,
'heworksheet' as to_table,
'polno' as to_field ,
'' as datetype,
'' as key_field,
14 as 'order'

insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select 
'20267' as form_system_id,
'teflow_20267_02' as from_table,
'field_02_28' as from_field, 
'' as mul_field,
'heworksheet' as to_table,
'create_usr' as to_field ,
'' as datetype,
'' as key_field,
14 as 'order'

COMMIT TRAN

-- =========================================================================================
-- 20150305 Sting Wu ---
 update TNovaFieldMapping set from_field = 'CONCAT(N''团体员工人:'',field_5_1,char(13),
N''总共参保人:'',field_5_2 ,char(13),
N''未能全员参保原因:'' ,field_5_3,char(13), 
N''未能全员参保原因详情:'',field_5_7,char(13),
N''单证编号:'',field_5_4,char(13), 
N''版本号:'',field_5_5,char(13), 
N''溢缴保费处理 抵缴续期保费退还缴费账户:'' ,field_5_6,CHAR(13),replace(stuff(( select '';'' + name from (
	 select name=(N''保险计划:'' + isnull(rtrim(t2.NOVA_PRODCODE_Local),'''') + N'' - '' 
		+ isnull(rtrim(t3.NOVA_BENPLNCD_Local),'''') + '';'' + N''被保险人职业内容/职业描述:'' + field_4_2)
	 from teflow_20264_4 t1
	left join (select distinct NOVA_PRODCODE,NOVA_PRODCODE_Local from TNovaProductMapping) t2 on t1.Product_id = t2.NOVA_PRODCODE 
	left join TNovaProductMapping t3 on t1.Product_id = t3.NOVA_PRODCODE and t1.Plan_id = t3.NOVA_BENPLNCD 
	 where t1.request_no = teflow_20264_5.request_no) T for xml path('''')),1,1,''''),'';'',CHAR(13)),CHAR(13),
N''等候期(日):'',(select field_02_24 from teflow_20264_02 where request_no = teflow_20264_5.request_no))'
where form_system_id = '20264' and to_table = 'tpolnote' and to_field = 'note'
-- ===========================================================================================
--20150312 SamYu intial for GCPA

update TNovaFieldMapping set from_field = 'field_9_20' where form_system_id = '20267' and to_table in ('TMEMPTPOL','TBILLDETAIL_NOVA') and to_field = 'PRODCODE'

update TNovaFieldMapping set from_field = 'field_9_21' where form_system_id = '20267' and to_table in ('TMEMPTPOL','TBILLDETAIL_NOVA') and to_field = 'BENPLNCD'

update TNovaFieldMapping set Mul_Field = 'Teflow_20267_11.id' where form_system_id = '20267' and to_table ='TCLNTSUB' and to_field = 'TAXID'

-- ========================================================
-- 20150305 asnpg10

delete tnovafieldmapping where form_system_id = '20261' and to_field ='POLICYTYPE'

--=====================================================

-- 20150402 asnpge6 Issac for CPA13
UPDATE TNOVAFIELDMAPPING SET from_field="CASE WHEN product_id ='CPA12' THEN 'GDPA3' WHEN product_id ='CPA13' THEN 'GDSIMPLE' ELSE NULL END" 
WHERE form_system_id='20264' AND to_table='TPOLADDH' AND to_field ='POLICYTYPE'--=====================================================

-- 20150404 asnpge6 Issac for GCPA
UPDATE TNovaFieldMapping SET from_table='teflow_20267_productplan' where to_table = 'TPOLPDT_NOVA' and form_system_id='20267' AND from_table ='teflow_20267_4'

--====================================================

-- 20150410 Justin Bin udpate tmemptol's chgeffdt
begin tran
delete from TNovaFieldMapping where to_table='TMEMPTPOL' and to_field='chgeffdt'
insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select form_system_id
		,CONCAT('teflow_',form_system_id,'_9') as from_table 
		,N'convert(char(10),getdate(),112) ' as from_field
		,'id' as mul_field
		,'TMEMPTPOL' as to_table
		,'CHGEFFDT' as to_field
		,'DATETIME' as datetype
		,'' as key_field
		,'12' as 'order'
from teflow_form where  [status]='0' and form_system_id in('20267','20259','20261','20264','30286','30288')
commit tran

-- 20150410 Justin Bin update tmember's chgeffdt
begin tran
update TNOVAFIELDMAPPING set from_field = 'CONVERT(CHAR(10),Request_date,120)' WHERE TO_TABLE = 'TMEMBER' AND TO_FIELD = 'CHGEFFDT' and form_system_id in ('20259','20261','20264','20267')
commit tran


-- 20150410 Justin Bin update heworksheet's create_dt rcdstmp
begin tran
delete from TNovaFieldMapping where to_table='heworksheet' and to_field='create_dt' 
insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select form_system_id
		,CONCAT('teflow_',form_system_id,'_02') as from_table 
		,N'getdate()' as from_field
		,'' as mul_field
		,'heworksheet' as to_table
		,'create_dt' as to_field
		,'DATETIME' as datetype
		,'' as key_field
		,'14' as 'order'
from teflow_form where  [status]='0' and form_system_id in('20267','20259','20261','20264','30286','30288')



delete from TNovaFieldMapping where to_table='heworksheet' and to_field='rcddtstmp'
insert into TNovaFieldMapping (form_system_id,from_table,from_field,Mul_Field,to_table,to_field,datetype,key_field,[order])
select form_system_id
		,CONCAT('teflow_',form_system_id,'_02') as from_table 
		,N'getdate()' as from_field
		,'' as mul_field
		,'heworksheet' as to_table
		,'rcddtstmp' as to_field
		,'DATETIME' as datetype
		,'' as key_field
		,'14' as 'order'
from teflow_form where  [status]='0' and form_system_id in('20267','20259','20261','20264','30286','30288')

commit tran


--20150413 TCLIENTSUB.address mapping. Justin Bin
begin tran
delete from TNovaFieldMapping where to_field='ADDRESS1'and to_table='TCLNTSUB' and form_system_id in('20267','20259','20261','20264','30286','30288')
insert into TNovaFieldMapping 
select form_system_id
		,CONCAT('teflow_',form_system_id,'_11') as from_table 
		,N'SUBSTRING(field_11_3,1,14)' as from_field
		,'id' as mul_field
		,'TCLNTSUB' as to_table
		,'ADDRESS1' as to_field
		,'' as datetype
		,'' as key_field
		,'1' as 'order'
from teflow_form where  [status]='0' and form_system_id in('20267','20259','20261','20264','30286','30288')

delete from TNovaFieldMapping where to_field='ADDRESS2'and to_table='TCLNTSUB' and form_system_id in('20267','20259','20261','20264','30286','30288')
insert into TNovaFieldMapping 
select form_system_id
		,CONCAT('teflow_',form_system_id,'_11') as from_table 
		,N'SUBSTRING(field_11_3,15,14)' as from_field
		,'id' as mul_field
		,'TCLNTSUB' as to_table
		,'ADDRESS2' as to_field
		,'' as datetype
		,'' as key_field
		,'1' as 'order'
from teflow_form where  [status]='0' and form_system_id in('20267','20259','20261','20264','30286','30288')

delete from TNovaFieldMapping where to_field='ADDRESS3'and to_table='TCLNTSUB' and form_system_id in('20267','20259','20261','20264','30286','30288')
insert into TNovaFieldMapping 
select form_system_id
		,CONCAT('teflow_',form_system_id,'_11') as from_table 
		,N'SUBSTRING(field_11_3,29,14)' as from_field
		,'id' as mul_field
		,'TCLNTSUB' as to_table
		,'ADDRESS3' as to_field
		,'' as datetype
		,'' as key_field
		,'1' as 'order'
from teflow_form where  [status]='0' and form_system_id in('20267','20259','20261','20264','30286','30288')

delete from TNovaFieldMapping where to_field='ADDRESS4'and to_table='TCLNTSUB' and form_system_id in('20267','20259','20261','20264','30286','30288')
insert into TNovaFieldMapping 
select form_system_id
		,CONCAT('teflow_',form_system_id,'_11') as from_table 
		,N'SUBSTRING(field_11_3,43,14)' as from_field
		,'id' as mul_field
		,'TCLNTSUB' as to_table
		,'ADDRESS4' as to_field
		,'' as datetype
		,'' as key_field
		,'1' as 'order'
from teflow_form where  [status]='0' and form_system_id in('20267','20259','20261','20264','30286','30288')

commit tran

-- 20150413 TCLIENT.address Mapping , Justin Bin
begin tran
delete from TNovaFieldMapping where to_field='ADDRESS1'and to_table='TCLIENT' and form_system_id in('20267','20259','20261','20264','30286','30288')
insert into TNovaFieldMapping 
select form_system_id
		,CONCAT('teflow_',form_system_id,'_02') as from_table 
		,N'LEFT(field_02_9,14)' as from_field
		,'' as mul_field
		,'TCLIENT' as to_table
		,'ADDRESS1' as to_field
		,'' as datetype
		,'' as key_field
		,'0' as 'order'
from teflow_form where  [status]='0' and form_system_id in('20267','20259','20261','20264','30286','30288')

delete from TNovaFieldMapping where to_field='ADDRESS2'and to_table='TCLIENT' and form_system_id in('20267','20259','20261','20264','30286','30288')
insert into TNovaFieldMapping 
select form_system_id
		,CONCAT('teflow_',form_system_id,'_02') as from_table 
		,N'SUBSTRING(field_02_9,15,14)' as from_field
		,'' as mul_field
		,'TCLIENT' as to_table
		,'ADDRESS2' as to_field
		,'' as datetype
		,'' as key_field
		,'0' as 'order'
from teflow_form where  [status]='0' and form_system_id in('20267','20259','20261','20264','30286','30288')

delete from TNovaFieldMapping where to_field='ADDRESS3'and to_table='TCLIENT' and form_system_id in('20267','20259','20261','20264','30286','30288')
insert into TNovaFieldMapping 
select form_system_id
		,CONCAT('teflow_',form_system_id,'_02') as from_table 
		,N'SUBSTRING(field_02_9,29,14)' as from_field
		,'' as mul_field
		,'TCLIENT' as to_table
		,'ADDRESS3' as to_field
		,'' as datetype
		,'' as key_field
		,'0' as 'order'
from teflow_form where  [status]='0' and form_system_id in('20267','20259','20261','20264','30286','30288')


delete from TNovaFieldMapping where to_field='ADDRESS4'and to_table='TCLIENT' and form_system_id in('20267','20259','20261','20264','30286','30288')
insert into TNovaFieldMapping 
select form_system_id
		,CONCAT('teflow_',form_system_id,'_02') as from_table 
		,N'SUBSTRING(field_02_9,43,14)' as from_field
		,'' as mul_field
		,'TCLIENT' as to_table
		,'ADDRESS4' as to_field
		,'' as datetype
		,'' as key_field
		,'0' as 'order'
from teflow_form where  [status]='0' and form_system_id in('20267','20259','20261','20264','30286','30288')
commit tran

