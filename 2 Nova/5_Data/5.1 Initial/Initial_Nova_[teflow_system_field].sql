-- 20150428 Justin Bin initial teflow_system field
begin tran
delete from teflow_system_field 
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'company_field', N'Select Company', N'02', NULL, NULL, NULL, 1, 10, N'select org_id as option_value,org_name as option_label from teflow_company  order by org_id', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'flow_org_id', N'改走那个公司的流程？ ', N'02', NULL, NULL, NULL, 1, 10, N'select org_id as option_value,org_name as option_label from teflow_company  order by org_id', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'Approver', N'Approver''s Name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'prj_ld_id', N'Project Leader', N'02', N'', N'', N'', 1, 20, N'select distinct b.staff_code option_value,b.staff_name option_label from tpma_project a,tpma_staffbasic b where a.status<>''10'' and a.prj_ld_id = b.logon_id and b.status=''A'' order by b.staff_name', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'staff_code', N'Staff', N'02', N'', N'', N'', 1, NULL, N'select staff_code option_value,staff_name  option_label from tpma_staffbasic where status=''A''', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'system_id', N'Application Name', N'02', N'', N'', N'', 1, 4, N'select system_id option_value,system_name option_label from teflow_system_owner', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'urgent_level', N'Is Urgent', N'02', N'', N'', N'', 1, 4, N'select urgent_level_id option_value,urgent_level_name option_label from teflow_urgent_define order by urgent_level_id', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'is_exceptional_case', N'Is Exceptional Case', N'02', N'', N'', N'', 1, 4, N'select option_label,option_value from teflow_option_value where field_id=''is_exceptional_case''', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'reference_form', N'Reference Form', N'03', N'', N'', N'', 2, 500, N'select w.request_no option_value, w.request_no option_label from teflow_wkf_process w, teflow_wkf_define d, teflow_form f where w.flow_id=d.flow_id and d.form_system_id=f.form_system_id and submit_staff_code=@staffcode  and f.form_id=@formid', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'account_dc', N'财务上的部门代码 Account DC', N'05', N'', N'', N'', 1, 100, N'select distinct account_dc option_label,account_dc option_value from teflow_finance_budget where org_id=@orgId and department_id=@teamCode', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'company_id', N'Company', N'02', N'', N'', N'', 1, 10, N'select org_id as option_value,org_name as option_label from teflow_company  order by org_id', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'title_id', N'Staff Title', N'02', N'', N'', N'', 1, 6, N'select title_id option_value,abrev option_label from tpma_title where active = ''Y'' order by option_label asc', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'sub_category', N'Detail Category', N'05', NULL, NULL, NULL, 1, 100, N'select sub_cat_name option_label, category_id + ''_'' + sub_cat_id + ''-'' + sub_cat_name option_value from teflow_finance_budget where org_id = @orgId and department_id = @teamCode and category_id = @categoryId', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'cost_company', N'费用承担公司', N'02', NULL, NULL, NULL, 1, 10, N'select org_id as option_value, org_name as option_label from teflow_company   Union select org_id as option_value, org_name as option_label from teflow_company_secondary  ', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'AE_id', N'Servicing AE', N'05', NULL, NULL, NULL, 1, 8, N'SELECT DISTINCT RTRIM(TUser.UserId) option_value , RTRIM(TUser.UserId) +'' - '' + RTRIM(TUser.UserName) option_label FROM @CompassDB..TUSERPROF   TUser, @CompassDB..TUSERSECURITY   TS WHERE TS.UserId = TUser.UserId AND TUser.RcdSts = ''A'' AND TS.RcdSts = ''A''', N'CompassDB')
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'Product_id', N'保险产品', N'05', NULL, NULL, NULL, 1, 5, N'
SELECT DISTINCT a.NOVA_PRODCODE option_value , a.NOVA_PRODCODE_Local option_label 
FROM TNovaProductMapping a
WHERE form_System_id = @formid
', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'Plan_id', N'产品计划', N'05', NULL, NULL, NULL, 1, 3, N'SELECT DISTINCT NOVA_BENPLNCD option_value , NOVA_BENPLNCD_Local option_label FROM TNovaProductMapping WHERE form_System_id = @formid', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'MemProduct_id', N'人员保险产品', N'05', NULL, NULL, NULL, 1, 5, N'SELECT DISTINCT a.NOVA_PRODCODE option_value , a.NOVA_PRODCODE_Local option_label   FROM TNovaProductMapping a where form_System_id = @formid', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'MemPlan_id', N'人员产品计划', N'05', NULL, NULL, NULL, 1, 3, N'SELECT DISTINCT NOVA_BENPLNCD option_value , NOVA_BENPLNCD_Local option_label FROM TNovaProductMapping WHERE form_System_id = @formid', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'BranCod_id', N'Branch Code', N'05', NULL, NULL, NULL, 1, 5, N'select distinct CONVERT(VARCHAR(4),COMPCODE)+BRANCHCODE option_value,BRANCHCODE + '' - ''+BRANCHSHORT option_label from @CompassDB..TCOMPBRANCH ', N'CompassDB')
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'PROVINCE', N'所属省份', N'05', NULL, NULL, NULL, 1, 100, N'select DICTCODE AS option_value, DICTDESCCN as option_label from @CompassDB..TCIRCSYSDICT where DICTTYPE = ''REGIONALISM'' and REMARK1 = ''1''', N'CompassDB')
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'COMPANYNATURE', N'公司性质', N'05', NULL, NULL, NULL, 1, 100, N'select DICTCODE as option_value, DICTDESCCN as option_label from @CompassDB..TCIRCSYSDICT where DICTTYPE = ''COMPANYNATURE''', N'CompassDB')
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'FlexProduct_id', N'保险产品', N'02', NULL, NULL, NULL, 1, 5, N'SELECT DISTINCT NOVA_PRODCODE option_value , NOVA_PRODCODE_Local option_label FROM TNovaProductMapping WHERE PRODCODE IN (''FLAK3'')', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'FlexProductMem_id', N'保险产品', N'02', NULL, NULL, NULL, 1, 5, N'SELECT DISTINCT NOVA_PRODCODE option_value , NOVA_PRODCODE_Local option_label FROM TNovaProductMapping WHERE PRODCODE IN (''FLAK3'')', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'SecCity', N'2end level city', N'05', NULL, NULL, NULL, 1, 6, N'select DISTINCT CONVERT(VARCHAR(6),COUNTYCODE) option_value,BRANCHCODE +'' - '' + COUNTYCODE +'' - ''+COUNTYDESC option_label from @CompassDB..TCOMPBRNCOUNTY', N'CompassDB')
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'OriginalPol', N'关联保单', N'05', NULL, NULL, NULL, 1, 10, N'select * from @CompassDB..tpolicy where 1<>1', N'CompassDB')
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'CITY', N'所属城市', N'05', NULL, NULL, NULL, 1, 100, N'select DICTCODE AS option_value, DICTDESCCN as option_label from @CompassDB..TCIRCSYSDICT where DICTTYPE = ''REGIONALISM'' and REMARK1 = ''2''', N'CompassDB')
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'INDUSTRYCLASS', N'行业类别', N'05', NULL, NULL, NULL, 1, 100, N'select DICTCODE as option_value, DICTDESCCN as option_label from @CompassDB..TCIRCSYSDICT where DICTTYPE = ''INDUSTRYCLASS''', N'CompassDB')
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'DISTRICT', N'所属地区', N'05', NULL, NULL, NULL, 1, 100, N'select DICTCODE AS option_value, DICTDESCCN as option_label from @CompassDB..TCIRCSYSDICT where DICTTYPE = ''REGIONALISM'' and REMARK1 = ''3''', N'CompassDB')
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'REGISTRATIONDOCTYPE', N'注册类型', N'05', NULL, NULL, NULL, 1, 100, N'select DICTCODE as option_value, DICTDESCCN as option_label from @CompassDB..TCIRCSYSDICT where DICTTYPE = ''REGISTRATIONDOCTYPE''', N'CompassDB')
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'CRITTYPE', N'证件类型', N'05', NULL, NULL, NULL, 1, 100, N'SELECT RTRIM(DICTCODE) AS option_value, RTRIM(DICTDESCCN) as option_label 	FROM @CompassDB..TCIRCSYSDICT WHERE DICTTYPE = ''CRITTYPE''   AND COMPCODE = 11 order by DICTCODE', N'CompassDB')
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'OCCUPATION', N'职业代码', N'05', NULL, NULL, NULL, 1, 100, N'SELECT RTRIM(DICTCODE) AS option_value, RTRIM(DICTDESCCN) as option_label 	FROM @CompassDB..TCIRCSYSDICT WHERE DICTTYPE = ''OCCUPATION'' AND COMPCODE = 11 order by DICTCODE', N'CompassDB')
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'PendingList', N'照会', N'02', NULL, NULL, NULL, 1, 100, N'SELECT pendcode option_value, pendcode + ''-''+Pendscope+''-''+pendissue option_label FROM TNOVAPENDINGLIST ORDER BY PendSeq', NULL)
GO
INSERT [dbo].[teflow_system_field] ([field_id], [field_label], [field_type], [src_table_name], [src_id_column], [src_label_column], [column_type], [column_length], [data_sql], [param_list]) VALUES (N'TNovaSDField', N'TNovaSDFieldLst', N'02', NULL, NULL, NULL, 1, 30, N'select FieldName option_value,FieldDesc option_label from TNovaSDFieldLst', NULL)
GO

commit tran