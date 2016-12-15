if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[poef_wkf_copy_flow]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[poef_wkf_copy_flow]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO






CREATE PROCEDURE [dbo].[poef_wkf_copy_flow]
@flowId       int
 AS
      Declare @newFlowId  int
       --1.copy the workflow base information
       insert into teflow_wkf_define(flow_name,description,form_system_id,company_id,after_handle_url) select  'COPY_'+flow_name,description,0,company_id,after_handle_url from teflow_wkf_define where flow_id=@flowId
       --get the new flowId  
       select @newFlowId = @@IDENTITY
       
       --2.copy all nodes information
       Declare @nodeId varchar(10)
       Declare @nodeType char(1)
       Declare @preNodeId varchar(50)
       Declare @nodeName varchar(50)
       Declare @limitedHours Numeric(18,2)
       Declare @hasRule char(1)
       Declare @ruleId int
       Declare @approverGroupId varchar(100)
       Declare @approverStaffCode varchar(100)
       Declare @positionX varchar(10)
       Declare @positionY varchar(10)
       Declare @nodeAlias varchar(100)
       Declare @updateSectionFields varchar(1000)
       Declare @fillSectionFields varchar(1000)

      declare my_cursor cursor  for select node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,
                    position_x,position_y,node_alias,update_section_fields,fill_section_fields     
                    from teflow_wkf_detail where flow_id=@flowId
      open my_cursor
      fetch next from my_cursor into @nodeId,@nodeType,@preNodeId,@nodeName,@limitedHours,@hasRule,@ruleId,@approverGroupId,@approverStaffCode,@positionX,@positionY,@nodeAlias,@updateSectionFields,@fillSectionFields
      while(@@fetch_status=0)
          begin
                insert into teflow_wkf_detail(flow_id,node_id,node_type,pre_node_id,node_name,limited_hours,has_rule,rule_id,approver_group_id,approver_staff_code,
                    position_x,position_y,node_alias,update_section_fields,fill_section_fields ) 
                values(@newFlowId,@nodeId,@nodeType,@preNodeId,@nodeName,@limitedHours,@hasRule,@ruleId,@approverGroupId,@approverStaffCode,@positionX,@positionY,@nodeAlias,@updateSectionFields,@fillSectionFields)

                fetch next from my_cursor into @nodeId,@nodeType,@preNodeId,@nodeName,@limitedHours,@hasRule,@ruleId,@approverGroupId,@approverStaffCode,@positionX,@positionY,@nodeAlias,@updateSectionFields,@fillSectionFields
          end
      close my_cursor
      deallocate my_cursor

      --3. copy node rule information
      Declare @beginNodeId varchar(10)
      Declare @endNodeId    varchar(10)
      Declare @sectionId       varchar(10)
      Declare @fieldId             varchar(50)
      Declare @compareType char(2)
      Declare @compareValue varchar(50)
      Declare @logicType varchar(4)
      Declare @compareLabel varchar(100)
      Declare @fieldLabel varchar(200)
      Declare @isFunction char(1)
      Declare @subSql varchar(500)

      Declare rule_cursor cursor  for select begin_node_id,end_node_id,section_id,field_id,compare_type,compare_value,logic_type,compare_label,field_label,is_function,sub_sql from teflow_wkf_detail_rule where flow_id=@flowId
      open rule_cursor
      fetch next from rule_cursor into @beginNodeId,@endNodeId,@sectionId,@fieldId,@compareType,@compareValue,@logicType,@compareLabel,@fieldLabel,@isFunction,@subSql
      while(@@fetch_status=0)
         begin
             insert into teflow_wkf_detail_rule(flow_id,begin_node_id,end_node_id,section_id,field_id,compare_type,compare_value,logic_type,compare_label,field_label,is_function,sub_sql)
                values(@newFlowId, @beginNodeId,@endNodeId,@sectionId,@fieldId,@compareType,@compareValue,@logicType,@compareLabel,@fieldLabel,@isFunction,@subSql)
             
               fetch next from rule_cursor into @beginNodeId,@endNodeId,@sectionId,@fieldId,@compareType,@compareValue,@logicType,@compareLabel,@fieldLabel,@isFunction,@subSql
         end
      close rule_cursor
      deallocate rule_cursor
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

