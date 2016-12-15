declare @flowId decimal

select @flowId = flow_id from teflow_wkf_define where form_system_id = 30319

delete from teflow_wkf_detail where flow_id = @flowId

INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'0',N'',N'',N'Begin',N'0',N'0',N'0',N'',N'',N'615px',N'1456px',N'',N'',N'',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'-1',N'',N'24',N'End',N'0',N'0',N'0',N'',N'',N'5519px',N'3129px',N'',N'',N'',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'23',N'4',N'30',N'验证账单支付',N'0',N'0',N'0',N'00',N'',N'2205px',N'3119px',N'',N'',N'11.Payment',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'24',N'4',N'23',N'生成合同',N'0',N'0',N'0',N'00',N'',N'3816px',N'3119px',N'',N'',N'12.Contact',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'25',N'2',N'31,0',N'信息确认',N'0',N'0',N'0',N'00',N'',N'2236px',N'1467px',N'SystemFW.field_SystemFW_8',N'SystemFW.field_SystemFW_8,SystemFW.field_SystemFW_1',N'00.Confirm',N'确认',N'重新填写')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'26',N'2',N'25',N'系统验证',N'0',N'0',N'0',N'',N'System001',N'3909px',N'1487px',N'SystemFW.field_SystemFW_1',N'',N'01.Validation',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'27',N'2',N'26,33,35',N'数据确认',N'0',N'0',N'0',N'00',N'',N'8915px',N'1303px',N'SystemFW.field_SystemFW_1',N'',N'04.DataCM',N'确认',N'重新填写')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'28',N'2',N'27',N'数据插入',N'0',N'0',N'0',N'',N'System001',N'11080px',N'964px',N'SystemFW.field_SystemFW_1',N'',N'06.Insert',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'29',N'4',N'32,28',N'正式账单',N'0',N'0',N'0',N'',N'System001',N'12978px',N'1662px',N'',N'',N'08.Officail',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'30',N'2',N'29',N'账单报告',N'0',N'0',N'0',N'',N'System001',N'584px',N'3108px',N'SystemFW.field_SystemFW_1',N'',N'09.Report',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'31',N'2',N'25,26',N'错误控制',N'0',N'0',N'0',N'00',N'',N'779px',N'2236px',N'01.company_id,02.field_02_6,02.field_02_16,02.field_02_17,02.field_02_26,02.field_02_13,02.field_02_34,02.field_02_33,02.field_02_8,02.field_02_9,02.field_02_18,02.field_02_31,02.field_02_23,02.field_02_25,02.field_02_19,02.field_02_20,02.field_02_21,02.field_02_22,02.field_02_24,02.OriginalPol,02.field_02_27,02.field_02_30,02.field_02_28,02.field_02_32,10.field_10_1,10.field_10_6,10.field_10_2,10.field_10_4,10.field_10_3,10.field_10_5,10.field_10_7,5.field_5_1,5.field_5_2,5.field_5_3,5.field_5_7,5.field_5_4,5.field_5_5,5.field_5_6,6.field_6_1,6.AE_id,6.field_6_6,2.field_2_1,2.field_2_5,2.field_2_9,2.field_2_10,2.field_2_3,2.field_2_6,2.field_2_7,2.field_2_8,BranchInf.BranCod_id,BranchInf.SecCity,BranchInf.field_BranchInf_2,BranchInf.field_BranchInf_3,BranchInf.field_BranchInf_4,SystemFW.field_SystemFW_1,Pend.PendingList,Pend.field_Pend_3,Pend.field_Pend_5,4.field_4_19,4.field_4_8,4.Plan_id,4.field_4_9,4.field_4_10,4.field_4_12,4.field_4_11,4.field_4_13,4.field_4_14,4.field_4_15,4.field_4_16,4.field_4_17,4.field_4_20,4.field_4_2,4.field_4_3,7.field_7_2,7.field_7_1,7.field_7_3,7.field_7_6,7.field_7_4,7.field_7_5,9.field_9_19,9.field_9_17,9.field_9_2,9.field_9_3,9.field_9_4,9.field_9_16,9.field_9_6,9.field_9_7,9.field_9_8,9.field_9_9,9.field_9_18,9.field_9_1,9.field_9_10,9.field_9_15,9.field_9_20,9.MemPlan_id,9.field_9_12,9.field_9_13,11.field_11_1,11.field_11_2,11.field_11_8,11.field_11_3,11.field_11_13,11.field_11_6,11.field_11_5,11.field_11_4,11.field_11_7,11.field_11_9,11.field_11_10,11.field_11_11,11.field_11_12',N'',N'05.ErrorHandle',N'再次提交',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'32',N'2',N'30,29',N'系统支持',N'0',N'0',N'0',N'',N'C0378',N'8320px',N'4791px',N'',N'',N'10.ErrorHandle',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'33',N'2',N'34',N'等待照会',N'0',N'0',N'0',N'00',N'',N'7069px',N'554px',N'01.company_id,02.field_02_6,02.field_02_16,02.field_02_17,02.field_02_26,02.field_02_13,02.field_02_34,02.field_02_33,02.field_02_8,02.field_02_9,02.field_02_18,02.field_02_31,02.field_02_23,02.field_02_25,02.field_02_19,02.field_02_20,02.field_02_21,02.field_02_22,02.field_02_24,02.OriginalPol,02.field_02_27,02.field_02_30,02.field_02_28,02.field_02_32,10.field_10_1,10.field_10_6,10.field_10_2,10.field_10_4,10.field_10_3,10.field_10_5,10.field_10_7,5.field_5_1,5.field_5_2,5.field_5_3,5.field_5_7,5.field_5_4,5.field_5_5,5.field_5_6,6.field_6_1,6.AE_id,6.field_6_6,2.field_2_1,2.field_2_5,2.field_2_9,2.field_2_10,2.field_2_3,2.field_2_6,2.field_2_7,2.field_2_8,BranchInf.BranCod_id,BranchInf.SecCity,BranchInf.field_BranchInf_2,BranchInf.field_BranchInf_3,BranchInf.field_BranchInf_4,SystemFW.field_SystemFW_1,Pend.PendingList,Pend.field_Pend_3,Pend.field_Pend_5,4.field_4_19,4.field_4_8,4.Plan_id,4.field_4_9,4.field_4_10,4.field_4_12,4.field_4_11,4.field_4_13,4.field_4_14,4.field_4_15,4.field_4_16,4.field_4_17,4.field_4_20,4.field_4_2,4.field_4_3,7.field_7_2,7.field_7_1,7.field_7_3,7.field_7_6,7.field_7_4,7.field_7_5,9.field_9_19,9.field_9_17,9.field_9_2,9.field_9_3,9.field_9_4,9.field_9_16,9.field_9_6,9.field_9_7,9.field_9_8,9.field_9_9,9.field_9_18,9.field_9_1,9.field_9_10,9.field_9_15,9.field_9_20,9.MemPlan_id,9.field_9_12,9.field_9_13,11.field_11_1,11.field_11_2,11.field_11_8,11.field_11_3,11.field_11_13,11.field_11_6,11.field_11_5,11.field_11_4,11.field_11_7,11.field_11_9,11.field_11_10,11.field_11_11,11.field_11_12',N'',N'03.WaitHandle',N'照会完成',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'34',N'2',N'26',N'照会审批',N'0',N'0',N'0',N'00',N'',N'5478px',N'543px',N'Pend.PendingList,Pend.field_Pend_3,Pend.field_Pend_5',N'',N'02.WaitHandle',N'审批通过',N'重新提交')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'35',N'2',N'28',N'错误控制',N'0',N'0',N'0',N'00',N'',N'7007px',N'2318px',N'SystemFW.field_SystemFW_1',N'',N'07.ErrorHandle',N'',N'')

select @flowId = flow_id from teflow_wkf_define where form_system_id = 20264

delete from teflow_wkf_detail where flow_id = @flowId

INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'0',N'',N'',N'Begin',N'0',N'0',N'0',N'',N'',N'615px',N'1456px',N'',N'',N'',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'-1',N'',N'24',N'End',N'0',N'0',N'0',N'',N'',N'5519px',N'3129px',N'',N'',N'',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'23',N'4',N'30',N'验证账单支付',N'0',N'0',N'0',N'00',N'',N'2205px',N'3119px',N'',N'',N'11.Payment',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'24',N'4',N'23',N'生成合同',N'0',N'0',N'0',N'00',N'',N'3816px',N'3119px',N'',N'',N'12.Contact',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'25',N'2',N'0,31',N'信息确认',N'0',N'0',N'0',N'00',N'',N'2236px',N'1467px',N'SystemFW.field_SystemFW_8',N'SystemFW.field_SystemFW_8,SystemFW.field_SystemFW_1',N'00.Confirm',N'确认',N'重新填写')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'26',N'2',N'25',N'系统验证',N'0',N'0',N'0',N'',N'System001',N'3909px',N'1487px',N'SystemFW.field_SystemFW_1',N'',N'01.Validation',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'27',N'2',N'35,33,26',N'数据确认',N'0',N'0',N'0',N'00',N'',N'8915px',N'1303px',N'SystemFW.field_SystemFW_1',N'',N'04.DataCM',N'确认',N'重新填写')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'28',N'2',N'27',N'数据插入',N'0',N'0',N'0',N'',N'System001',N'11080px',N'964px',N'SystemFW.field_SystemFW_1',N'',N'06.Insert',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'29',N'4',N'28,32',N'正式账单',N'0',N'0',N'0',N'',N'System001',N'12978px',N'1662px',N'',N'',N'08.Officail',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'30',N'2',N'29',N'账单报告',N'0',N'0',N'0',N'',N'System001',N'584px',N'3108px',N'SystemFW.field_SystemFW_1',N'',N'09.Report',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'31',N'2',N'26,25',N'错误控制',N'0',N'0',N'0',N'00',N'',N'779px',N'2236px',N'01.company_id,02.field_02_6,02.field_02_16,02.field_02_17,02.field_02_26,02.field_02_13,02.field_02_34,02.field_02_33,02.field_02_8,02.field_02_9,02.field_02_18,02.field_02_31,02.field_02_23,02.field_02_25,02.field_02_19,02.field_02_20,02.field_02_21,02.field_02_22,02.field_02_24,02.OriginalPol,02.field_02_27,02.field_02_30,02.field_02_28,02.field_02_32,10.field_10_1,10.field_10_6,10.field_10_2,10.field_10_4,10.field_10_3,10.field_10_5,10.field_10_7,10.field_10_8,10.field_10_9,5.field_5_1,5.field_5_2,5.field_5_3,5.field_5_7,5.field_5_4,5.field_5_5,5.field_5_6,6.field_6_1,6.AE_id,6.field_6_6,2.field_2_1,2.field_2_5,2.field_2_9,2.field_2_10,2.field_2_3,2.field_2_6,2.field_2_7,2.field_2_8,BranchInf.BranCod_id,BranchInf.SecCity,BranchInf.field_BranchInf_2,BranchInf.field_BranchInf_3,BranchInf.field_BranchInf_4,Pend.PendingList,Pend.field_Pend_3,Pend.field_Pend_5,4.Product_id,4.Plan_id,4.field_4_6,4.field_4_7,4.field_4_2,4.field_4_3,7.field_7_2,7.field_7_1,7.field_7_3,7.field_7_6,7.field_7_4,7.field_7_5,9.field_9_19,9.field_9_17,9.field_9_2,9.field_9_3,9.field_9_4,9.field_9_16,9.field_9_6,9.field_9_7,9.field_9_8,9.field_9_9,9.field_9_18,9.field_9_1,9.field_9_10,9.field_9_15,9.MemProduct_id,9.MemPlan_id,9.field_9_12,9.field_9_13,11.field_11_1,11.field_11_2,11.field_11_8,11.field_11_3,11.field_11_13,11.field_11_6,11.field_11_5,11.field_11_4,11.field_11_7,11.field_11_9,11.field_11_10,11.field_11_11,11.field_11_12',N'',N'05.ErrorHandle',N'再次提交',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'32',N'2',N'29,30',N'系统支持',N'0',N'0',N'0',N'',N'C0378',N'8320px',N'4791px',N'',N'',N'10.ErrorHandle',N'',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'33',N'2',N'34',N'等待照会',N'0',N'0',N'0',N'00',N'',N'7069px',N'554px',N'01.company_id,02.field_02_6,02.field_02_16,02.field_02_17,02.field_02_26,02.field_02_13,02.field_02_34,02.field_02_33,02.field_02_8,02.field_02_9,02.field_02_18,02.field_02_31,02.field_02_23,02.field_02_25,02.field_02_19,02.field_02_20,02.field_02_21,02.field_02_22,02.field_02_24,02.OriginalPol,02.field_02_27,02.field_02_30,02.field_02_28,02.field_02_32,10.field_10_1,10.field_10_6,10.field_10_2,10.field_10_4,10.field_10_3,10.field_10_5,10.field_10_7,10.field_10_8,10.field_10_9,5.field_5_1,5.field_5_2,5.field_5_3,5.field_5_7,5.field_5_4,5.field_5_5,5.field_5_6,6.field_6_1,6.AE_id,6.field_6_6,2.field_2_1,2.field_2_5,2.field_2_9,2.field_2_10,2.field_2_3,2.field_2_6,2.field_2_7,2.field_2_8,BranchInf.BranCod_id,BranchInf.SecCity,BranchInf.field_BranchInf_2,BranchInf.field_BranchInf_3,BranchInf.field_BranchInf_4,Pend.PendingList,Pend.field_Pend_3,Pend.field_Pend_5,4.Product_id,4.Plan_id,4.field_4_6,4.field_4_7,4.field_4_2,4.field_4_3,7.field_7_2,7.field_7_1,7.field_7_3,7.field_7_6,7.field_7_4,7.field_7_5,9.field_9_19,9.field_9_17,9.field_9_2,9.field_9_3,9.field_9_4,9.field_9_16,9.field_9_6,9.field_9_7,9.field_9_8,9.field_9_9,9.field_9_18,9.field_9_1,9.field_9_10,9.field_9_15,9.MemProduct_id,9.MemPlan_id,9.field_9_12,9.field_9_13,11.field_11_1,11.field_11_2,11.field_11_8,11.field_11_3,11.field_11_13,11.field_11_6,11.field_11_5,11.field_11_4,11.field_11_7,11.field_11_9,11.field_11_10,11.field_11_11,11.field_11_12',N'',N'03.WaitHandle',N'照会完成',N'')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'34',N'2',N'26',N'照会审批',N'0',N'0',N'0',N'00',N'',N'5478px',N'543px',N'Pend.PendingList,Pend.field_Pend_3,Pend.field_Pend_5',N'',N'02.WaitHandle',N'审批通过',N'重新提交')
INSERT teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,position_x,position_y,update_section_fields,fill_section_fields,node_alias,approve_alias,reject_alias)  VALUES(@flowId,N'35',N'2',N'28',N'错误控制',N'0',N'0',N'0',N'00',N'',N'7007px',N'2318px',N'SystemFW.field_SystemFW_1',N'',N'07.ErrorHandle',N'',N'')
