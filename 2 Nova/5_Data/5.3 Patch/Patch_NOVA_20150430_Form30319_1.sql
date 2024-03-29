--FORM

Declare @idform int;
SET IDENTITY_INSERT [teflow_form] ON
DELETE FROM teflow_form WHERE form_system_id = 30319
INSERT INTO [teflow_form] ([form_system_id],[form_id],[form_name],[form_type],[form_subtype],[form_description],[status],[create_date],[action_type],[action_message],[org_id],[pre_validation_url],[after_save_url],[Form_image])VALUES(30319,'FlexSZ4_NBForm','友邦保险团体保险计划(福乐安康4.0)投保单','01','','深圳友邦保险团体保险计划(福乐安康4.0)投保单','0','Apr 27 2015  4:23:20:840PM','02','','Z07009','','','FlexPackage.png')
SET IDENTITY_INSERT [teflow_form] OFF

Declare @idformsystem int;
DELETE FROM teflow_form_section WHERE form_system_id = 30319
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
INSERT INTO [teflow_form_section] ([form_system_id],[section_id],[section_type],[section_remark],[table_name],[ORDER_ID],[section_url],[export_excel],[teflow_form_proce])VALUES(@idformsystem,'01','03','基本信息','teflow_'+convert(varchar(10), @idformsystem)+'_01','0','','','')
INSERT INTO [teflow_form_section] ([form_system_id],[section_id],[section_type],[section_remark],[table_name],[ORDER_ID],[section_url],[export_excel],[teflow_form_proce])VALUES(@idformsystem,'02','02','投保人信息','teflow_'+convert(varchar(10), @idformsystem)+'_02','1','','','')
INSERT INTO [teflow_form_section] ([form_system_id],[section_id],[section_type],[section_remark],[table_name],[ORDER_ID],[section_url],[export_excel],[teflow_form_proce])VALUES(@idformsystem,'10','02','账单信息','teflow_'+convert(varchar(10), @idformsystem)+'_10','92','','','')
INSERT INTO [teflow_form_section] ([form_system_id],[section_id],[section_type],[section_remark],[table_name],[ORDER_ID],[section_url],[export_excel],[teflow_form_proce])VALUES(@idformsystem,'11','01','分支机构信息(如无分支结构, 无须填写)','teflow_'+convert(varchar(10), @idformsystem)+'_11','3','','','')
INSERT INTO [teflow_form_section] ([form_system_id],[section_id],[section_type],[section_remark],[table_name],[ORDER_ID],[section_url],[export_excel],[teflow_form_proce])VALUES(@idformsystem,'2','02','付费方式及授权银行资料','teflow_'+convert(varchar(10), @idformsystem)+'_2','2','','','')
INSERT INTO [teflow_form_section] ([form_system_id],[section_id],[section_type],[section_remark],[table_name],[ORDER_ID],[section_url],[export_excel],[teflow_form_proce])VALUES(@idformsystem,'4','01','计划选择','teflow_'+convert(varchar(10), @idformsystem)+'_4','5','','','')
INSERT INTO [teflow_form_section] ([form_system_id],[section_id],[section_type],[section_remark],[table_name],[ORDER_ID],[section_url],[export_excel],[teflow_form_proce])VALUES(@idformsystem,'5','02','其他告知事项','teflow_'+convert(varchar(10), @idformsystem)+'_5','6','','','')
INSERT INTO [teflow_form_section] ([form_system_id],[section_id],[section_type],[section_remark],[table_name],[ORDER_ID],[section_url],[export_excel],[teflow_form_proce])VALUES(@idformsystem,'6','02','销售信息','teflow_'+convert(varchar(10), @idformsystem)+'_6','7','','','')
INSERT INTO [teflow_form_section] ([form_system_id],[section_id],[section_type],[section_remark],[table_name],[ORDER_ID],[section_url],[export_excel],[teflow_form_proce])VALUES(@idformsystem,'7','01','销售营销员','teflow_'+convert(varchar(10), @idformsystem)+'_7','8','','','')
INSERT INTO [teflow_form_section] ([form_system_id],[section_id],[section_type],[section_remark],[table_name],[ORDER_ID],[section_url],[export_excel],[teflow_form_proce])VALUES(@idformsystem,'9','01','人员信息','teflow_'+convert(varchar(10), @idformsystem)+'_9','91','','','')
INSERT INTO [teflow_form_section] ([form_system_id],[section_id],[section_type],[section_remark],[table_name],[ORDER_ID],[section_url],[export_excel],[teflow_form_proce])VALUES(@idformsystem,'BranchInf','02','营管处信息','teflow_'+convert(varchar(10), @idformsystem)+'_BranchInf','9','','','')
INSERT INTO [teflow_form_section] ([form_system_id],[section_id],[section_type],[section_remark],[table_name],[ORDER_ID],[section_url],[export_excel],[teflow_form_proce])VALUES(@idformsystem,'SystemFW','02','系统流程控制','teflow_'+convert(varchar(10), @idformsystem)+'_SystemFW','93','','','')
go

Declare @idformsystem int;
DELETE FROM teflow_form_section_field WHERE form_system_id = 30319
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'01','company_id','Company',10,0,1,10,0,'',-4,0,-1,0,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'01','request_date','Request Date',10,0,2,20,0,'',-1,0,-1,0,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'01','request_no','Request No',10,0,1,30,0,'',-6,0,-1,0,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'01','request_staff_code','Requester''s Name',10,0,1,20,0,'',-2,0,-1,0,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'01','submit_staff_code','Submitted By',10,0,1,20,0,'',-5,0,-1,0,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'01','team_code','Requester''s Team',10,0,1,20,0,'',-3,0,-1,0,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_13','保险合同生效日期',3,0,2,10,0,'',4,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_16','投保人编号',1,-1,1,5,0,'',1,0,-1,-1,-1,5,0,'','',1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_17','投保人名称',1,0,1,120,0,'',2,0,-1,-1,-1,200,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_18','邮编',1,-1,1,10,0,'',8,0,-1,-1,-1,10,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_19','联系人',1,0,1,80,0,'',12,0,-1,-1,-1,80,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_20','联系电话',1,0,1,32,0,'',13,0,-1,-1,-1,32,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_21','电子邮箱',1,-1,1,30,0,'',14,0,-1,-1,-1,30,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_22','分支机构',1,-1,1,3,0,'',15,0,-1,-1,-1,130,0,'','',-1,'','','','','','100',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_23','团体证件号码',1,-1,1,15,0,'',10,0,-1,-1,-1,15,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_24','等候期(日)',1,-1,1,3,0,'',16,0,-1,-1,-1,3,0,'','',-1,'','','','','','0',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_25','联系人身份证/护照',1,0,1,40,0,'',11,0,-1,-1,-1,150,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_26','投保人别名',1,-1,1,120,0,'',3,0,-1,-1,-1,200,0,'','',-1,'asdsdd','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_27','分公司名',4,0,1,5,0,'',20,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_28','域帐号',1,-1,1,7,0,'',22,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_30','反洗钱风险等级',4,-1,1,50,0,'',21,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_31','团体证件类型',4,-1,1,3,0,'',9,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_32','Team Code',1,-1,1,3,0,'',23,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_33','Renewal Indicator',4,-1,1,1,0,'',5,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_34','保险合同提交日',3,-1,2,10,0,'',4,0,-1,-1,-1,20,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_6','保险合同编号',1,0,1,10,0,'',0,0,1,-1,-1,10,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_8','SIC code',4,0,1,3,0,'',6,0,-1,-1,-1,0,0,'','',-1,'','','','','','999',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','field_02_9','地址',1,0,1,400,0,'',7,0,-1,-1,-1,300,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'02','OriginalPol','关联保单',7,-1,1,10,0,'',19,0,-1,0,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'10','field_10_1','保险费总计',5,-1,3,10,0,'',0,0,1,-1,-1,0,0,'','',1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'10','field_10_2','计费起始日期',1,-1,1,10,0,'',2,0,-1,-1,-1,0,0,'','',1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'10','field_10_3','帐单生成日',1,-1,1,10,0,'',4,0,-1,-1,-1,0,0,'','',1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'10','field_10_4','计费终止日期',1,-1,1,10,0,'',3,0,-1,-1,-1,0,0,'','',1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'10','field_10_5','账单编号',1,-1,1,10,0,'',5,0,-1,-1,-1,10,0,'','',1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'10','field_10_6','保险费佣金',5,-1,3,10,0,'',1,2,1,-1,-1,0,0,'','',1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'10','field_10_7','人员总数',5,-1,3,10,0,'',6,0,1,-1,-1,10,0,'','',1,'','','','','','0',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'11','field_11_1','分支机构编码',1,-1,1,3,0,'',1,0,-1,-1,-1,51,0,'','',-1,'','','','','','',5)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'11','field_11_10','授权银行分行名称',1,-1,1,100,0,'',81,0,-1,-1,-1,0,0,'','',-1,'','','','','','',7)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'11','field_11_11','授权银行账号',1,-1,1,80,0,'',82,0,-1,-1,-1,0,0,'','',-1,'','','','','','',10)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'11','field_11_12','省市',4,-1,1,5,0,'',84,0,-1,-1,-1,0,0,'','',-1,'','','','','','',10)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'11','field_11_13','邮政编码',1,-1,1,10,0,'',3,0,-1,-1,-1,0,0,'','',-1,'','','','','','',3)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'11','field_11_2','分支机构名称',1,-1,1,120,0,'',2,0,-1,-1,-1,120,0,'','',-1,'','','','','','',9)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'11','field_11_3','分支机构地址',1,-1,1,300,0,'',3,0,-1,-1,-1,120,0,'','',-1,'','','','','','',9)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'11','field_11_4','分支机构联系电话',1,-1,1,32,0,'',6,0,-1,-1,-1,15,0,'','',-1,'','','','','','',5)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'11','field_11_5','联系人身份证/护照',1,-1,1,40,0,'',5,0,-1,-1,-1,40,0,'','',-1,'','','','','','',10)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'11','field_11_6','联系人姓名',1,-1,1,80,0,'',4,0,-1,-1,-1,10,0,'','',-1,'','','','','','',5)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'11','field_11_7','联系人邮箱',1,-1,1,30,0,'',7,0,-1,-1,-1,20,0,'','',-1,'','','','','','',5)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'11','field_11_8','分支机构别名',1,-1,1,120,0,'',2,0,-1,-1,-1,80,0,'','',-1,'','','','','','',9)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'11','field_11_9','授权银行',4,-1,1,4,0,'',8,0,-1,-1,-1,0,0,'','',-1,'','','','','','',10)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'2','field_2_1','缴费周期',6,0,1,200,0,'',0,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'2','field_2_10','缴费名',1,-1,1,120,0,'',3,0,-1,-1,-1,200,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'2','field_2_3','授权银行',4,0,1,4,0,'',4,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'2','field_2_5','付款方式',6,0,1,200,0,'',1,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'2','field_2_6','授权银行分行名称',1,0,1,100,0,'',5,0,-1,-1,-1,200,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'2','field_2_7','授权银行账号',1,0,1,80,0,'',6,0,-1,-1,-1,180,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'2','field_2_8','省市',4,0,1,5,0,'',7,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'2','field_2_9','其他付费方式',4,-1,1,3,0,'',2,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'4','field_4_10','友邦团体意外伤害保险-GADD',6,-1,1,8,0,'',3,0,-1,-1,-1,0,0,'','',-1,'','','','','','',5)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'4','field_4_11','友邦公共交通B款团体意外伤害保险-GPCA(B)',6,-1,1,8,0,'',5,0,-1,-1,-1,0,0,'','',-1,'','','','','','',9)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'4','field_4_12','邦附加意外残疾团体意外伤害保险-GADR',6,-1,1,8,0,'',4,0,-1,-1,-1,0,0,'','',-1,'','','','','','',9)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'4','field_4_13','友邦附加三十四种重大疾病团体疾病保险-GCI34(A)',6,-1,1,8,0,'',6,0,-1,-1,-1,0,0,'','',-1,'','','','','','',8)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'4','field_4_14','友邦附加意外医药补偿A3款团体医疗保险-GAMR(A3)',6,-1,1,8,0,'',7,0,-1,-1,-1,0,0,'','',-1,'','','','','','',8)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'4','field_4_15','友邦附加意外住院给付B款团体医疗保险－GAHIR(B)',6,-1,1,8,0,'',8,0,-1,-1,-1,0,0,'','',-1,'','','','','','',9)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'4','field_4_16','友邦附加每日住院给付团体医疗保险-GHIR',6,-1,1,8,0,'',9,0,-1,-1,-1,0,0,'','',-1,'','','','','','',9)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'4','field_4_17','友邦住院及手术B2款团体医疗保险-GHS(B2)',6,-1,1,8,0,'',10,0,-1,-1,-1,0,0,'','',-1,'','','','','','',10)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'4','field_4_19','保险产品',4,0,1,5,0,'',0,0,-1,-1,-1,0,0,'','',-1,'','','','','','FLAK4',4)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'4','field_4_2','被保险人职业内容/职业描述',1,0,1,80,0,'',12,0,-1,-1,-1,100,0,'','',-1,'','','','','','',4)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'4','field_4_20','友邦附加境外住院B|附加运送|附加遗体送返',6,-1,1,8,0,'',11,0,-1,-1,-1,0,0,'','',-1,'','','','','','',10)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'4','field_4_3','被保险人数',1,0,1,20,0,'',13,0,-1,-1,-1,5,0,'','',-1,'','','','','','',2)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'4','field_4_8','职业等级',4,0,1,3,0,'',0,0,-1,-1,-1,0,0,'','',-1,'','','','','','',4)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'4','field_4_9','友邦加惠团体定期寿险-GTLTPD',6,-1,1,8,0,'',2,0,-1,-1,-1,0,0,'','',-1,'','','','','','',5)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'4','Plan_id','产品计划',7,0,1,3,0,'',0,0,-1,0,-1,0,0,'','',-1,'','','','','','',4)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'5','field_5_1','团体员工人数',5,-1,3,5,0,'',0,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'5','field_5_2','总共参保人数',5,-1,3,5,0,'',1,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'5','field_5_3','未能全员参保原因',4,-1,1,4,0,'',2,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'5','field_5_4','单证编号',1,-1,1,100,0,'',4,0,-1,-1,-1,150,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'5','field_5_5','版本号',1,-1,1,100,0,'',5,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'5','field_5_6','溢缴保费处理',4,-1,1,3,0,'',6,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'5','field_5_7','未能全员参保原因详情',1,-1,1,200,0,'',3,0,-1,-1,-1,250,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'6','AE_id','Servicing AE',7,-1,1,8,0,'',1,0,-1,0,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'6','field_6_1','业务渠道',6,0,1,1,0,'',0,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'6','field_6_6','佣金率',4,-1,1,5,0,'',3,0,-1,-1,-1,0,0,'','',-1,'','','','','','PF200',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'7','field_7_1','姓名',1,-1,1,80,0,'',1,0,-1,-1,-1,100,0,'','',1,'','','','','','',15)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'7','field_7_2','编号',1,-1,1,10,0,'',0,0,-1,-1,-1,100,0,'','',-1,'','','','','','',15)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'7','field_7_3','营销服务部',1,-1,1,20,0,'',3,0,-1,-1,-1,0,0,'','',1,'','','','','','',20)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'7','field_7_4','联系电话',1,-1,1,32,0,'',5,0,-1,-1,-1,150,0,'','',1,'','','','','','',30)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'7','field_7_5','佣金分配',1,-1,1,5,0,'',6,0,-1,-1,-1,0,0,'','',-1,'','','','','','',10)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'7','field_7_6','组别',1,-1,1,20,0,'',4,0,-1,-1,-1,20,0,'','',1,'','','','','','',10)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_1','被保险编号',1,0,1,10,0,'',11,0,-1,-1,-1,90,0,'','',-1,'','','','','','',8)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_10','职位/职务',1,0,1,40,0,'',12,0,-1,-1,-1,40,0,'','',-1,'','','','','','',6)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_12','劳动合同生效日期',3,0,2,10,0,'',16,0,-1,-1,-1,0,0,'','',-1,'','','','','','',10)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_13','是否拥有当地医保',4,0,1,1,0,'',17,0,-1,-1,-1,0,0,'','',-1,'','','','','','',5)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_15','职业等级',4,-1,1,2,0,'',13,0,-1,-1,-1,0,0,'','',-1,'','','','','','',5)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_16','保费',5,-1,3,10,0,'',5,2,1,-1,-1,10,0,'','',1,'','','','','','',5)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_17','分支编号',1,-1,1,3,0,'',1,0,-1,-1,-1,51,0,'','',-1,'','','','','','100',2)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_18','年龄',5,-1,3,3,0,'',10,0,-1,-1,-1,3,0,'','',1,'','','','','','',3)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_19','状态',1,-1,1,20,0,'',0,0,-1,-1,-1,51,0,'','',1,'','','','','','',2)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_2','被保险人姓名',1,0,1,60,0,'',2,0,-1,-1,-1,70,0,'','',-1,'','','','','','',5)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_20','保险产品',4,0,1,5,0,'',14,0,-1,-1,-1,0,0,'','',-1,'','','','','','',5)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_3','被保险人家属姓名',1,-1,1,60,0,'',3,0,-1,-1,-1,60,0,'','',-1,'','','','','','',5)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_4','关系',4,0,1,3,0,'',4,0,-1,-1,-1,0,0,'','',-1,'','','','','','M',2)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_6','国籍',4,0,1,6,0,'',6,0,-1,-1,-1,0,0,'','',-1,'','','','','','061',7)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_7','身份证/护照号码',1,0,1,18,0,'',7,0,-1,-1,-1,140,0,'','',-1,'','','','','','',10)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_8','性别',4,0,1,1,0,'',8,0,-1,-1,-1,0,0,'','',-1,'','','','','','',2)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','field_9_9','出生日期',3,0,2,10,0,'',9,0,-1,-1,-1,0,0,'','',-1,'','','','','','',10)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'9','MemPlan_id','产品计划',7,0,1,3,0,'',15,0,-1,0,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'BranchBank','field_BranchBank_1','授权银行',1,-1,1,1,0,'',0,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'BranchInf','BranCod_id','Branch Code',7,0,1,5,0,'',0,0,-1,0,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'BranchInf','field_BranchInf_2','Offcod',1,-1,1,4,0,'',2,0,-1,-1,-1,50,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'BranchInf','field_BranchInf_3','Offname2',1,-1,1,50,0,'',3,0,-1,-1,-1,50,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'BranchInf','field_BranchInf_4','Offname1',1,-1,1,50,0,'',4,0,-1,-1,-1,50,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'BranchInf','SecCity','2end level city',7,-1,1,6,0,'',1,0,-1,0,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'SystemFW','field_SystemFW_1','ErrorCode',1,-1,1,4,0,'',1,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
INSERT INTO [teflow_form_section_field] ([form_system_id],[section_id],[field_id],[field_label],[field_type],[is_required],[data_type],[field_length],[source_type],[source_sql],[order_id],[decimal_digits],[high_level],[is_money],[is_singlerow],[controls_width],[controls_height],[field_comments],[comment_content],[is_readonly],[event_click],[event_dbclick],[event_onfocus],[event_onblur],[event_onchange],[default_value],[column_width])VALUES(@idformsystem,'SystemFW','field_SystemFW_8','信息确认',6,0,1,1,0,'',0,0,-1,-1,-1,0,0,'','',-1,'','','','','','',NULL)
go

--FLOW
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
Declare @idflow int;
SET IDENTITY_INSERT [teflow_wkf_define] ON
SELECT @idflow = 10038
DELETE FROM teflow_wkf_define WHERE flow_id = 10038
INSERT INTO [teflow_wkf_define] ([flow_id],[flow_name],[description],[form_system_id],[company_id],[after_handle_url])VALUES(10038,'Flexible4SZ_NBFlow','友邦保险团体保险计划(组合)投保流程',30319,'Z07009','')
SET IDENTITY_INSERT [teflow_wkf_define] OFF
DELETE FROM teflow_wkf_detail WHERE flow_id = 10038
INSERT INTO [teflow_wkf_detail] ([flow_id],[node_id],[node_type],[pre_node_id],[node_name],[limited_hours],[has_rule],[rule_id],[approver_group_id],[approver_staff_code],[position_x],[position_y],[update_section_fields],[fill_section_fields],[node_alias],[approve_alias],[reject_alias])VALUES(@idflow,'24','2','23','生成合同',0.00,'0',0,'00','','3816px','3119px','SystemFW.field_SystemFW_7','','10.Contact','','')
INSERT INTO [teflow_wkf_detail] ([flow_id],[node_id],[node_type],[pre_node_id],[node_name],[limited_hours],[has_rule],[rule_id],[approver_group_id],[approver_staff_code],[position_x],[position_y],[update_section_fields],[fill_section_fields],[node_alias],[approve_alias],[reject_alias])VALUES(@idflow,'0','','','Begin',0.00,'0',0,'','','615px','1456px','','','','','')
INSERT INTO [teflow_wkf_detail] ([flow_id],[node_id],[node_type],[pre_node_id],[node_name],[limited_hours],[has_rule],[rule_id],[approver_group_id],[approver_staff_code],[position_x],[position_y],[update_section_fields],[fill_section_fields],[node_alias],[approve_alias],[reject_alias])VALUES(@idflow,'-1','','24','End',0.00,'0',0,'','','5519px','3129px','','','','','')
INSERT INTO [teflow_wkf_detail] ([flow_id],[node_id],[node_type],[pre_node_id],[node_name],[limited_hours],[has_rule],[rule_id],[approver_group_id],[approver_staff_code],[position_x],[position_y],[update_section_fields],[fill_section_fields],[node_alias],[approve_alias],[reject_alias])VALUES(@idflow,'23','2','30','验证账单支付',0.00,'0',0,'00','','2205px','3119px','SystemFW.field_SystemFW_6','','09.Payment','','')
INSERT INTO [teflow_wkf_detail] ([flow_id],[node_id],[node_type],[pre_node_id],[node_name],[limited_hours],[has_rule],[rule_id],[approver_group_id],[approver_staff_code],[position_x],[position_y],[update_section_fields],[fill_section_fields],[node_alias],[approve_alias],[reject_alias])VALUES(@idflow,'27','2','26','数据确认',0.00,'0',0,'00','','5735px','1477px','SystemFW.field_SystemFW_1','','03.DataCM','','')
INSERT INTO [teflow_wkf_detail] ([flow_id],[node_id],[node_type],[pre_node_id],[node_name],[limited_hours],[has_rule],[rule_id],[approver_group_id],[approver_staff_code],[position_x],[position_y],[update_section_fields],[fill_section_fields],[node_alias],[approve_alias],[reject_alias])VALUES(@idflow,'28','2','27','数据插入',0.00,'0',0,'','System001','7407px','1477px','SystemFW.field_SystemFW_1','','04.Insert','','')
INSERT INTO [teflow_wkf_detail] ([flow_id],[node_id],[node_type],[pre_node_id],[node_name],[limited_hours],[has_rule],[rule_id],[approver_group_id],[approver_staff_code],[position_x],[position_y],[update_section_fields],[fill_section_fields],[node_alias],[approve_alias],[reject_alias])VALUES(@idflow,'29','4','28,32','正式账单',0.00,'0',0,'','System001','9880px','1497px','','','06.Officail','','')
INSERT INTO [teflow_wkf_detail] ([flow_id],[node_id],[node_type],[pre_node_id],[node_name],[limited_hours],[has_rule],[rule_id],[approver_group_id],[approver_staff_code],[position_x],[position_y],[update_section_fields],[fill_section_fields],[node_alias],[approve_alias],[reject_alias])VALUES(@idflow,'30','2','29','账单报告',0.00,'0',0,'','System001','584px','3108px','SystemFW.field_SystemFW_1','','07.Report','','')
INSERT INTO [teflow_wkf_detail] ([flow_id],[node_id],[node_type],[pre_node_id],[node_name],[limited_hours],[has_rule],[rule_id],[approver_group_id],[approver_staff_code],[position_x],[position_y],[update_section_fields],[fill_section_fields],[node_alias],[approve_alias],[reject_alias])VALUES(@idflow,'32','2','29,30','系统支持',0.00,'0',0,'','C0378','7602px','4688px','','','08.ErrorHandle','','')
INSERT INTO [teflow_wkf_detail] ([flow_id],[node_id],[node_type],[pre_node_id],[node_name],[limited_hours],[has_rule],[rule_id],[approver_group_id],[approver_staff_code],[position_x],[position_y],[update_section_fields],[fill_section_fields],[node_alias],[approve_alias],[reject_alias])VALUES(@idflow,'31','2','26,28,25','错误控制',0.00,'0',0,'00','','779px','2236px','01.company_id,02.field_02_6,02.field_02_16,02.field_02_17,02.field_02_26,02.field_02_13,02.field_02_34,02.field_02_33,02.field_02_8,02.field_02_9,02.field_02_18,02.field_02_31,02.field_02_23,02.field_02_25,02.field_02_19,02.field_02_20,02.field_02_21,02.field_02_22,02.field_02_24,02.OriginalPol,02.field_02_27,02.field_02_30,02.field_02_28,02.field_02_32,5.field_5_1,5.field_5_2,5.field_5_3,5.field_5_7,5.field_5_4,5.field_5_5,5.field_5_6,6.field_6_1,6.AE_id,6.field_6_6,2.field_2_1,2.field_2_5,2.field_2_9,2.field_2_10,2.field_2_3,2.field_2_6,2.field_2_7,2.field_2_8,BranchInf.BranCod_id,BranchInf.SecCity,BranchInf.field_BranchInf_2,BranchInf.field_BranchInf_3,BranchInf.field_BranchInf_4,SystemFW.field_SystemFW_1,4.field_4_19,4.field_4_8,4.PlanCode_id,4.field_4_9,4.field_4_10,4.field_4_11,4.field_4_12,4.field_4_13,4.field_4_14,4.field_4_15,4.field_4_16,4.field_4_17,4.field_4_2,4.field_4_3,7.field_7_2,7.field_7_1,7.field_7_3,7.field_7_6,7.field_7_4,7.field_7_5,9.field_9_19,9.field_9_17,9.fie','','05.ErrorHandle','','')
INSERT INTO [teflow_wkf_detail] ([flow_id],[node_id],[node_type],[pre_node_id],[node_name],[limited_hours],[has_rule],[rule_id],[approver_group_id],[approver_staff_code],[position_x],[position_y],[update_section_fields],[fill_section_fields],[node_alias],[approve_alias],[reject_alias])VALUES(@idflow,'25','2','0,31','信息确认',0.00,'0',0,'00','','2349px','1467px','SystemFW.field_SystemFW_8','SystemFW.field_SystemFW_8,SystemFW.field_SystemFW_1','01.Confirm','','')
INSERT INTO [teflow_wkf_detail] ([flow_id],[node_id],[node_type],[pre_node_id],[node_name],[limited_hours],[has_rule],[rule_id],[approver_group_id],[approver_staff_code],[position_x],[position_y],[update_section_fields],[fill_section_fields],[node_alias],[approve_alias],[reject_alias])VALUES(@idflow,'26','2','25','系统验证',0.00,'0',0,'','System001','4104px','1467px','SystemFW.field_SystemFW_1','','02.Validation','','')
DELETE FROM teflow_wkf_detail_rule WHERE flow_id = 10038
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'26','31','SystemFW','field_SystemFW_1','like','E','01','E','系统流程控制.ErrorCode','1','select teflow_20259_SystemFW.request_no from  teflow_20259_SystemFW where 1=1  and ( teflow_20259_SystemFW.field_SystemFW_1 like ''%E%''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'28','31','SystemFW','field_SystemFW_1','like','E','01','E','系统流程控制.ErrorCode','1','select teflow_20259_SystemFW.request_no from  teflow_20259_SystemFW where 1=1  and ( teflow_20259_SystemFW.field_SystemFW_1 like ''%E%''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'25','31','SystemFW','field_SystemFW_1','like','E','01','E','系统流程控制.ErrorCode','1','select teflow_20259_SystemFW.request_no from  teflow_20259_SystemFW where 1=1  and ( teflow_20259_SystemFW.field_SystemFW_1 like ''%E%''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'10','2','SystemFW','field_SystemFW_1','=','E001','01','E001','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E001''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'10','4','SystemFW','field_SystemFW_1','=','E002','01','E002','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E002''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'10','11','SystemFW','field_SystemFW_1','=','S001','01','S001','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''S001''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'11','3','SystemFW','field_SystemFW_1','=','E004','01','E004','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E004''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'5','6','SystemFW','field_SystemFW_1','=','E004','01','E004','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E004''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'11','5','SystemFW','field_SystemFW_1','=','S001','01','S001','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''S001''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'5','7','SystemFW','field_SystemFW_1','=','E005','01','E005','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E005''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'5','8','SystemFW','field_SystemFW_1','=','S001','01','S001','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''S001''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'19','16','SystemFW','field_SystemFW_1','=','E002','01','E002','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E002''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'13','19','SystemFW','field_SystemFW_1','no','E','01','E','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1not like  ''E''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'17','18','SystemFW','field_SystemFW_1','=','E004','01','E004','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E004''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'20','21','SystemFW','field_SystemFW_1','=','E005','01','E005','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E005''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'20','22','SystemFW','field_SystemFW_1','=','E006','01','E006','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1=  ''E006''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'29','32','SystemFW','field_SystemFW_1','like','E','01','E','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1 like ''%E%''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'19','15','SystemFW','field_SystemFW_1','like','E','01','E','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1 like ''%E%''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'18','15','SystemFW','field_SystemFW_1','like','E','01','E','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1 like ''%E%''   )','1')
INSERT INTO [teflow_wkf_detail_rule] ([flow_id],[begin_node_id],[end_node_id],[section_id],[field_id],[compare_type],[compare_value],[logic_type],[compare_label],[field_label],[is_function],[sub_sql],[condition_type])VALUES(@idflow,'30','32','SystemFW','field_SystemFW_1','like','E','01','E','系统流程控制.ErrorCode','1','select teflow_232_SystemFW.request_no from  teflow_232_SystemFW where 1=1  and ( teflow_232_SystemFW.field_SystemFW_1 like ''%E%''   )','1')
DELETE FROM teflow_wkf_handle WHERE flow_id = 10038
INSERT INTO [teflow_wkf_handle] ([flow_id],[node_id],[approve_handle],[reject_handle])VALUES(@idflow,'25','NovaUspCompassTrigger','')
INSERT INTO [teflow_wkf_handle] ([flow_id],[node_id],[approve_handle],[reject_handle])VALUES(@idflow,'26','NovaUspCompassTrigger','')
INSERT INTO [teflow_wkf_handle] ([flow_id],[node_id],[approve_handle],[reject_handle])VALUES(@idflow,'27','NovaUspCompassTrigger','')
INSERT INTO [teflow_wkf_handle] ([flow_id],[node_id],[approve_handle],[reject_handle])VALUES(@idflow,'31','NovaUspCompassTrigger','')
go
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
update teflow_wkf_define set form_system_id = @idformsystem where flow_name ='Flexible4SZ_NBFlow  ' and description = '友邦保险团体保险计划(组合)投保流程'
go


--BASEDATA
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = 'Company Name' and type_code = '00')
begin
insert into teflow_base_data_master (field_name, type_code) values ('Company Name', '00');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'9','AIASH','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'11','AIABJ','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'25','AIAGD','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'27','AIAJM','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'0','REGION HO','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'10','AIASZ','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'12','AIAJS','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'26','AIAFS','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'28','AIADG','')
end
else
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_02_27' 
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = 'Company Name' and type_code = '00'
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'02','field_02_27')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'

if not exists (select * from teflow_base_data_master where field_name = 'Renewal Indicator' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('Renewal Indicator', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'A','By Policy Year','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'P','By product initial effective date','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'R','Always Renewal','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'M','By member cov initial date','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = 'Renewal Indicator' and type_code = '01'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_02_33' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'02','field_02_33')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = 'SIC code' and type_code = '00')
begin
insert into teflow_base_data_master (field_name, type_code) values ('SIC code', '00');
select  @idDataMaster = @@IDENTITY;
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = 'SIC code' and type_code = '00'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_02_8' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'02','field_02_8')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'

if not exists (select * from teflow_base_data_master where field_name = 'SZGACC' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('SZGACC', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1001','50,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1002','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1003','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1004','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1005','50,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1006','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1007','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1008','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1009','50,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1010','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1011','50,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1012','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1013','50,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1014','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1015','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1016','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1017','50,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1018','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1019','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1020','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1021','50,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1022','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1023','50,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1024','100,000','')
end
else

select  @idDataMaster = master_id from teflow_base_data_master  where field_name = 'SZGACC' and type_code = '01'
delete from [teflow_base_data_detail] where master_id=@idDataMaster

INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1001','50,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1002','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1003','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1004','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1005','50,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1006','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1007','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1008','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1009','50,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1010','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1011','50,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1012','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1013','50,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1014','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1015','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1016','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1017','50,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1018','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1019','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1020','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1021','50,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1022','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1023','50,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211T1024','100,000','')
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_4_12' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'4','field_4_12')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = 'SZGADD' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('SZGADD', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1001','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1002','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1003','300,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1004','500,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1005','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1006','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1007','300,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1008','500,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1009','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1010','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1011','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1012','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1013','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1014','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1015','300,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1016','500,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1017','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1018','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1019','300,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1020','500,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1021','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1022','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1023','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1024','200,000','')
end
else
begin
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = 'SZGADD' and type_code = '01'
delete from [teflow_base_data_detail] where master_id=@idDataMaster
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1001','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1002','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1003','300,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1004','500,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1005','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1006','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1007','300,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1008','500,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1009','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1010','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1011','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1012','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1013','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1014','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1015','300,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1016','500,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1017','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1018','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1019','300,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1020','500,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1021','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1022','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1023','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211D1024','200,000','')
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_4_10' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'4','field_4_10')
end
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = 'SZGAHIR' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('SZGAHIR', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1001','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1002','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1003','100','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1004','200','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1005','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1006','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1007','100','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1008','200','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1009','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1010','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1011','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1012','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1013','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1014','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1015','100','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1016','200','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1017','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1018','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1019','100','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1020','200','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1021','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1022','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1023','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1024','80','')
end
else
begin
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = 'SZGAHIR' and type_code = '01'
delete from [teflow_base_data_detail] where master_id=@idDataMaster
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1001','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1002','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1003','100','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1004','200','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1005','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1006','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1007','100','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1008','200','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1009','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1010','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1011','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1012','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1013','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1014','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1015','100','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1016','200','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1017','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1018','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1019','100','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1020','200','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1021','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1022','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1023','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S1024','80','')
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_4_15' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'4','field_4_15')
end
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = 'SZGAMR' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('SZGAMR', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5001','15,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5002','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5003','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5004','30,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5005','15,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5006','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5007','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5008','30,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5009','15,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5010','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5011','15,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5012','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5013','15,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5014','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5015','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5016','30,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5017','15,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5018','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5019','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5020','30,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5021','15,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5022','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5023','15,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5024','20,000','')
end
else
begin
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = 'SZGAMR' and type_code = '01'
delete from [teflow_base_data_detail] where master_id=@idDataMaster
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5001','15,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5002','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5003','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5004','30,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5005','15,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5006','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5007','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5008','30,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5009','15,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5010','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5011','15,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5012','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5013','15,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5014','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5015','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5016','30,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5017','15,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5018','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5019','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5020','30,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5021','15,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5022','20,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5023','15,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211S5024','20,000','')
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_4_14' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'4','field_4_14')
end
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = 'SZGCI34A' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('SZGCI34A', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3001','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3002','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3003','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3004','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3005','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3006','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3007','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3008','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3009','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3010','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3011','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3012','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3013','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3014','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3015','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3016','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3017','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3018','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3019','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3020','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3021','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3022','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3023','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3024','100,000','')
end
else
begin
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = 'SZGCI34A' and type_code = '01'
delete from [teflow_base_data_detail] where master_id=@idDataMaster
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3001','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3002','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3003','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3004','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3005','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3006','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3007','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3008','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3009','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3010','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3011','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3012','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3013','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3014','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3015','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3016','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3017','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3018','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3019','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3020','200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3021','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3022','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3023','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'214S3024','100,000','')
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_4_13'
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'4','field_4_13')
end
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = 'SZGHIR' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('SZGHIR', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3001','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3002','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3003','100','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3004','200','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3005','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3006','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3007','100','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3008','200','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3009','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3010','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3011','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3012','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3013','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3014','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3015','100','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3016','200','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3017','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3018','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3019','100','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3020','200','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3021','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3022','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3023','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3024','80','')
end
else
begin
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = 'SZGHIR' and type_code = '01'
delete from [teflow_base_data_detail] where master_id=@idDataMaster
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3001','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3002','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3003','100','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3004','200','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3005','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3006','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3007','100','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3008','200','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3009','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3010','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3011','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3012','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3013','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3014','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3015','100','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3016','200','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3017','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3018','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3019','100','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3020','200','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3021','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3022','80','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3023','60','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'311S3024','80','')
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_4_16' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'4','field_4_16')
end
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = 'SZGHS' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('SZGHS', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2001','50|2,500|2,500|2,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2002','60|3,000|3,000|3,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2003','70|3,500|3,500|3,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2004','100|5,000|5,000|5,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2005','50|2,500|2,500|2,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2006','60|3,000|3,000|3,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2007','70|3,500|3,500|3,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2008','100|5,000|5,000|5,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2009','50|2,500|2,500|2,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2010','60|3,000|3,000|3,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2011','50|2,500|2,500|2,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2012','60|3,000|3,000|3,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2013','50|2,500|2,500|2,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2014','60|3,000|3,000|3,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2015','70|3,500|3,500|3,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2016','100|5,000|5,000|5,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2017','50|2,500|2,500|2,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2018','60|3,000|3,000|3,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2019','70|3,500|3,500|3,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2020','100|5,000|5,000|5,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2021','50|2,500|2,500|2,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2022','60|3,000|3,000|3,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2023','50|2,500|2,500|2,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2024','60|3,000|3,000|3,000','')
end
else
begin
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = 'SZGHS' and type_code = '01'
delete from [teflow_base_data_detail] where master_id=@idDataMaster
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2001','50|2,500|2,500|2,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2002','60|3,000|3,000|3,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2003','70|3,500|3,500|3,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2004','100|5,000|5,000|5,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2005','50|2,500|2,500|2,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2006','60|3,000|3,000|3,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2007','70|3,500|3,500|3,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2008','100|5,000|5,000|5,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2009','50|2,500|2,500|2,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2010','60|3,000|3,000|3,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2011','50|2,500|2,500|2,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2012','60|3,000|3,000|3,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2013','50|2,500|2,500|2,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2014','60|3,000|3,000|3,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2015','70|3,500|3,500|3,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2016','100|5,000|5,000|5,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2017','50|2,500|2,500|2,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2018','60|3,000|3,000|3,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2019','70|3,500|3,500|3,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2020','100|5,000|5,000|5,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2021','50|2,500|2,500|2,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2022','60|3,000|3,000|3,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2023','50|2,500|2,500|2,500','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'301C2024','60|3,000|3,000|3,000','')
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_4_17' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'4','field_4_17')
end
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = 'SZGOERR' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('SZGOERR', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX001','500|25,000|25,000|25,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX002','600|30,000|30,000|30,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX003','700|35,000|35,000|35,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX004','1,000|50,000|50,000|50,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX005','500|25,000|25,000|25,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX006','600|30,000|30,000|30,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX007','700|35,000|35,000|35,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX008','1,000|50,000|50,000|50,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX009','500|25,000|25,000|25,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX010','600|30,000|30,000|30,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX011','500|25,000|25,000|25,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX012','600|30,000|30,000|30,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX013','500|25,000|25,000|25,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX014','600|30,000|30,000|30,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX015','700|35,000|35,000|35,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX016','1,000|50,000|50,000|50,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX017','500|25,000|25,000|25,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX018','600|30,000|30,000|30,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX019','700|35,000|35,000|35,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX020','1,000|50,000|50,000|50,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX021','500|25,000|25,000|25,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX022','600|30,000|30,000|30,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX023','500|25,000|25,000|25,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX023','600|30,000|30,000|30,000|200,000|100,000','')
end
else
begin
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = 'SZGOERR' and type_code = '01'
delete from [teflow_base_data_detail] where master_id=@idDataMaster
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX001','500|25,000|25,000|25,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX002','600|30,000|30,000|30,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX003','700|35,000|35,000|35,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX004','1,000|50,000|50,000|50,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX005','500|25,000|25,000|25,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX006','600|30,000|30,000|30,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX007','700|35,000|35,000|35,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX008','1,000|50,000|50,000|50,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX009','500|25,000|25,000|25,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX010','600|30,000|30,000|30,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX011','500|25,000|25,000|25,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX012','600|30,000|30,000|30,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX013','500|25,000|25,000|25,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX014','600|30,000|30,000|30,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX015','700|35,000|35,000|35,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX016','1,000|50,000|50,000|50,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX017','500|25,000|25,000|25,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX018','600|30,000|30,000|30,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX019','700|35,000|35,000|35,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX020','1,000|50,000|50,000|50,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX021','500|25,000|25,000|25,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX022','600|30,000|30,000|30,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX023','500|25,000|25,000|25,000|200,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'360SX023','600|30,000|30,000|30,000|200,000|100,000','')

delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_4_20' 
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'4','field_4_20')

end
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = 'SZGPCAB' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('SZGPCAB', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX001','400,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX002','500,000|150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX003','600,000|200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX004','1,000,000|300,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX005','400,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX006','500,000|150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX007','600,000|200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX008','1,000,000|300,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX009','400,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX010','500,000|150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX011','400,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX012','500,000|150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX013','400,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX014','500,000|150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX015','600,000|200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX016','1,000,000|300,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX017','400,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX018','500,000|150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX019','600,000|200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX020','1,000,000|300,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX021','400,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX022','500,000|150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX023','400,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX024','500,000|150,000','')
end
else
begin
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = 'SZGPCAB' and type_code = '01'
delete from [teflow_base_data_detail] where master_id=@idDataMaster
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX001','400,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX002','500,000|150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX003','600,000|200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX004','1,000,000|300,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX005','400,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX006','500,000|150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX007','600,000|200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX008','1,000,000|300,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX009','400,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX010','500,000|150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX011','400,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX012','500,000|150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX013','400,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX014','500,000|150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX015','600,000|200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX016','1,000,000|300,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX017','400,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX018','500,000|150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX019','600,000|200,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX020','1,000,000|300,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX021','400,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX022','500,000|150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX023','400,000|100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'211DX024','500,000|150,000','')
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_4_11' 
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'4','field_4_11')
end
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = 'SZGTLTPD' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('SZGTLTPD', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2001','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2002','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2003','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2004','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2005','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2006','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2007','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2008','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2009','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2010','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2011','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2012','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2013','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2014','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2015','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2016','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2017','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2018','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2019','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2020','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2021','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2022','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2023','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2024','100,000','')
end
else
begin
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = 'SZGTLTPD' and type_code = '01'
delete from [teflow_base_data_detail] where master_id=@idDataMaster
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2001','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2002','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2003','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2004','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2005','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2006','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2007','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2008','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2009','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2010','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2011','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2012','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2013','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2014','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2015','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2016','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2017','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2018','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2019','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2020','150,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2021','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2022','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2023','100,000','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'201C2024','100,000','')
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_4_9'
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'4','field_4_9')
end
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = 'SZProduct' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('SZProduct', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'FLAK3','福乐安康','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'FLAK4','福乐安康4.0','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = 'SZProduct' and type_code = '01'
DELETE FROM [teflow_base_data_detail] WHERE master_id=@idDataMaster
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'FLAK3','福乐安康','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'FLAK4','福乐安康4.0','')
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = 'SZProduct' and type_code = '01'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_4_19' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'4','field_4_19')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = 'SZProduct' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('SZProduct', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'FLAK3','福乐安康','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'FLAK4','福乐安康4.0','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = 'SZProduct' and type_code = '01'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_9_20' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'9','field_9_20')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '风险等级' and type_code = '00')
begin
insert into teflow_base_data_master (field_name, type_code) values ('风险等级', '00');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'M','中风险','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'H','高风险','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'L','低风险','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '风险等级' and type_code = '00'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_02_30' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'02','field_02_30')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '付款方式' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('付款方式', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'3','其他付款方式','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'1','单位转账','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'2','单位支票','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '付款方式' and type_code = '01'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_2_5' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'2','field_2_5')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '关系' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('关系', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'P','父母','T')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'0','其他','T')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'6','其他','T')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'7','其他','T')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'8','其他','T')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'9','其他','T')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'B','兄弟/姐妹','T')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'C','子女','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'M','员工','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'S','配偶','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '关系' and type_code = '01'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_9_4' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'9','field_9_4')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '国籍' and type_code = '00')
begin
insert into teflow_base_data_master (field_name, type_code) values ('国籍', '00');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'003','CANADA','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'007','JAMAICA','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'009','SINGAPORE','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'013','USA','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'039','BAHAMAS','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'040','BARBADOS','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'041','HONGKONG','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'042','CUBA','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'049','AIAB-MACAU','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'061','CHINA','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'064','INDIA','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'067','JAPAN','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'069','INDONESIA','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'071','PHILIPPINES','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'072','THAILAND','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'087','FRANCE','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'088','GERMANY','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'090','GREECE','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'132','MALAYSIA','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'142','UAE','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'144','HONGKONG','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'153','GREATBRITAIN','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'154','KOREASOUTH','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'155','MACAU','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'161','LEBANON','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'168','TAIWAN','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'170','JORDAN','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'171','SWITZERLAND','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'184','DENMARK','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'205','KUWAIT','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'218','KENYA','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'246','OMAN','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'265','KOREANORTH','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'288','NORTHYEMEN','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'289','VIETNAM','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'292','ANTARCTICA','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'812','AUSTRALIA','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'901','SERBIA','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'902','ESTONIA','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'903','PORTUGAL','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'086','中国','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '国籍' and type_code = '00'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_9_6' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'9','field_9_6')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '缴费周期' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('缴费周期', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'A','年缴','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'M','月缴','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'Q','季缴','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'S','半年缴','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '缴费周期' and type_code = '01'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_2_1' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'2','field_2_1')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '其他付费方式' and type_code = '00')
begin
insert into teflow_base_data_master (field_name, type_code) values ('其他付费方式', '00');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'001','委托第三方缴费：个人','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'002','委托第三方缴费：单位','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '其他付费方式' and type_code = '00'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_2_9' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'2','field_2_9')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'

if not exists (select * from teflow_base_data_master where field_name = '省市' and type_code = '00')
begin
insert into teflow_base_data_master (field_name, type_code) values ('省市', '00');
select  @idDataMaster = @@IDENTITY;
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '省市' and type_code = '00'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_2_8' and master_id=@idDataMaster
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_11_12' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'2','field_2_8')
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'11','field_11_12')

go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '是否' and type_code = '00')
begin
insert into teflow_base_data_master (field_name, type_code) values ('是否', '00');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'Y','是','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'N','否','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '是否' and type_code = '00'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_9_13' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'9','field_9_13')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '是否' and type_code = '00')
begin
insert into teflow_base_data_master (field_name, type_code) values ('是否', '00');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'Y','是','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'N','否','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '是否' and type_code = '00'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_SystemFW_1' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'SystemFW','field_SystemFW_1')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '团体证件类型' and type_code = '00')
begin
insert into teflow_base_data_master (field_name, type_code) values ('团体证件类型', '00');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'001','企业营业执照','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'002','事业法人证书','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'003','社团登记证','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'004','其他','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '团体证件类型' and type_code = '00'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_02_31' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'02','field_02_31')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '未能全员参保原因' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('未能全员参保原因', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'R001','除法人,联系人外全体员工投保','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'R003','___部门全员投保','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'R005','未投保人员超龄/职业等级超出承保范围，全体符合资格员工参保','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'R004','全体____（工种）投保','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'R006','其他原因:_____________','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'R002','为参保人员在其他保险公司在保,到期后转入','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '未能全员参保原因' and type_code = '01'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_5_3' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'5','field_5_3')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '信息确定, 确认提交' and type_code = '00')
begin
insert into teflow_base_data_master (field_name, type_code) values ('信息确定, 确认提交', '00');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'Y','信息经过核对, 确认提交','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '信息确定, 确认提交' and type_code = '00'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_SystemFW_8' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'SystemFW','field_SystemFW_8')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '性别' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('性别', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'M','男','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'F','女','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '性别' and type_code = '01'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_9_8' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'9','field_9_8')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '业务渠道' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('业务渠道', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'A','营销员','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'B','中介','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'D','直销','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '业务渠道' and type_code = '01'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_6_1' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'6','field_6_1')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '溢缴保费处理' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('溢缴保费处理', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'002','退还缴费账户','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'001','抵缴续期保费','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '溢缴保费处理' and type_code = '01'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_5_6' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'5','field_5_6')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '银行代码' and type_code = '00')
begin
insert into teflow_base_data_master (field_name, type_code) values ('银行代码', '00');
select  @idDataMaster = @@IDENTITY;
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '银行代码' and type_code = '00'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_11_9' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'11','field_11_9')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '银行代码' and type_code = '00')
begin
insert into teflow_base_data_master (field_name, type_code) values ('银行代码', '00');
select  @idDataMaster = @@IDENTITY;
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '银行代码' and type_code = '00'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_2_3' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'2','field_2_3')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '银行代码' and type_code = '00')
begin
insert into teflow_base_data_master (field_name, type_code) values ('银行代码', '00');
select  @idDataMaster = @@IDENTITY;
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '银行代码' and type_code = '00'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_BankBranch_2' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'BankBranch','field_BankBranch_2')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '佣金保费比例' and type_code = '00')
begin
insert into teflow_base_data_master (field_name, type_code) values ('佣金保费比例', '00');
select  @idDataMaster = @@IDENTITY;
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '佣金保费比例' and type_code = '00'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_6_6' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'6','field_6_6')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '职业等级' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('职业等级', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'1','1 - Class1','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'2','2 - Class2','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'3','3 - Class3','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'4','4 - Class4','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'5','5 - Class5','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '职业等级' and type_code = '01'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_4_8' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'4','field_4_8')
go
Declare @idDataMaster int;
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_base_data_master where field_name = '职业等级' and type_code = '01')
begin
insert into teflow_base_data_master (field_name, type_code) values ('职业等级', '01');
select  @idDataMaster = @@IDENTITY;
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'1','1 - Class1','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'2','2 - Class2','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'3','3 - Class3','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'4','4 - Class4','')
INSERT INTO [teflow_base_data_detail] ([master_id],[option_value],[option_label],[status])VALUES(@idDataMaster,'5','5 - Class5','')
end
else
select  @idDataMaster = master_id from teflow_base_data_master  where field_name = '职业等级' and type_code = '01'
delete from teflow_field_basedata where form_system_id=@idformsystem and field_id = 'field_9_15' and master_id=@idDataMaster
insert into teflow_field_basedata ([master_id],[form_system_id],[section_id],[field_id])VALUES(@idDataMaster,@idformsystem,'9','field_9_15')
go

--APPROVAL GROUP
Declare @idformsystem int;
select @idformsystem=form_system_id from teflow_form where form_name='友邦保险团体保险计划(福乐安康4.0)投保单' and form_id='FlexSZ4_NBForm'
if not exists (select * from teflow_approver_group where approver_group_id = '00')
begin
insert into teflow_approver_group (approver_group_id, approver_group_name, description, group_type) values ('00', '(Group)Requestor', 'Requestor', '03');
end
go

--SYSTEMFIELD
if not exists (select * from teflow_system_field where field_id = 'OriginalPol')
begin
INSERT INTO [teflow_system_field] ([field_id],[field_label],[field_type],[src_table_name],[src_id_column],[src_label_column],[column_type],[column_length],[data_sql],[param_list])VALUES('OriginalPol','关联保单','05','','','',1,10,'select * from @CompassDB..tpolicy where 1<>1','CompassDB')
end
go
if not exists (select * from teflow_system_field where field_id = 'Plan_id')
begin
INSERT INTO [teflow_system_field] ([field_id],[field_label],[field_type],[src_table_name],[src_id_column],[src_label_column],[column_type],[column_length],[data_sql],[param_list])VALUES('Plan_id','产品计划','05','','','',1,3,'SELECT DISTINCT NOVA_BENPLNCD option_value , NOVA_BENPLNCD_Local option_label FROM TNovaProductMapping WHERE form_System_id = @formid','')
end
go
if not exists (select * from teflow_system_field where field_id = 'AE_id')
begin
INSERT INTO [teflow_system_field] ([field_id],[field_label],[field_type],[src_table_name],[src_id_column],[src_label_column],[column_type],[column_length],[data_sql],[param_list])VALUES('AE_id','Servicing AE','05','','','',1,8,'SELECT DISTINCT RTRIM(TUser.UserId) option_value , RTRIM(TUser.UserId) +'' - '' + RTRIM(TUser.UserName) option_label FROM @CompassDB..TUSERPROF   TUser, @CompassDB..TUSERSECURITY   TS WHERE TS.UserId = TUser.UserId AND TUser.RcdSts = ''A'' AND TS.RcdSts = ''A''','CompassDB')
end
go
if not exists (select * from teflow_system_field where field_id = 'MemPlan_id')
begin
INSERT INTO [teflow_system_field] ([field_id],[field_label],[field_type],[src_table_name],[src_id_column],[src_label_column],[column_type],[column_length],[data_sql],[param_list])VALUES('MemPlan_id','人员产品计划','05','','','',1,3,'SELECT DISTINCT NOVA_BENPLNCD option_value , NOVA_BENPLNCD_Local option_label FROM TNovaProductMapping WHERE form_System_id = @formid','')
end
go
if not exists (select * from teflow_system_field where field_id = 'BranCod_id')
begin
INSERT INTO [teflow_system_field] ([field_id],[field_label],[field_type],[src_table_name],[src_id_column],[src_label_column],[column_type],[column_length],[data_sql],[param_list])VALUES('BranCod_id','Branch Code','05','','','',1,5,'select distinct CONVERT(VARCHAR(4),COMPCODE)+BRANCHCODE option_value,BRANCHCODE + '' - ''+BRANCHSHORT option_label from @CompassDB..TCOMPBRANCH','CompassDB')
end
go
if not exists (select * from teflow_system_field where field_id = 'SecCity')
begin
INSERT INTO [teflow_system_field] ([field_id],[field_label],[field_type],[src_table_name],[src_id_column],[src_label_column],[column_type],[column_length],[data_sql],[param_list])VALUES('SecCity','2end level city','05','','','',1,6,'select DISTINCT CONVERT(VARCHAR(6),COUNTYCODE) option_value,BRANCHCODE +'' - '' + COUNTYCODE +'' - ''+COUNTYDESC option_label from @CompassDB..TCOMPBRNCOUNTY','CompassDB')
end
go

DELETE FROM TNovaFieldMapping WHERE form_system_id = 30319
DECLARE	@COMPDB VARCHAR(8)
SELECT @COMPDB = param_value FROM teflow_param_config WHERE config_id=116
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_16','','TCLIENT','CLNTCODE','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_20','','TCLIENT','TELNO','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_18','','TCLIENT','MAILCODE','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_21','','TCLIENT','EMAILADDR','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_17','','TCLIENT','CLNTNAME','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_26','','TCLIENT','CLNTNAMEGEN','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_19','','TCLIENT','CONTPERSON','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_8','','TCLIENT','SICCODE','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','CASE WHEN (SELECT 1 FROM '+@COMPDB+'..TCLIENT WHERE CLNTCODE=RTRIM(field_02_16 COLLATE Chinese_PRC_CI_AS) AND RCDSTS=''A'') =1 THEN (SELECT STATEFFDT FROM '+@COMPDB+'..TCLIENT WHERE CLNTCODE=RTRIM(field_02_16 COLLATE Chinese_PRC_CI_AS) AND RCDSTS=''A'') ELSE field_02_13 END','','TCLIENT','STATEFFDT','DATETIME','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_23','','TCLIENT','TaxID','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_2','field_2_7','','TCLIENT','BANKAC','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_2','field_2_3','','TCLIENT','BANKCODE','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_2','field_2_6','','TCLIENT','BANKBRNAME','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_2','field_2_7','','TCLIENT','PRMRFBANKACCT','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_2','field_2_3','','TCLIENT','PRMRFBANKCODE','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_2','field_2_6','','TCLIENT','PRMRFBANKBRNAME','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_2','field_2_10','','TCLIENT','PAYEENAME','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','','TCLIENT','RCDDTSTMP','DATETIME','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','CASE WHEN field_02_27 IN (''25'',''26'',''27'',''28'') THEN ''广东'' WHEN field_02_27 = 10 THEN ''深圳'' WHEN field_02_27 = 11 THEN ''北京'' WHEN field_02_27 = 9 THEN ''上海'' WHEN field_02_27 = 12 THEN ''江苏'' END','','TCLIENT','STATE','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','CASE WHEN field_02_27 IN (''25'',''26'',''27'',''28'') THEN ''广东'' WHEN field_02_27 = 10 THEN ''深圳'' WHEN field_02_27 = 11 THEN ''北京'' WHEN field_02_27 = 9 THEN ''上海'' WHEN field_02_27 = 12 THEN ''江苏'' END','Teflow_30319_11.id','TCLNTSUB','STATE','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_16','Teflow_30319_11.id','TCLNTSUB','CLNTCODE','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_1','Id','TCLNTSUB','SUBOFFCODE','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_2','Id','TCLNTSUB','SUBOFFNAME','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_8','Id','TclntSub','SUBOFFNAMEGEN','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_12','id','TMEMBER','EMPDT','DATETIME','',11.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_13','id','TMEMBER','SHIP','','',11.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_10','id','TMEMBER','OCCUPATION','','',11.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_7','id','TMEMBER','MEMIDNO','','',11.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_6','id','TMEMBER','MEMNATION','','',11.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','teflow_30319_9.id','TMEMBER','RCDDTSTMP','DATETIME','',11.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_16','teflow_30319_9.id','TMEMPTPOL','CLNTCODE','','',12.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_17','id','TMEMPTPOL','SUBOFFCODE','','',12.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','SUBSTRING(field_02_9,43,14)','','TCLIENT','ADDRESS4','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_8','Teflow_30319_11.id','TCLNTSUB','SICCODE','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','case when field_02_30 =''L'' then N''低风险'' 
		when field_02_30 =''M'' then N''中风险'' 
		when field_02_30 =''H'' then N''高风险'' end','','heworksheet','edesc','','',14.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','','heworksheet','eseqno','','',14.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','','heworksheet','polno','','',14.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_28','','heworksheet','create_usr','','',14.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','convert(char(10),getdate(),112)','id','TMEMPTPOL','CHGEFFDT','DATETIME','',12.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','getdate()','','heworksheet','create_dt','DATETIME','',14.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','getdate()','','heworksheet','rcddtstmp','DATETIME','',14.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_11','SUBSTRING(field_11_3,1,14)','id','TCLNTSUB','ADDRESS1','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_11','SUBSTRING(field_11_3,15,14)','id','TCLNTSUB','ADDRESS2','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_11','SUBSTRING(field_11_3,29,14)','id','TCLNTSUB','ADDRESS3','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_11','SUBSTRING(field_11_3,43,14)','id','TCLNTSUB','ADDRESS4','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','LEFT(field_02_9,14)','','TCLIENT','ADDRESS1','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','SUBSTRING(field_02_9,15,14)','','TCLIENT','ADDRESS2','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','SUBSTRING(field_02_9,29,14)','','TCLIENT','ADDRESS3','','',0.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_1','id','TMEMPTPOL','CERTNO','','',12.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','teflow_30319_9.id','TMEMPTPOL','POLNO','','',12.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_20','id','TMEMPTPOL','PRODCODE','','',12.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','MemPlan_id','id','TMEMPTPOL','BENPLNCD','','',12.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_13','teflow_30319_9.id','TMEMPTPOL','CHGEFFDATE','DATETIME','',12.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_13','teflow_30319_9.id','TMEMPTPOL','INIEFFDT','DATETIME','',12.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','teflow_30319_9.id','TMEMPTPOL','RCDDTSTMP','DATETIME','',12.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_6','field_6_1','','TPOLPDT','BUSNSRCE','','',4.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','','TPOLPDT','POLNO','','',4.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','CONVERT(CHAR(10),Request_date,120)','','TPOLPDT','EFFDATE','DATETIME','',4.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_13','','TPOLPDT','INIEFFDT','DATETIME','',4.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_24','','TPOLPDT','WAITPRD','','',4.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_2','field_2_1','','TPOLPDT','BILLMODE','','',4.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_13','','TPOLPDT','CHGEFFDT','','',4.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_6','field_6_6','','TPOLPDT','COMMCODE','','',4.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','','TPOLPDT','RCDDTSTMP','DATETIME','',4.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_product','PKGPRDCD','','TPOLPDT','PRODCODE','','PKGPRDCD',4.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PRODCODE','id','TPOLPDT_NOVA','SUBPRODCODE','','',4.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PKGPRDCD','id','TPOLPDT_NOVA','NOVA_PRODCODE','','',4.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PLANCODE','id','TPOLPDT_NOVA','NOVA_BENPLNCD','','',4.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PKGPRDCD','id','TPOLPDT_NOVA','PRODCODE','','',4.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PLANCODE','id','TPOLPDT_NOVA','BENPLNCD','','',4.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PLANDESC','id','TPOLPDT_NOVA','PLNDESC','','',4.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','Request_no','id','TPOLPDT_NOVA','REQUESTNO','','',4.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','teflow_productPlan.id','TPOLPDT_NOVA','POLNO','','',4.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_product','PRODCODE','id','TPOLPDTADJ','PRODCODE','','PRODCODE',4.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','teflow_product.id','TPOLPDTADJ','POLNO','','',4.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','CONVERT(CHAR(10),Request_date,120)','teflow_product.id','TPOLPDTADJ','RCDDATE','DATETIME','',4.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_13','teflow_product.id','TPOLPDTADJ','CHGEFFDT','DATETIME','',4.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','teflow_product.id','TPOLPDTCOV','POLNO','','',4.20)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','CONVERT(CHAR(10),Request_date,120)','teflow_product.id','TPOLPDTCOV','EFFDATE','DATETIME','',4.20)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','teflow_product.id','TPOLPDTCOV','RCDDTSTMP','DATETIME','',4.20)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_product','PRODCODE','id','TPOLPDTCOV','PRODCODE','','PRODCODE',4.20)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','teflow_product.id','TPOLPDTH','POLNO','','',4.30)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','teflow_product.id','TPOLPDTH','RCDDTSTMP','DATETIME','',4.30)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_product','PRODCODE','id','TPOLPDTH','PRODCODE','','PRODCODE',4.30)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PRODCODE','id','TPOLPDTPLN','PRODCODE','','PRODCODE',5.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PLANCODE','id','TPOLPDTPLN','BENPLNCD','','BENPLNCD',5.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PLANDESC','id','TPOLPDTPLN','PLNDESC','','',5.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','teflow_productPlan.id','TPOLPDTPLN','POLNO','','',5.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','CONVERT(CHAR(10),Request_date,120)','teflow_productPlan.id','TPOLPDTPLN','EFFDATE','DATETIME','',5.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','teflow_productPlan.id','TPOLPDTPLN','RCDDTSTMP','DATETIME','',5.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','teflow_productPlan.id','TPOLPDTPLNH','POLNO','','',5.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','teflow_productPlan.id','TPOLPDTPLNH','RCDDTSTMP','DATETIME','',5.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PRODCODE','id','TPOLPDTPLNH','PRODCODE','','PRODCODE',5.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PLANCODE','id','TPOLPDTPLNH','BENPLNCD','','BENPLNCD',5.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PRODCODE','id','TPOLPDTBEN','PRODCODE','','PRODCODE',6.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PLANCODE','id','TPOLPDTBEN','BENPLNCD','','BENPLNCD',6.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','teflow_productPlan.id','TPOLPDTBEN','POLNO','','',6.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','CONVERT(CHAR(10),Request_date,120)','teflow_productPlan.id','TPOLPDTBEN','EFFDATE','DATETIME','',6.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','teflow_productPlan.id','TPOLPDTBEN','RCDDTSTMP','DATETIME','',6.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','teflow_productPlan.id','TPOLPDTLIMIT','POLNO','','',6.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','CONVERT(CHAR(10),Request_date,120)','teflow_productPlan.id','TPOLPDTLIMIT','EFFDATE','DATETIME','',6.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','teflow_productPlan.id','TPOLPDTLIMIT','RCDDTSTMP','DATETIME','',6.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PRODCODE','id','TPOLPDTLIMIT','PRODCODE','','PRODCODE',6.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PLANCODE','id','TPOLPDTLIMIT','BENPLNCD','','BENPLNCD',6.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','teflow_productPlan.id','TPOLPDTPRM','POLNO','','',7.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','CONVERT(CHAR(10),Request_date,120)','teflow_productPlan.id','TPOLPDTPRM','EFFDATE','DATETIME','',7.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','teflow_productPlan.id','TPOLPDTPRM','RCDDTSTMP','DATETIME','',7.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PRODCODE','id','TPOLPDTPRM','PRODCODE','','PRODCODE',7.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_productplan','PLANCODE','id','TPOLPDTPRM','BENPLNCD','','BENPLNCD',7.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_product','PKGPRDCD','teflow_30319_7.id','TPOLPDTCOM','PRODCODE','','PKGPRDCD',8.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','teflow_30319_7.id','TPOLPDTCOM','POLNO','','',8.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','CONVERT(CHAR(10),Request_date,120)','teflow_30319_7.id','TPOLPDTCOM','EFFDATE','DATETIME','',8.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_7','field_7_2','id','TPOLPDTCOM','PRDUCODE','','',8.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_7','CONVERT(DEC(5,4),CONVERT(INT,field_7_5)/100.00)','id','TPOLPDTCOM','PRDUSHRPC','','',8.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','teflow_30319_7.id','TPOLPDTCOM','RCDDTSTMP','DATETIME','',8.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','Request_no','id','TBILLDETAIL_NOVA','RequestID','','',13.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_27','teflow_30319_9.id','TBILLDETAIL_NOVA','COMPCODE','DEC(4,0)','',13.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_16','teflow_30319_9.id','TBILLDETAIL_NOVA','CLNTCODE','','',13.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_10','field_10_2','teflow_30319_9.id','TBILLDETAIL_NOVA','BillFromDate','DATETIME','',13.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_10','field_10_4','teflow_30319_9.id','TBILLDETAIL_NOVA','BillToDate','DATETIME','',13.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_17','id','TBILLDETAIL_NOVA','SUBOFFCODE','','',13.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','teflow_30319_9.id','TBILLDETAIL_NOVA','POLNO','','',13.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_20','id','TBILLDETAIL_NOVA','PRODCODE','','',13.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','MemPlan_id','id','TBILLDETAIL_NOVA','BENPLNCD','','',13.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_1','id','TBILLDETAIL_NOVA','CERTNO','','',13.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_18','id','TBILLDETAIL_NOVA','MBAGE','INT','',13.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_16','id','TBILLDETAIL_NOVA','PREMDU','DEC(13,2)','',13.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_10','field_10_5','teflow_30319_9.id','TBILLDETAIL_NOVA','BILLNO','','',13.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_15','id','TMEMBER','OCCUPCLASS','','',11.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_13','Id','TCLNTSUB','MAILCODE','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_6','Id','TCLNTSUB','CONTPERSON','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_5','Id','TCLNTSUB','USERDEFINED1','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_4','Id','TCLNTSUB','TELNO','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_7','Id','TCLNTSUB','EMAILADDR','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','CASE WHEN (SELECT 1 FROM '+@COMPDB+'..TCLIENT WHERE CLNTCODE=RTRIM(field_02_16 COLLATE Chinese_PRC_CI_AS) AND RCDSTS=''A'') =1 THEN (SELECT STATEFFDT FROM '+@COMPDB+'..TCLIENT WHERE CLNTCODE=RTRIM(field_02_16 COLLATE Chinese_PRC_CI_AS) AND RCDSTS=''A'') ELSE field_02_13 END','Teflow_30319_11.id','TCLNTSUB','STATEFFDT','DATETIME','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','CASE WHEN (SELECT 1 FROM '+@COMPDB+'..TCLIENT WHERE CLNTCODE=RTRIM(field_02_16 COLLATE Chinese_PRC_CI_AS) AND RCDSTS=''A'') =1 THEN (SELECT STATEFFDT FROM '+@COMPDB+'..TCLIENT WHERE CLNTCODE=RTRIM(field_02_16 COLLATE Chinese_PRC_CI_AS) AND RCDSTS=''A'') ELSE field_02_13 END','Teflow_30319_11.id','TCLNTSUB','INIEFFDT','DATETIME','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_27','Teflow_30319_11.id','TCLNTSUB','COMPCODE','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_11','Id','TCLNTSUB','BANKAC','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_9','Id','TCLNTSUB','BANKCODE','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_10','Id','TCLNTSUB','BANKBRNAME','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_11','Id','TCLNTSUB','PRMRFBANKACCT','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_9','Id','TCLNTSUB','PRMRFBANKCODE','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_10','Id','TCLNTSUB','PRMRFBANKBRNAME','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','Teflow_30319_11.id','TCLNTSUB','RCDDTSTMP','DATETIME','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_2','id','TCLNTSUB','PAYEENAME','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_23','Teflow_30319_11.id','TCLNTSUB','TAXID','','',1.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_11','id','TBANKACCTINFO','BANKAC','','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_9','id','TBANKACCTINFO','BANKCODE','','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_2','id','TBANKACCTINFO','PAYEENAME','','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_12','id','TBANKACCTINFO','CITYCODE','','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_10','id','TBANKACCTINFO','BANKBRANCH','','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_16','Teflow_30319_11.id','TBANKACCTINFO','CLNTCODE','','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'Teflow_30319_11','field_11_1','id','TBANKACCTINFO','SUBOFFCODE','','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','Teflow_30319_11.id','TBANKACCTINFO','RCDDTSTMP','DATETIME','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','','TPOLICY','POLNO','','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_17','','TPOLICY','POLDESC','','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_16','','TPOLICY','CLNTCODE','','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_27','','TPOLICY','COMPCODE','','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_13','','TPOLICY','INIEFFDT','DATETIME','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_13','','TPOLICY','ANNVDATE','DATETIME','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_13','','TPOLICY','STATEFFDT','DATETIME','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','','TPOLICY','RCDCRTDT','DATETIME','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','','TPOLICY','RCDDTSTMP','DATETIME','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_28','','TPOLICY','USERID','','',2.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','CASE WHEN DATEPART(DD,field_02_13) > 15 THEN ''15'' ELSE ''01'' END','','TPOLADDH','BATCHBILLDAY','','',3.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','OriginalPol','','TPOLADDH','POLNOPRV','','',3.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_27','','TPOLADDH','CLMSRVCOMP','','',3.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','','TPOLADDH','POLNO','','',3.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_16','','TPOLADDH','CLNTCODE','','',3.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_6','AE_id','','TPOLADDH','SRVAE','','',3.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','','TPOLADDH','RCDDTSTMP','DATETIME','',3.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_32','','TPOLADDH','TEAMCD','','',3.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_BranchInf','SecCity','','TPOLADDH','COUNTYCODE','','',3.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_BranchInf','RIGHT(BranCod_id,3)','','TPOLADDH','BRANCHCODE','','',3.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_34','','TPOLADDH','SUBMITDTE','','',3.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','','TPOLYEAR','POLNO','','',3.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_13','','TPOLYEAR','POLDTFR','DATETIME','',3.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','DATEADD(DAY,-1,Dateadd(year,1,field_02_13))','','TPOLYEAR','POLDTTO','DATETIME','',3.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_13','','TPOLYEAR','ANNVDATE','DATETIME','',3.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','','TPOLYEAR','RCDDTSTMP','DATETIME','',3.10)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','','TPOLNOTE','POLNO','','',9.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','','TPOLNOTE','DATESTMP','DATETIME','',9.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_5','CONCAT( N''团体员工人: '',field_5_1,char(13),
N''总共参保人: '',field_5_2 ,char(13),
N''未能全员参保原因: '' ,field_5_3,char(13), 
N''未能全员参保原因详情: '',field_5_7,char(13),
N''单证编号: ''    ,field_5_4,char(13), 
N''版本号: '',field_5_5,char(13), 
N''溢缴保费处理 抵缴续期保费退还缴费账户: '' ,field_5_6)','','TPOLNOTE','NOTE','','',9.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','','TPOLNOTE','RCDDTSTMP','DATETIME','',9.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_6','','TWIP','PRSPOLNO','','',10.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','Request_date','','TWIP','TRANSDATE','DATETIME','',10.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_16','teflow_30319_9.id','TMEMBER','CLNTCODE','','',11.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_1','id','TMEMBER','CERTNO','','',11.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_13','teflow_30319_9.id','TMEMBER','EFFDATE','DATETIME','',11.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_01','CONVERT(CHAR(10),Request_date,120)','teflow_30319_9.id','TMEMBER','CHGEFFDT','DATETIME','',11.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_2','id','TMEMBER','NAMELAST','','',11.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_02','field_02_13','teflow_30319_9.id','TMEMBER','INIEFFDT','','',11.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_17','id','TMEMBER','SUBOFFCODE','','',11.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_9','id','TMEMBER','DOB','DATETIME','',11.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_8','id','TMEMBER','SEX','','',11.00)
INSERT INTO [TNovaFieldMapping] ([form_system_id],[from_table],[from_field],[Mul_Field],[to_table],[to_field],[datetype],[key_field],[order])VALUES(30319,'teflow_30319_9','field_9_7','id','TMEMBER','IDENTTYPE','','',11.00)
DELETE FROM TNovaProcess WHERE form_system_id = 30319
INSERT INTO [TNovaProcess] ([form_system_id],[current_node_Id],[process_sp],[error_code],[ORDERBY])VALUES(30319,25,'NovaUspClearError','E005','')
INSERT INTO [TNovaProcess] ([form_system_id],[current_node_Id],[process_sp],[error_code],[ORDERBY])VALUES(30319,26,'NovaUspFLAKConvert4','E006','0')
INSERT INTO [TNovaProcess] ([form_system_id],[current_node_Id],[process_sp],[error_code],[ORDERBY])VALUES(30319,26,'NovaUspConvertXML','E001','1')
DELETE FROM TNovaProductMapping WHERE form_system_id = 30319
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','001','计划1(有医保)','FLAK4','福乐安康4.0','001','计划1','Y',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','002','计划2(有医保)','FLAK4','福乐安康4.0','002','计划1','Y',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','003','计划3(有医保)','FLAK4','福乐安康4.0','003','计划1','Y',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','004','计划4(有医保)','FLAK4','福乐安康4.0','004','计划1','Y',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','005','计划5(有医保)','FLAK4','福乐安康4.0','005','计划1','Y',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','006','计划6(有医保)','FLAK4','福乐安康4.0','006','计划1','Y',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','007','计划7(有医保)','FLAK4','福乐安康4.0','007','计划1','Y',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','008','计划8(有医保)','FLAK4','福乐安康4.0','008','计划1','Y',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','009','计划9(有医保)','FLAK4','福乐安康4.0','009','计划1','Y',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','010','计划10(有医保)','FLAK4','福乐安康4.0','010','计划1','Y',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','011','计划11(有医保)','FLAK4','福乐安康4.0','011','计划1','Y',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','012','计划12(有医保)','FLAK4','福乐安康4.0','012','计划1','Y',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','013','计划1(无医保)','FLAK4','福乐安康4.0','013','计划1','N',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','014','计划2(无医保)','FLAK4','福乐安康4.0','014','计划1','N',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','015','计划3(无医保)','FLAK4','福乐安康4.0','015','计划1','N',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','016','计划4(无医保)','FLAK4','福乐安康4.0','016','计划1','N',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','017','计划5(无医保)','FLAK4','福乐安康4.0','017','计划1','N',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','018','计划6(无医保)','FLAK4','福乐安康4.0','018','计划1','N',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','019','计划7(无医保)','FLAK4','福乐安康4.0','019','计划1','N',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','020','计划8(无医保)','FLAK4','福乐安康4.0','020','计划1','N',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','021','计划9(无医保)','FLAK4','福乐安康4.0','021','计划1','N',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','022','计划10(无医保)','FLAK4','福乐安康4.0','022','计划1','N',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','023','计划11(无医保)','FLAK4','福乐安康4.0','023','计划1','N',30319)
INSERT INTO [TNovaProductMapping] ([NOVA_PRODCODE],[NOVA_PRODCODE_Local],[NOVA_BENPLNCD],[NOVA_BENPLNCD_Local],[PRODCODE],[PRODCODE_Local],[BENPLNCD],[BENPLNCD_Local],[SHIP],[form_System_id])VALUES('FLAK4','福乐安康4.0','024','计划12(无医保)','FLAK4','福乐安康4.0','024','计划1','N',30319)