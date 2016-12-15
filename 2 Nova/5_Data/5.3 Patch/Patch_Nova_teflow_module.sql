

delete from teflow_module where module_name='menu.design.report_design'
declare @num int

select @num = max(module_id)+1 from teflow_module

insert teflow_module(module_id,module_name,parent_id,target_url,order_id,remark,image_file_name)
values(@num,'menu.design.report_design',3,'reportManageAction.it?method=manageReport',3,'Report Design','fd.gif')