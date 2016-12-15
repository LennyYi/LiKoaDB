if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[poef_wkf_getFlowName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
     drop procedure [dbo].[poef_wkf_getFlowName]
GO
/*********************** REVISION LOG: ***********************************
Version			Date			Revised by				Remark
1.0				20150304		Sting Wu				initial
**************************************************************************/
CREATE PROCEDURE [dbo].[poef_wkf_getFlowName]
(@form_system_id int)

AS
BEGIN
SET NOCOUNT ON


select node_name ndName from teflow_wkf_detail t1 
inner join teflow_wkf_define t2 on t1.flow_id = t2.flow_id and t2.form_system_id = @form_system_id
	and t1.node_alias not like '%ErrorHandle%' and t1.node_alias not like  '%WaitHandle%'
	and t1.node_alias <>'' order by t1.node_alias 

END
