if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[poef_formmgr_copy_form]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[poef_formmgr_copy_form]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO






CREATE PROCEDURE [dbo].[poef_formmgr_copy_form] 
@formSystemId         int
AS
     Declare @newFormSystemId    int
     --1.Copy form base information
     insert into teflow_form(form_id,form_name,form_type,form_subtype,form_description,status,create_date,org_id,action_type,action_message,pre_validation_url,after_save_url)
            select 'COPY_'+form_id,form_name,form_type,form_subtype,'COPY FORM: ' + form_id,1,getDate(),org_id,action_type,action_message,pre_validation_url,after_save_url from teflow_form where form_system_id = @formSystemId
     --get the new formSystemId
     select @newFormSystemId = @@IDENTITY
         
     --2. Copy form section information
     Declare @sectionId varchar(50)
     Declare @sectionType varchar(2)
     Declare @sectionRemark varchar(100)
     Declare @sectionTableName varchar(30)
     Declare @sectionOrderId int
     Declare section_cursor cursor  for select section_id,section_type,section_remark,order_id,'teflow_' + LTrim(str(@newFormSystemId))+'_'+(section_id) from teflow_form_section where form_system_id = @formSystemId
     open section_cursor
      fetch next from section_cursor into @sectionId,@sectionType,@sectionRemark,@sectionOrderId,@sectionTableName
      while(@@fetch_status=0)
          begin
               insert into teflow_form_section(form_system_id,section_id,section_type,section_remark,table_name,order_id)
                      values(@newFormSystemId, @sectionId,@sectionType,@sectionRemark,@sectionTableName,@sectionOrderId)
 
               fetch next from section_cursor into @sectionId,@sectionType,@sectionRemark,@sectionOrderId,@sectionTableName
          end
      close section_cursor
      deallocate section_cursor
      
      --3.Copy form field information
      Declare @fieldId   varchar(50)
      Declare @fieldLabel varchar(50)
      Declare @fieldType int
      Declare @isRequired int
      Declare @dataType int
      Declare @fieldLength int
      Declare @sourceType int
      Declare @orderId int
      Declare @decimalDigits int
      Declare @highLevel int
      Declare @isMoney int
      Declare @isSingleRow int
      Declare @controlsWidth int
      Declare @controlsHeight int
      Declare @fieldComments varchar(500)
      Declare @commentContent varchar(1000)
      Declare @isReadonly int
      Declare @defaultValue varchar(50)
      Declare @columnWidth int
      Declare @eventClick varchar(100)
      Declare @eventDbClick varchar(100)
      Declare @eventOnfocus varchar(100)
      Declare @eventOnblur varchar(100)
      Declare @eventOnchange varchar(100)
      
      Declare field_cursor cursor  for select section_id,field_id,field_label,field_type,is_required,data_type,field_length,source_type,order_id,decimal_digits,high_level,
                   is_money,is_singlerow,controls_width,controls_height,field_comments,comment_content,is_readonly,default_value,column_width,event_click,event_dbclick,event_onfocus,event_onblur,event_onchange  from teflow_form_section_field where form_system_id = @formSystemId
      Open field_cursor
      Fetch Next from field_cursor Into @sectionId,@fieldId,@fieldLabel,@fieldType,@isRequired,@dataType,@fieldLength,@sourceType,@orderId,@decimalDigits,@highLevel,@isMoney,@isSingleRow,@controlsWidth,
                                                            @controlsHeight,@fieldComments,@commentContent,@isReadonly,@defaultValue,@columnWidth,@eventClick,@eventDbClick,@eventOnfocus,@eventOnblur,@eventOnchange
      while(@@fetch_status=0)
          begin
               insert into teflow_form_section_field(form_system_id,section_id,field_id,field_label,field_type,is_required,data_type,field_length,source_type,order_id,decimal_digits,high_level,
                                         is_money,is_singlerow,controls_width,controls_height,field_comments,comment_content,is_readonly,default_value,column_width,event_click,event_dbclick,event_onfocus,event_onblur,event_onchange)
                   values(@newFormSystemId,@sectionId,@fieldId,@fieldLabel,@fieldType,@isRequired,@dataType,@fieldLength,@sourceType,@orderId,@decimalDigits,@highLevel,
                             @isMoney,@isSingleRow,@controlsWidth,@controlsHeight,@fieldComments,@commentContent,@isReadonly,@defaultValue,@columnWidth,@eventClick,@eventDbClick,@eventOnfocus,@eventOnblur,@eventOnchange)
               
               Fetch Next from field_cursor Into @sectionId,@fieldId,@fieldLabel,@fieldType,@isRequired,@dataType,@fieldLength,@sourceType,@orderId,@decimalDigits,@highLevel,@isMoney,@isSingleRow,@controlsWidth,
                                                            @controlsHeight,@fieldComments,@commentContent,@isReadonly,@defaultValue,@columnWidth,@eventClick,@eventDbClick,@eventOnfocus,@eventOnblur,@eventOnchange
          end
      close field_cursor
      deallocate field_cursor
    --4.Copy all select option list of the form's fields
    insert into teflow_field_basedata(master_id,form_system_id,section_id,field_id)  select master_id,@newFormSystemId,section_id,field_id from teflow_field_basedata where form_system_id=@formSystemId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

