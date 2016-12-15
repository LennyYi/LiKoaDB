if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[poef_wkf_getPersonalFlag]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [dbo].[poef_wkf_getPersonalFlag]
GO
/*********************** REVISION LOG: ***********************************
Version			Date			Revised by				Remark
1.0				20150304		Sting Wu				initial
**************************************************************************/
CREATE PROCEDURE [dbo].[poef_wkf_getPersonalFlag]
(@staff_code varchar(10))
AS
BEGIN
SET NOCOUNT ON
SELECT distinct a.request_no,a.open_flag into #tempTable2
FROM teflow_wkf_process a 
INNER JOIN teflow_wkf_define b ON a.flow_id = b.flow_id and 
		(','+rtrim(a.current_processor)+','  like '%'+@staff_code+'%' 
		or ','+rtrim(a.invited_expert)+',' like '%[,/]'+@staff_code+'[,/]%') 
   and (a.[status]<>'03' or (a.[status]='03' and a.node_id<>'0'))  and a.[status]<>'00'
   and a.open_flag = 0
INNER JOIN teflow_form c ON b.form_system_id = c.form_system_id  
INNER JOIN teflow_wkf_detail d ON a.flow_id = d.flow_id AND a.node_id = d.node_id 


select COUNT(*) as COUNTNO from #tempTable2

drop table #tempTable2

END