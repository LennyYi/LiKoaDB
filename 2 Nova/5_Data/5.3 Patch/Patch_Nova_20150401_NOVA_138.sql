--2015-04-01 Sting Wu for NOVA-138
delete t1 from teflow_wkf_handle t1 inner join teflow_wkf_define t2 on t1.flow_id = t2.flow_id and t2.form_system_id in (20264,20261,20267,20259)
insert into teflow_wkf_handle
select * from ( select flow_id from teflow_wkf_define where form_system_id in (20264,20261,20267,20259)) t1
cross join (select 25 as node_id,'NovaUspCompassTrigger' as approve_handle,'' as reject_handle
union all select 26 as node_id,'NovaUspCompassTrigger' as approve_handle,'' as reject_handle
union all select 27 as node_id,'NovaUspCompassTrigger' as approve_handle,'' as reject_handle
union all select 31 as node_id,'NovaUspCompassTrigger' as approve_handle,'' as reject_handle) t2


update t1 set compare_type = 'like' from teflow_wkf_detail_rule t1 inner join (select distinct flow_id from teflow_wkf_define where form_system_id in (20259,20261,20264,20267)) t2 
on t1.flow_id = t2.flow_id and t1.compare_type = 'li'


update teflow_wkf_define set company_id = 'Z07009' where form_system_id = '20259'


update t1 set update_section_fields = '01.company_id,02.field_02_6,02.field_02_16,02.field_02_17,02.field_02_26,02.field_02_13,02.field_02_34,02.field_02_33,02.field_02_8,02.field_02_9,02.field_02_18,02.field_02_31,02.field_02_23,02.field_02_25,02.field_02_19,02.field_02_20,02.field_02_21,02.field_02_22,02.field_02_24,02.OriginalPol,02.field_02_27,02.field_02_30,02.field_02_28,02.field_02_32,5.field_5_1,5.field_5_2,5.field_5_3,5.field_5_7,5.field_5_4,5.field_5_5,5.field_5_6,6.field_6_1,6.AE_id,6.field_6_6,2.field_2_1,2.field_2_5,2.field_2_9,2.field_2_10,2.field_2_3,2.field_2_6,2.field_2_7,2.field_2_8,BranchInf.BranCod_id,BranchInf.SecCity,BranchInf.field_BranchInf_2,BranchInf.field_BranchInf_3,BranchInf.field_BranchInf_4,SystemFW.field_SystemFW_1,4.field_4_1,4.field_4_2,4.field_4_3,4.field_4_4,4.field_4_5,4.field_4_6,4.field_4_7,4.field_4_8,4.field_4_9,7.field_7_2,7.field_7_1,7.field_7_3,7.field_7_6,7.field_7_4,7.field_7_5,9.field_9_19,9.field_9_17,9.field_9_2,9.field_9_3,9.field_9_4,9.field_9_16,9.field_9_6,9.field_9_7,9.field_9_8,9.field_9_9,9.field_9_18,9.field_9_1,9.field_9_10,9.field_9_15,9.field_9_20,9.field_9_21,9.field_9_12,9.field_9_13,11.field_11_1,11.field_11_2,11.field_11_8,11.field_11_3,11.field_11_13,11.field_11_6,11.field_11_5,11.field_11_4,11.field_11_7,11.field_11_9,11.field_11_10,11.field_11_11,11.field_11_12'
from teflow_wkf_detail t1 inner join  teflow_wkf_define t2 
on t1.flow_id = t2.flow_id and t1.node_id = 31 and t2.form_system_id = 20267

update t1 set update_section_fields = '01.company_id,02.field_02_6,02.field_02_16,02.field_02_17,02.field_02_26,02.field_02_13,02.field_02_34,02.field_02_33,02.field_02_8,02.field_02_9,02.field_02_18,02.field_02_31,02.field_02_23,02.field_02_25,02.field_02_19,02.field_02_20,02.field_02_21,02.field_02_22,02.field_02_24,02.OriginalPol,02.field_02_27,02.field_02_30,02.field_02_28,02.field_02_32,5.field_5_1,5.field_5_2,5.field_5_3,5.field_5_7,5.field_5_4,5.field_5_5,5.field_5_6,6.field_6_1,6.AE_id,6.field_6_6,2.field_2_1,2.field_2_5,2.field_2_9,2.field_2_10,2.field_2_3,2.field_2_6,2.field_2_7,2.field_2_8,BranchInf.BranCod_id,BranchInf.SecCity,BranchInf.field_BranchInf_2,BranchInf.field_BranchInf_3,BranchInf.field_BranchInf_4,SystemFW.field_SystemFW_1,4.Product_id,4.Plan_id,4.field_4_6,4.field_4_7,4.field_4_2,4.field_4_3,7.field_7_2,7.field_7_1,7.field_7_3,7.field_7_6,7.field_7_4,7.field_7_5,9.field_9_19,9.field_9_17,9.field_9_2,9.field_9_3,9.field_9_4,9.field_9_16,9.field_9_6,9.field_9_7,9.field_9_8,9.field_9_9,9.field_9_18,9.field_9_1,9.field_9_10,9.field_9_15,9.MemProduct_id,9.MemPlan_id,9.field_9_12,9.field_9_13,11.field_11_1,11.field_11_2,11.field_11_8,11.field_11_3,11.field_11_13,11.field_11_6,11.field_11_5,11.field_11_4,11.field_11_7,11.field_11_9,11.field_11_10,11.field_11_11,11.field_11_12'
from teflow_wkf_detail t1 inner join  teflow_wkf_define t2 
on t1.flow_id = t2.flow_id and t1.node_id = 31 and t2.form_system_id = 20261

update t1 set update_section_fields = '01.company_id,02.field_02_6,02.field_02_16,02.field_02_17,02.field_02_26,02.field_02_13,02.field_02_34,02.field_02_33,02.field_02_8,02.field_02_9,02.field_02_18,02.field_02_31,02.field_02_23,02.field_02_25,02.field_02_19,02.field_02_20,02.field_02_21,02.field_02_22,02.field_02_24,02.OriginalPol,02.field_02_27,02.field_02_30,02.field_02_28,02.field_02_32,5.field_5_1,5.field_5_2,5.field_5_3,5.field_5_7,5.field_5_4,5.field_5_5,5.field_5_6,6.field_6_1,6.AE_id,6.field_6_6,2.field_2_1,2.field_2_5,2.field_2_9,2.field_2_10,2.field_2_3,2.field_2_6,2.field_2_7,2.field_2_8,BranchInf.BranCod_id,BranchInf.SecCity,BranchInf.field_BranchInf_2,BranchInf.field_BranchInf_3,BranchInf.field_BranchInf_4,SystemFW.field_SystemFW_1,4.Product_id,4.Plan_id,4.field_4_6,4.field_4_7,4.field_4_2,4.field_4_3,7.field_7_2,7.field_7_1,7.field_7_3,7.field_7_4,7.field_7_5,9.field_9_19,9.field_9_17,9.field_9_2,9.field_9_3,9.field_9_4,9.field_9_16,9.field_9_6,9.field_9_7,9.field_9_8,9.field_9_9,9.field_9_18,9.field_9_1,9.field_9_10,9.field_9_15,9.MemProduct_id,9.MemPlan_id,9.field_9_12,9.field_9_13,11.field_11_1,11.field_11_2,11.field_11_8,11.field_11_3,11.field_11_13,11.field_11_6,11.field_11_5,11.field_11_4,11.field_11_7,11.field_11_9,11.field_11_10,11.field_11_11,11.field_11_12'
from teflow_wkf_detail t1 inner join  teflow_wkf_define t2 
on t1.flow_id = t2.flow_id and t1.node_id = 31 and t2.form_system_id = 20264

update t1 set update_section_fields = '01.company_id,02.field_02_6,02.field_02_16,02.field_02_17,02.field_02_26,02.field_02_13,02.field_02_34,02.field_02_33,02.field_02_8,02.field_02_9,02.field_02_18,02.field_02_31,02.field_02_23,02.field_02_25,02.field_02_19,02.field_02_20,02.field_02_21,02.field_02_22,02.field_02_24,02.OriginalPol,02.field_02_27,02.field_02_30,02.field_02_28,02.field_02_32,5.field_5_1,5.field_5_2,5.field_5_3,5.field_5_7,5.field_5_4,5.field_5_5,5.field_5_6,6.field_6_1,6.AE_id,6.field_6_6,2.field_2_1,2.field_2_5,2.field_2_9,2.field_2_10,2.field_2_3,2.field_2_6,2.field_2_7,2.field_2_8,BranchInf.BranCod_id,BranchInf.SecCity,BranchInf.field_BranchInf_2,BranchInf.field_BranchInf_3,BranchInf.field_BranchInf_4,SystemFW.field_SystemFW_1,4.field_4_19,4.field_4_8,4.PlanCode_id,4.field_4_9,4.field_4_10,4.field_4_11,4.field_4_12,4.field_4_13,4.field_4_14,4.field_4_15,4.field_4_16,4.field_4_17,4.field_4_2,4.field_4_3,7.field_7_2,7.field_7_1,7.field_7_3,7.field_7_6,7.field_7_4,7.field_7_5,9.field_9_19,9.field_9_17,9.field_9_2,9.field_9_3,9.field_9_4,9.field_9_16,9.field_9_6,9.field_9_7,9.field_9_8,9.field_9_9,9.field_9_18,9.field_9_1,9.field_9_10,9.field_9_15,9.field_9_20,9.PlanCodeMem_id,9.field_9_12,9.field_9_13,11.field_11_1,11.field_11_2,11.field_11_8,11.field_11_3,11.field_11_13,11.field_11_6,11.field_11_5,11.field_11_4,11.field_11_7,11.field_11_9,11.field_11_10,11.field_11_11,11.field_11_12'
from teflow_wkf_detail t1 inner join  teflow_wkf_define t2 
on t1.flow_id = t2.flow_id and t1.node_id = 31 and t2.form_system_id = 20259