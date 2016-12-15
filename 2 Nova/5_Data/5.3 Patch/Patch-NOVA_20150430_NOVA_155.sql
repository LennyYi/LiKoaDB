UPDATE TNovaFieldMapping SET from_field="
CONCAT(N'团体员工人:',field_5_1,char(13),
N'总共参保人:',field_5_2 ,char(13),
N'未能全员参保原因:' ,field_5_3,char(13), 
N'未能全员参保原因详情:',field_5_7,char(13),
N'单证编号:',field_5_4,char(13), 
N'版本号:',field_5_5,char(13), 
N'溢缴保费处理 抵缴续期保费退还缴费账户:' ,field_5_6,CHAR(13),replace(stuff(( select ';' + name from (
	 select name=(N'保险计划:' + isnull(rtrim(t2.NOVA_PRODCODE_Local),'') + N' - ' 
		+ isnull(rtrim(t3.NOVA_BENPLNCD_Local),'') + ';' + N'被保险人职业内容/职业描述:' + field_4_2)
	 from teflow_20264_4 t1
	left join (select distinct NOVA_PRODCODE,NOVA_PRODCODE_Local from TNovaProductMapping) t2 on t1.Product_id = t2.NOVA_PRODCODE 
	left join TNovaProductMapping t3 on t1.Product_id = t3.NOVA_PRODCODE and t1.Plan_id = t3.NOVA_BENPLNCD 
	 where t1.request_no = teflow_20264_5.request_no) T for xml path('')),1,1,''),';',CHAR(13)),CHAR(13),
N'等候期(日):',(select field_02_24 from teflow_20264_02 where request_no = teflow_20264_5.request_no),char(13),
N'付款方式:' , (select field_2_9 + ' - ' + (select option_label from teflow_base_data_detail where master_id = '10165' and option_value = teflow_20264_2.field_2_9) from teflow_20264_2 where request_no = teflow_20264_5.request_no))"
WHERE form_system_id=20264 AND to_table='TPOLNOTE' AND to_field='NOTE'
