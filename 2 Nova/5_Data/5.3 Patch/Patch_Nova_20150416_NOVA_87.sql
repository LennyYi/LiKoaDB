
/****** Object:  Table [dbo].[TNOVAPendingList]    Script Date: 4/15/2015 11:57:04 AM ******/
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = N'TNOVAPENDINGLIST' AND xtype='U')
 	DROP TABLE [dbo].[TNOVAPendingList]
GO

CREATE TABLE [dbo].[TNOVAPendingList](
	[PendCode]   [varchar](5) NOT NULL PRIMARY KEY,
	[PendScope]  [varchar](50) NULL,
	[PendIssue]  [varchar](200) NULL,
	[PendDesc]   [varchar](1000) NULL,
	[PendRemark] [varchar](1000) NULL,
	[PendSeq]    int
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[teflow_20264_Pend]    Script Date: 4/14/2015 4:11:01 PM ******/
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = N'teflow_20264_Pend' AND xtype='U')
	DROP TABLE [dbo].[teflow_20264_Pend]
GO

CREATE TABLE [dbo].[teflow_20264_Pend](
	[PendingList] [varchar](100) NULL,
	[field_Pend_3] [varchar](500) NULL,
	[field_Pend_5] [varchar](1) NULL,
	[id] [numeric](12, 0) IDENTITY(1,1) NOT NULL,
	[request_no] [varchar](30) NULL
) ON [PRIMARY]

GO
-------------------------------------
----PATCH teflow_wkf_detail start----
-------------------------------------

declare @flowid int

select @flowid = flow_id from teflow_wkf_define where form_system_id = 20264
delete from teflow_wkf_detail where flow_id =  @flowid 

Insert into teflow_wkf_detail ( flow_id, node_id, node_type, pre_node_id, node_name, limited_hours, has_rule, rule_id, approver_group_id, approver_staff_code, position_x, position_y, update_section_fields, fill_section_fields, node_alias, approve_alias, reject_alias )  values ( @flowid,  '24' ,  '4' ,  '23' ,  '生成合同' , 0.00,  '0' , 0,  '00' ,  '' ,  '3816px' ,  '3119px' ,  '' ,  '' ,  '10.Contact' ,  '' ,  ''  ); 
Insert into teflow_wkf_detail ( flow_id, node_id, node_type, pre_node_id, node_name, limited_hours, has_rule, rule_id, approver_group_id, approver_staff_code, position_x, position_y, update_section_fields, fill_section_fields, node_alias, approve_alias, reject_alias )  values ( @flowid,  '0' ,  '' ,  '' ,  'Begin' , 0.00,  '0' , 0,  '' ,  '' ,  '615px' ,  '1456px' ,  '' ,  '' ,  '' ,  '' ,  ''  ); 
Insert into teflow_wkf_detail ( flow_id, node_id, node_type, pre_node_id, node_name, limited_hours, has_rule, rule_id, approver_group_id, approver_staff_code, position_x, position_y, update_section_fields, fill_section_fields, node_alias, approve_alias, reject_alias )  values ( @flowid,  '-1' ,  '' ,  '24' ,  'End' , 0.00,  '0' , 0,  '' ,  '' ,  '5519px' ,  '3129px' ,  '' ,  '' ,  '' ,  '' ,  ''  ); 
Insert into teflow_wkf_detail ( flow_id, node_id, node_type, pre_node_id, node_name, limited_hours, has_rule, rule_id, approver_group_id, approver_staff_code, position_x, position_y, update_section_fields, fill_section_fields, node_alias, approve_alias, reject_alias )  values ( @flowid,  '23' ,  '4' ,  '30' ,  '验证账单支付' , 0.00,  '0' , 0,  '00' ,  '' ,  '2205px' ,  '3119px' ,  '' ,  '' ,  '09.Payment' ,  '' ,  ''  ); 
Insert into teflow_wkf_detail ( flow_id, node_id, node_type, pre_node_id, node_name, limited_hours, has_rule, rule_id, approver_group_id, approver_staff_code, position_x, position_y, update_section_fields, fill_section_fields, node_alias, approve_alias, reject_alias )  values ( @flowid,  '25' ,  '2' ,  '0,31' ,  '信息确认' , 0.00,  '0' , 0,  '00' ,  '' ,  '2349px' ,  '1467px' ,  'SystemFW.field_SystemFW_8' ,  'SystemFW.field_SystemFW_8,SystemFW.field_SystemFW_1' ,  '01.Confirm' ,  '' ,  '重新填写'  ); 
Insert into teflow_wkf_detail ( flow_id, node_id, node_type, pre_node_id, node_name, limited_hours, has_rule, rule_id, approver_group_id, approver_staff_code, position_x, position_y, update_section_fields, fill_section_fields, node_alias, approve_alias, reject_alias )  values ( @flowid,  '26' ,  '2' ,  '25' ,  '系统验证' , 0.00,  '0' , 0,  '' ,  'System001' ,  '4062px' ,  '1097px' ,  'SystemFW.field_SystemFW_1' ,  '' ,  '02.Validation' ,  '' ,  ''  ); 
Insert into teflow_wkf_detail ( flow_id, node_id, node_type, pre_node_id, node_name, limited_hours, has_rule, rule_id, approver_group_id, approver_staff_code, position_x, position_y, update_section_fields, fill_section_fields, node_alias, approve_alias, reject_alias )  values ( @flowid,  '27' ,  '2' ,  '33,26' ,  '数据确认' , 0.00,  '0' , 0,  '00' ,  '' ,  '8208px' ,  '1518px' ,  'SystemFW.field_SystemFW_1,Pend.PendingList,Pend.field_Pend_3,Pend.field_Pend_5' ,  '' ,  '03.DataCM' ,  '' ,  '重新填写'  ); 
Insert into teflow_wkf_detail ( flow_id, node_id, node_type, pre_node_id, node_name, limited_hours, has_rule, rule_id, approver_group_id, approver_staff_code, position_x, position_y, update_section_fields, fill_section_fields, node_alias, approve_alias, reject_alias )  values ( @flowid,  '28' ,  '2' ,  '27' ,  '数据插入' , 0.00,  '0' , 0,  '' ,  'System001' ,  '10557px' ,  '851px' ,  'SystemFW.field_SystemFW_1' ,  '' ,  '04.Insert' ,  '' ,  ''  ); 
Insert into teflow_wkf_detail ( flow_id, node_id, node_type, pre_node_id, node_name, limited_hours, has_rule, rule_id, approver_group_id, approver_staff_code, position_x, position_y, update_section_fields, fill_section_fields, node_alias, approve_alias, reject_alias )  values ( @flowid,  '32' ,  '2' ,  '29,30' ,  '系统支持' , 0.00,  '0' , 0,  '' ,  'C0378' ,  '8320px' ,  '4791px' ,  '' ,  '' ,  '08.ErrorHandle' ,  '' ,  ''  ); 
Insert into teflow_wkf_detail ( flow_id, node_id, node_type, pre_node_id, node_name, limited_hours, has_rule, rule_id, approver_group_id, approver_staff_code, position_x, position_y, update_section_fields, fill_section_fields, node_alias, approve_alias, reject_alias )  values ( @flowid,  '29' ,  '4' ,  '28,32' ,  '正式账单' , 0.00,  '0' , 0,  '' ,  'System001' ,  '12978px' ,  '1662px' ,  '' ,  '' ,  '06.Officail' ,  '' ,  ''  ); 
Insert into teflow_wkf_detail ( flow_id, node_id, node_type, pre_node_id, node_name, limited_hours, has_rule, rule_id, approver_group_id, approver_staff_code, position_x, position_y, update_section_fields, fill_section_fields, node_alias, approve_alias, reject_alias )  values ( @flowid,  '30' ,  '2' ,  '29' ,  '账单报告' , 0.00,  '0' , 0,  '' ,  'System001' ,  '584px' ,  '3108px' ,  'SystemFW.field_SystemFW_1' ,  '' ,  '07.Report' ,  '' ,  ''  ); 
Insert into teflow_wkf_detail ( flow_id, node_id, node_type, pre_node_id, node_name, limited_hours, has_rule, rule_id, approver_group_id, approver_staff_code, position_x, position_y, update_section_fields, fill_section_fields, node_alias, approve_alias, reject_alias )  values ( @flowid,  '31' ,  '2' ,  '26,28,25' ,  '错误控制' , 0.00,  '0' , 0,  '00' ,  '' ,  '779px' ,  '2236px' ,  '01.company_id,02.field_02_6,02.field_02_16,02.field_02_17,02.field_02_26,02.field_02_13,02.field_02_34,02.field_02_33,02.field_02_8,02.field_02_9,02.field_02_18,02.field_02_31,02.field_02_23,02.field_02_25,02.field_02_19,02.field_02_20,02.field_02_21,02.field_02_22,02.field_02_24,02.OriginalPol,02.field_02_27,02.field_02_30,02.field_02_28,02.field_02_32,5.field_5_1,5.field_5_2,5.field_5_3,5.field_5_7,5.field_5_4,5.field_5_5,5.field_5_6,6.field_6_1,6.AE_id,6.field_6_6,2.field_2_1,2.field_2_5,2.field_2_9,2.field_2_10,2.field_2_3,2.field_2_6,2.field_2_7,2.field_2_8,BranchInf.BranCod_id,BranchInf.SecCity,BranchInf.field_BranchInf_2,BranchInf.field_BranchInf_3,BranchInf.field_BranchInf_4,SystemFW.field_SystemFW_1,4.Product_id,4.Plan_id,4.field_4_6,4.field_4_7,4.field_4_2,4.field_4_3,7.field_7_2,7.field_7_1,7.field_7_3,7.field_7_4,7.field_7_5,9.field_9_19,9.field_9_17,9.field_9_2,9.field_9_3,9.field_9_4,9.field_9_16,9.field_9_6,9.field_9_7,9.field_9_8,9.field_9_9,9.field_9_18,9.field_9_1,9.field_9_10,9.field_9_15,9.MemProduct_id,9.MemPlan_id,9.field_9_12,9.field_9_13,11.field_11_1,11.field_11_2,11.field_11_8,11.field_11_3,11.field_11_13,11.field_11_6,11.field_11_5,11.field_11_4,11.field_11_7,11.field_11_9,11.field_11_10,11.field_11_11,11.field_11_12' ,  '' ,  '05.ErrorHandle' ,  '' ,  ''  ); 
Insert into teflow_wkf_detail ( flow_id, node_id, node_type, pre_node_id, node_name, limited_hours, has_rule, rule_id, approver_group_id, approver_staff_code, position_x, position_y, update_section_fields, fill_section_fields, node_alias, approve_alias, reject_alias )  values ( @flowid,  '33' ,  '2' ,  '26' ,  '等待照会' , 0.00,  '0' , 0,  '00' ,  '' ,  '6156px' ,  '605px' ,  '02.field_02_6,02.field_02_16,02.field_02_17,02.field_02_26,02.field_02_13,02.field_02_34,02.field_02_33,02.field_02_8,02.field_02_9,02.field_02_18,02.field_02_31,02.field_02_23,02.field_02_25,02.field_02_19,02.field_02_20,02.field_02_21,02.field_02_22,02.field_02_24,02.OriginalPol,02.field_02_27,02.field_02_30,02.field_02_28,02.field_02_32,5.field_5_1,5.field_5_2,5.field_5_3,5.field_5_7,5.field_5_4,5.field_5_5,5.field_5_6,6.field_6_1,6.AE_id,6.field_6_6,2.field_2_1,2.field_2_5,2.field_2_9,2.field_2_10,2.field_2_3,2.field_2_6,2.field_2_7,2.field_2_8,BranchInf.BranCod_id,BranchInf.SecCity,BranchInf.field_BranchInf_2,BranchInf.field_BranchInf_3,BranchInf.field_BranchInf_4,Pend.PendingList,Pend.field_Pend_3,Pend.field_Pend_5,4.Product_id,4.Plan_id,4.field_4_6,4.field_4_7,4.field_4_2,4.field_4_3,7.field_7_2,7.field_7_5,9.field_9_17,9.field_9_2,9.field_9_3,9.field_9_4,9.field_9_16,9.field_9_6,9.field_9_7,9.field_9_8,9.field_9_9,9.field_9_18,9.field_9_1,9.field_9_10,9.field_9_15,9.MemProduct_id,9.MemPlan_id,9.field_9_12,9.field_9_13,11.field_11_1,11.field_11_2,11.field_11_8,11.field_11_3,11.field_11_13,11.field_11_6,11.field_11_5,11.field_11_4,11.field_11_7,11.field_11_9,11.field_11_10,11.field_11_11,11.field_11_12' ,  '' ,  '03.WaitHandle' ,  '照会完成' ,  ''  ); 


-------------------------------------
----PATCH teflow_wkf_detail_rule start----
-------------------------------------

delete from teflow_wkf_detail_rule where flow_id =  @flowid 


Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '25' ,  '33' ,  'Pend' ,  'field_Pend_3' ,  '<>' ,  '''''' ,  '01' ,  '''''' ,  '照会列表.照会内容' ,  '1' ,  'select teflow_20264_Pend.request_no from  teflow_20264_Pend where 1=1  and ( teflow_20264_Pend.field_Pend_3<>  ''''''''   )' ,  '2'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '26' ,  '33' ,  'Pend' ,  'field_Pend_3' ,  '<>' ,  '''''' ,  '01' ,  '''''' ,  '照会列表.照会内容' ,  '1' ,  'select teflow_20264_Pend.request_no from  teflow_20264_Pend where 1=1  and ( teflow_20264_Pend.field_Pend_3<>  ''''''''   )' ,  '2'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '26' ,  '31' ,  'SystemFW' ,  'field_SystemFW_1' ,  'like' ,  'E' ,  '01' ,  'E' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_20264_SystemFW.request_no from  teflow_20264_SystemFW, teflow_20264_Pend where 1=1  and teflow_20264_SystemFW.request_no=teflow_20264_Pend.request_no  and ( teflow_20264_SystemFW.field_SystemFW_1 like ''%E%''  and  teflow_20264_Pend.field_Pend_3=  ''''''''   )' ,  '2'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '26' ,  '31' ,  'Pend' ,  'field_Pend_3' ,  '=' ,  '''''' ,  '01' ,  '''''' ,  '照会列表.照会内容' ,  '1' ,  'select teflow_20264_SystemFW.request_no from  teflow_20264_SystemFW, teflow_20264_Pend where 1=1  and teflow_20264_SystemFW.request_no=teflow_20264_Pend.request_no  and ( teflow_20264_SystemFW.field_SystemFW_1 like ''%E%''  and  teflow_20264_Pend.field_Pend_3=  ''''''''   )' ,  '2'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '10' ,  '2' ,  'SystemFW' ,  'field_SystemFW_1' ,  '=' ,  'E001' ,  '01' ,  'E001' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E001''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '10' ,  '4' ,  'SystemFW' ,  'field_SystemFW_1' ,  '=' ,  'E002' ,  '01' ,  'E002' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E002''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '10' ,  '11' ,  'SystemFW' ,  'field_SystemFW_1' ,  '=' ,  'S001' ,  '01' ,  'S001' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''S001''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '11' ,  '3' ,  'SystemFW' ,  'field_SystemFW_1' ,  '=' ,  'E004' ,  '01' ,  'E004' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E004''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '5' ,  '6' ,  'SystemFW' ,  'field_SystemFW_1' ,  '=' ,  'E004' ,  '01' ,  'E004' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E004''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '11' ,  '5' ,  'SystemFW' ,  'field_SystemFW_1' ,  '=' ,  'S001' ,  '01' ,  'S001' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''S001''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '5' ,  '7' ,  'SystemFW' ,  'field_SystemFW_1' ,  '=' ,  'E005' ,  '01' ,  'E005' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E005''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '5' ,  '8' ,  'SystemFW' ,  'field_SystemFW_1' ,  '=' ,  'S001' ,  '01' ,  'S001' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''S001''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '19' ,  '16' ,  'SystemFW' ,  'field_SystemFW_1' ,  '=' ,  'E002' ,  '01' ,  'E002' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E002''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '13' ,  '19' ,  'SystemFW' ,  'field_SystemFW_1' ,  'no' ,  'E' ,  '01' ,  'E' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1not like  ''E''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '17' ,  '18' ,  'SystemFW' ,  'field_SystemFW_1' ,  '=' ,  'E004' ,  '01' ,  'E004' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E004''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '28' ,  '31' ,  'SystemFW' ,  'field_SystemFW_1' ,  'like' ,  'E' ,  '01' ,  'E' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_20264_SystemFW.request_no from  teflow_20264_SystemFW where 1=1  and ( teflow_20264_SystemFW.field_SystemFW_1 like ''%E%''   )' ,  '2'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '20' ,  '21' ,  'SystemFW' ,  'field_SystemFW_1' ,  '=' ,  'E005' ,  '01' ,  'E005' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E005''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '20' ,  '22' ,  'SystemFW' ,  'field_SystemFW_1' ,  '=' ,  'E006' ,  '01' ,  'E006' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E006''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '18' ,  '15' ,  'SystemFW' ,  'field_SystemFW_1' ,  'like' ,  'E' ,  '01' ,  'E' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1 like ''%E%''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '30' ,  '32' ,  'SystemFW' ,  'field_SystemFW_1' ,  'like' ,  'E' ,  '01' ,  'E' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1 like ''%E%''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '25' ,  '31' ,  'SystemFW' ,  'field_SystemFW_1' ,  'like' ,  'E' ,  '01' ,  'E' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_20264_SystemFW.request_no from  teflow_20264_SystemFW where 1=1  and ( teflow_20264_SystemFW.field_SystemFW_1 like ''%E%''   )' ,  '2'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '29' ,  '32' ,  'SystemFW' ,  'field_SystemFW_1' ,  'like' ,  'E' ,  '01' ,  'E' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1 like ''%E%''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '19' ,  '15' ,  'SystemFW' ,  'field_SystemFW_1' ,  'like' ,  'E' ,  '01' ,  'E' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1 like ''%E%''   )' ,  '1'  ); 
Insert into teflow_wkf_detail_rule ( flow_id, begin_node_id, end_node_id, section_id, field_id, compare_type, compare_value, logic_type, compare_label, field_label, is_function, sub_sql, condition_type )  values ( @flowid,  '26' ,  '31' ,  'SystemFW' ,  'field_SystemFW_1' ,  '=' ,  'E001' ,  '02' ,  'E001' ,  '系统流程控制.ErrorCode' ,  '1' ,  'select teflow_20264_SystemFW.request_no from  teflow_20264_SystemFW, teflow_20264_Pend where 1=1  and teflow_20264_SystemFW.request_no=teflow_20264_Pend.request_no  and ( teflow_20264_SystemFW.field_SystemFW_1 like ''%E%''  and  teflow_20264_Pend.field_Pend_3=  ''''''''  and  teflow_20264_SystemFW.field_SystemFW_1=  ''E001''   )' ,  '2'  ); 

go


-------------------------------------
----PATCH teflow_form_section start----
-------------------------------------
delete from teflow_form_section where form_system_id = 20264 and section_id =  'Pend'  and section_type =  '01'  and section_remark =  '照会列表'  and table_name =  'teflow_20264_Pend'  and ORDER_ID =  '93' ;
Insert into teflow_form_section ( form_system_id, section_id, section_type, section_remark, table_name, ORDER_ID )  values ( 20264,  'Pend' ,  '01' ,  '照会列表' ,  'teflow_20264_Pend' ,  '93'  ); 

-------------------------------------
----teflow_form_section_field start----
-------------------------------------

delete from teflow_form_section_field where form_system_id = 20264 and section_id = 'Pend';

Insert into teflow_form_section_field ( form_system_id, section_id, field_id, field_label, field_type, is_required, data_type, field_length, source_type, source_sql, order_id, decimal_digits, high_level, is_money, is_singlerow, controls_width, controls_height, field_comments, comment_content, is_readonly, event_click, event_dbclick, event_onfocus, event_onblur, event_onchange, default_value, column_width )  values ( 20264,  'Pend' ,  'field_Pend_3' ,  '照会内容' , 1, -1, 1, 500, 0,  '' , 3, 0, -1, -1, -1, 500, 0,  '' ,  '' , -1,  '' ,  '' ,  '' ,  '' ,  '' ,  '' , 25 ); 
Insert into teflow_form_section_field ( form_system_id, section_id, field_id, field_label, field_type, is_required, data_type, field_length, source_type, source_sql, order_id, decimal_digits, high_level, is_money, is_singlerow, controls_width, controls_height, field_comments, comment_content, is_readonly, event_click, event_dbclick, event_onfocus, event_onblur, event_onchange, default_value, column_width )  values ( 20264,  'Pend' ,  'field_Pend_5' ,  '是否完成' , 6, -1, 1, 1, 0,  '' , 5, 0, -1, -1, -1, 0, 0,  '' ,  '' , -1,  '' ,  '' ,  '' ,  '' ,  '' ,  '' , 10 ); 
Insert into teflow_form_section_field ( form_system_id, section_id, field_id, field_label, field_type, is_required, data_type, field_length, source_type, source_sql, order_id, decimal_digits, high_level, is_money, is_singlerow, controls_width, controls_height, field_comments, comment_content, is_readonly, event_click, event_dbclick, event_onfocus, event_onblur, event_onchange, default_value, column_width )  values ( 20264,  'Pend' ,  'PendingList' ,  '照会' , 7, -1, 1, 100, 0,  '' , 0, 0, -1, 0, -1, 0, 0,  '' ,  '' , -1,  '' ,  '' ,  '' ,  '' ,  '' ,  '200' , 20 ); 


-------------------------------------
----teflow_system_field start----
-------------------------------------

delete from teflow_system_field where field_id =  'PendingList'  and field_label =  '照会'  and field_type =  '02' ;
Insert into teflow_system_field ( field_id, field_label, field_type, src_table_name, src_id_column, src_label_column, column_type, column_length, data_sql, param_list )  values (  'PendingList' ,  '照会' ,  '02' , NULL, NULL, NULL, 1, 100,  'SELECT pendcode option_value, pendcode + ''-''+Pendscope+''-''+pendissue option_label FROM TNOVAPENDINGLIST ORDER BY PendSeq' , NULL ); 


-------------------------------------
----teflow_system_field start----
-------------------------------------

DELETE FROM TNOVAPENDINGLIST;

Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N01' ,  '团体证明文件' ,  '没有递交' ,  '请提交营业执照复印件并加盖公章。' ,  '' , 1 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N02' ,  '团体证明文件' ,  '团体证明文件不符合要求' ,  '请提供XXXX文件。' ,  '' , 2 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N03' ,  '团体证明文件' ,  '没有盖章' ,  '请重新递交营业执照复印件并加盖公章。' ,  '需发复印件' , 3 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N04' ,  '团体证明文件' ,  '文件与网上记录不符' ,  '请递交最新版本的营业执照复印件，并加盖公章。' ,  '' , 4 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N05' ,  '团体证明文件' ,  '名称与公章不符' ,  '公章名称与营业执照上的企业名称不符，请重新递交名称一致的投保资料。' ,  '' , 5 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N06' ,  '投保单' ,        '投保人名称与公章不符' ,  '投保人名称与公章不一致，请重填投保单并加盖公章（附复印件）。' ,  '需发复印件' , 6 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N07' ,  '投保单' ,        '等候期' ,  '投保单上等候期为N个月，请确认被保险人是否需要等候N个月后再生效，如是，请填写劳动合同生效日；如否，请在照会上回复“等候期为零”并加盖公章确认。' ,  '' , 7 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N08' ,  '投保单' ,        '未全员投保' ,  '请增加投保人数以达到核保要求。' ,  '' , 8 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N09' ,  '投保单' ,        '银行帐号漏填' ,  '请在照会上回复客户付费账户的开户银行、开户支行及帐号并加盖公章确认。' ,  '' , 9 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N10' ,  '投保单' ,        '银行帐号支行名称漏填' ,  '请在照会上回复具体开户支行信息并加盖公章确认。' ,  '' , 10 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N11' ,  '投保单' ,        '计划选择错误1' ,  '投保单上不同计划间隔违反“+2原则”，请重新填写投保单和红表以确认计划。' ,  '' , 11 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N12' ,  '投保单' ,        '计划选择错误2' ,  '3－4级员工所选计划保额应小于或等于1－2级员工，请重新填写投保单和红表以确认计划。' ,  '' , 12 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N13' ,  '投保单' ,        '职业等级选择错误' ,  '请详述“XXX”具体职务内容，使用何种工具，如何操作，待照会回复后再确认其职业等级和保险费。' ,  '' , 13 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N14' ,  '投保单' ,        '超可承保范围' ,  'XXX工种超出可承保范围，需作拒保处理，请回复照会确认。' ,  '' , 14 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N15' ,  '投保单' ,        '每个计划不足5人' ,  '投保不足5人，请重组计划（投保单、红表均需重填并盖章）。' ,  '' , 15 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N16' ,  '投保单' ,        '无授权代表签名' ,  '投保单上无授权代表签名，请在复印件上补上授权代表签名，并加盖公章（修改处和原有章处都需盖）。' ,  '需发复印件' , 16 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N17' ,  '投保单' ,        '漏填XX项目' ,  '投保单上漏填XX项目，请在照会上补充回复。' ,  '涉及具体问题具体分析' , 17 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N18' ,  '投保单' ,        '健康告知漏填' ,  '投保单上健康告知漏填，请在投保单复印件上补充填写，并在盖章处补盖公章。' ,  '需发复印件' , 18 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N19' ,  '投保单' ,        '保费不足' ,  '新单不足保费xx元，请补缴后持相关付款凭证（或支票）与照会一起至出纳台报账。' ,  '' , 19 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N20' ,  '投保单' ,        '重新投保欠公函' ,  '此单位原保单终止未满三个月，请提供公函说明重新投保原因。' ,  '' , 20 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N21' ,  '投保单' ,        '投保单上有明显涂改处' ,  '投保单"xxx"项有明显涂改，请重填投保单。' ,  '' , 21 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N25' ,  '委托缴费' ,      '漏交机密报告书' ,  '请提供新版机密报告书。' ,  '' , 22 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N22' ,  '委托缴费' ,      '机密报告书漏填XXX项' ,  '机密报告书上XXX项漏填，请重填新版机密报告。' ,  '' , 23 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N23' ,  '委托缴费' ,      '欠特别申请/关系证明原件' ,  '欠委托缴费的特别申请/关系证明原件，请补交' ,  '' , 24 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'N24' ,  '委托缴费' ,      '特别申请/关系证明填写不完整' ,  '委托缴费上的特别申请欠被委托人签署。' ,  '' , 25 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P01' ,  '变更' ,          '旧版表格' ,  '使用了旧版红表、旧版黄表和旧版蓝表，本次暂不操作，请重新提交该批人员的新版表格（版本号11/08），并加盖公章。' ,  '' , 101 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P02' ,  '变更' ,          '身份证号码有误' ,  '新增员工（XXX）的身份证号码有误，请在照会回复处提供该员工的有效身份证号码。' ,  '' , 102 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P03' ,  '变更' ,          '传真显示不清' ,  '传真件显示不清，请重新传真，并在表格附注栏上注明：“回复照会”。' ,  '' , 103 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P04' ,  '变更' ,          '名称不符' ,  '保单编号对应的公司名称与表格上的单位公章不符，请确认该客户的保单编号和公司名称，并重新递交申请表格。' ,  '' , 104 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P05' ,  '变更' ,          '周年日后变更' ,  '客户周年日（XXXX/XX/XX）到期未完成续保，待完成续保后才能操作此批人员变更；若已完成续保手续，请回复照会说明：“已于X月X日递交续保保费”。' ,  '' , 105 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P06' ,  '变更' ,          '其他单在保' ,  '新增员工（XXX）尚于AIA其它保单在保，需在原投保记录终止后方可新增。若照会发出30天内原投保记录在系统终止，则自动加入，请通知被保险人尽快处理原投保记录终止事宜。' ,  '需确认ID完全相同' , 106 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P07' ,  '变更' ,          '退费账户不符（对公）' ,  '由于收款人名称与收款帐号不符，此次退费未成功，请递交团险合同变更申请表并在D项目处填写正确的收款人帐号。' ,  '' , 107 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P08' ,  '变更' ,          '退费账户不符（私人账户）' ,  '由于收款人名称与收款帐号不符，此次退费未成功，请递交团险合同变更申请表并在D项目处填写正确的收款人名称，开户银行和开户帐号。同时递交《个人帐户支付团险保费特别申请》、《团险第三方委托付费业务营销员声明》做团险特批。' ,  '' , 108 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P09' ,  '变更' ,          '中途终止合同没日期或缺少资料' ,  '保单中途终止，请提供具体终止日期并提交营业执照复印件和旧合同。' ,  '' , 109 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P10' ,  '变更' ,          '合同变更申请表欠公章和签名' ,  '请重新提交盖章和签名后的申请表' ,  '' , 110 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P11' ,  '变更' ,          '职位和系统投保计划不符' ,  '员工"xxx"的职位"xxx"与系统投保计划不符，系统显示，该职位对应的投保计划为计划X，请在照会回复处确认。' ,  '' , 111 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P12' ,  '变更' ,          '有无医保' ,  '系统只有/无医保计划，请在照会回复处确认新增员工xxx是否拥有医保。' ,  '' , 112 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P13' ,  '变更' ,          '漏填医保' ,  '员工XXX漏填医保状态，请在照会回复处确认新增员工xxx是否拥有医保。' ,  '' , 113 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P14' ,  '变更' ,          '表格公章不清' ,  '新增/终止员工“XXX”等所在的页面公章不清，请重新提交已盖清晰公章的表格，并在表格附注栏上注明：“回复照会”。' ,  '' , 114 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P15' ,  '变更' ,          '表格漏盖公章' ,  '新增/终止员工“XXX”等所在的页面漏盖公章，请重新提交已盖公章的表格，并在表格附注栏上注明：“回复照会”。' ,  '' , 115 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P17' ,  '变更' ,          '终止查无此人' ,  '系统查无终止员工（xxx），但见（xxx）在保，请在照会回复处确认终止员工姓名。。' ,  '' , 116 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P18' ,  '变更' ,          '传真申请缺签名' ,  '该单于2012-X-XX递交的《传真风险确认书》漏填授权代表签署，无法开通传真变更。请重新提交《传真风险确认书》。' ,  '' , 117 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P19' ,  '变更' ,          '红表漏填职务或职务描述不清晰' ,  '请在照会回复处详述员工“XXX”的具体职务内容，使用何种工具，如何操作。' ,  '' , 118 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P20' ,  '变更' ,          '变更帐号' ,  '单位账号改为私人账号，需提供银行开具的单位账户注销证明复印件。若无法提供，只能以原对公帐户支付保费。' ,  '' , 119 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P21' ,  '变更' ,          '手写体不清晰，无法辨认' ,  '提交资料中所填写的“XXX”不清晰，请在照会回复处用正楷字体回复确认。' ,  'XXX指代：不清晰的人名、身份证号或其他信息' , 120 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P22' ,  '变更' ,          '个人账户变更缺资料' ,  '请补充提供《团险合同变更申请表》/《个人帐户支付团险保费特别申请》/《团险第三方委托付费业务营销员声明》' ,  '' , 121 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P23' ,  '变更' ,          '逾期照会' ,  '您于X年X月X日递交的红表/蓝表/黄表逾期未回复照会，该批员工变更申请无效。如需操作，请重新递交资料。' ,  '' , 122 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P24' ,  '变更' ,          '红表错填计划' ,  '系统显示客户只投保了计划A和B，但员工"xxx"所投保的是计划X，无法操作。如计划填写错误，请在照会回复处确认该员工应选择的计划。' ,  '' , 123 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P25' ,  '变更' ,          '错误章' ,  '“业务专用章”无法律效力，请重新递交盖公章或合同专用章的新增/终止员工XXX、XXX的申请表。' ,  '' , 124 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P26' ,  '变更' ,          '网站生僻字' ,  '由于员工姓名中有生僻字，本次通过网站提交的申请上无法显示员工姓名，请回复照会确认本次申请终止的员工姓名是否为“杨颖喆”？' ,  '' , 125 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P27' ,  '变更' ,          '健康告知上身高/体重信息、健康问题漏勾选' ,  '新增员工XXX黄表上XX漏填写，请重新递交黄表或者在复印件上修改后盖回公章（修改处和原有章处都需盖）。。' ,  '' , 126 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P28' ,  '变更' ,          '健康告知上身高/体重比例超出可承保范围' ,  '新增员工XXX黄表上身高/体重（xxcm、xxkg）比例超出可承保范围，需作拒保处理，请在照会回复处确认。如信息提供有误，请递交个人修正书。' ,  '' , 127 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P29' ,  '变更' ,          '非身份证件投保' ,  '请提供新增员工XXX的护照/台胞证复印件等，与照会一起交回。' ,  '' , 128 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P30' ,  '变更' ,          '被保险人超出承保年龄' ,  '员工XXX年龄超出可承保范围，需作拒保处理。请在照会回复处确认该员工拒保。' ,  '' , 129 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'P31' ,  '变更' ,          '已经在保人员' ,  '新增员工（XXX）已在本单承保，本次无需操作。' ,  '只在红表上注明，不会再单独发照会。' , 130 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'Z01' ,  '其他事项' ,      '参保人员' ,  '参保人员信息有黑名单问题' ,  '' , 901 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'Z02' ,  '其他事项' ,      '参保人员' ,  '参保人员信息有超龄问题' ,  '' , 902 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'Z03' ,  '其他事项' ,      '参保人员' ,  '参保人员信息有重复投保问题' ,  '' , 903 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'Z04' ,  '其他事项' ,      '参保人员' ,  '参保人员信息有无社保问题' ,  '' , 904 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'Z05' ,  '其他事项' ,      '参保人员' ,  '参保人员信息有重复投保问题（NOVA）' ,  '' , 905 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'Z06' ,  '其他事项' ,      '参保人员' ,  '参保人员被保险编号有重复投保问题（NOVA）' ,  '' , 906 ); 
Insert into TNOVAPENDINGLIST ( PendCode, PendScope, PendIssue, PendDesc, PendRemark, PendSeq )  values (  'Z99' ,  '其他事项' ,      '' ,  '' ,  '' , 999 ); 

-------------------------------------
----teflow_field_basedata start----
-------------------------------------

delete from teflow_base_data_master where master_id = 10210;
delete from teflow_base_data_detail where master_id = 10210;

set IDENTITY_INSERT [teflow_base_data_master] on;
insert into teflow_base_data_master (master_id, field_name, type_code) values (10210, 'Complete', '01');
insert into teflow_base_data_detail values (10210, 'Y', '完成', '');

set IDENTITY_INSERT [teflow_base_data_master] off;


delete from teflow_field_basedata
where form_system_id = 20264
and field_id = 'field_Pend_5';

insert into teflow_field_basedata values (10210, 20264, 'Pend', 'field_Pend_5');

-------------------------------------
----PATCH END----
-------------------------------------
