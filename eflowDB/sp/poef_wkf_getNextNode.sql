if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[poef_wkf_getNextNode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[poef_wkf_getNextNode]
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/*************************
  poef_wkf_getNextNode
--------------------------
  @version: 2010-09-17
*************************/

CREATE PROCEDURE [dbo].[poef_wkf_getNextNode]
@form_system_id                 int,             --��������ʶ
@current_node_Id                varchar(10),
@request_no                     varchar(30),
@current_processor              varchar(10), --��ǰ������
@nextNodeId              	varchar(50)   OUTPUT,
@approverGroupId      		varchar (100) OUTPUT,
@approverStaffCode    		varchar (100) OUTPUT,
@origin_processor			varchar(300) = ''
AS
  Declare @flowId int
  Declare @conditionType char(1)
  Declare @tempDefaultNodeId   varchar(10)

  select @tempDefaultNodeId=''  
  select @conditionType='1'
  --0.��ȡ�ñ�������ʹ�õ�����id
  select   @flowId = flow_id from teflow_wkf_define where form_system_id = @form_system_id

  if(@flowId>0)
  begin 
            --2.��¼��teflow_wkf_process
            --��ȡ��һ���ڵ������������1�������ʾ���ڷ�֧����Ҫ���������ж�ѡ����ȷ�ķ�֧
            Declare @nodeCount int
            select @nodeCount = count(node_id) from   teflow_wkf_detail where flow_id = @flowId and (pre_node_id = @current_node_Id or pre_node_id like '%,'+@current_node_Id or pre_node_id like @current_node_Id+',%' or pre_node_id like '%,'+@current_node_Id+',%')
            --print @nodeCount
            if(@nodeCount>1)
            begin
                         Declare @tempNodeId  varchar(10)
                         Declare @tempApproverGroupId      varchar (100)
                         Declare @tempApproverStaffCode    varchar (200)
                         Declare rule_cursor_1 cursor  for select node_id,approver_group_id,approver_staff_code from teflow_wkf_detail where  flow_id = @flowId and (pre_node_id = @current_node_Id or pre_node_id like '%,'+@current_node_Id or pre_node_id like @current_node_Id+',%' or pre_node_id like '%,'+@current_node_Id+',%') order by node_id asc
                         open rule_cursor_1
                         fetch next from rule_cursor_1 into @tempNodeId,@tempApproverGroupId,@tempApproverStaffCode
                         while(@@fetch_status=0)
                         begin
                                  Declare @condSectionId varchar(20)
                                  Declare @condFieldId      varchar(20)
                                  Declare @condCompareType  varchar(10)
                                  Declare @condCompareValue  varchar(100)
                                  Declare @condLogicType varchar(10),@condLogicType_pre  varchar(10)
                                  Declare @isFunction    char(1)
                                  Declare @condTableName varchar(100)
                                  Declare @condStr       varchar(2000)
                                  Declare @subSQL  varchar(500)
                                  select @condStr = ''
                                  select @subSQL = ''
                                  --���conditionType=1���ȡ��ǰ��ȡ�ڵ������ķ�ʽ; ��������µķ�ʽ����subSQL�б����sql��ȡ)��2008-08-06��
                                  select top 1 @subSQL=sub_sql,@conditionType=condition_type from 
                                    (select * from
                                      teflow_wkf_detail_rule where flow_id = @flowId and begin_node_id = @current_node_Id and end_node_id = @tempNodeId
                                     ) tempTable

                                  select @conditionType='1' -- by Wincent Xiao, 1/6/2009, ǿ����������SQL
				  if ( @conditionType='1' ) 
                                  begin
                                        --��ȡ�ýڵ������
                                       DECLARE cond_cursor_1  cursor  for  select section_id,field_id,compare_type,compare_value,logic_type,is_function from teflow_wkf_detail_rule where flow_id = @flowId and begin_node_id = @current_node_Id and end_node_id = @tempNodeId --order by compare_value desc
                                       OPEN cond_cursor_1                                  
                                       FETCH NEXT FROM cond_cursor_1 INTO @condSectionId,@condFieldId,@condCompareType,@condCompareValue,@condLogicType,@isFunction
                                       While(@@fetch_status=0)
                                       Begin
                                                select @condTableName = table_name from teflow_form_section where form_system_id=@form_system_id and section_id=@condSectionId
                                                select @condCompareType = case @condCompareType when '>' then '>'  when '>=' then '>=' when '=' then '=' when '<' then '<' when '<=' then '<='  when 'like' then 'like' when 'not like' then 'not like' when '<>' then '<>' else '=' end
                                                select @condLogicType = case @condLogicType when '01' then 'and' when '02' then 'or' else 'and' end
                                                
                                                --����Ǻ���������Ҫ���ú������㣻������Ҫ
                                                if (@isFunction='1')
                                                begin
                                         	       if(@condCompareType='like' or @condCompareType='not like')
                                                           select  @condCompareValue = '''' + '%' + @condCompareValue + '%' + ''''
                                                       else
                                                           select  @condCompareValue = '''' + @condCompareValue + ''''
                                                end
                                                else
                                                begin
                                                       if(@condCompareValue='01') -- getAmountByTitle ---- 01
                                                       begin
                                                           --IT1161 begin 
	                                                       if(isnull(@origin_processor,'')='')
	                                                       begin
	                                                       	 select @condCompareValue = approve_amount from teflow_title_approve_standard where title_id = (select title_id from tpma_staffbasic where staff_code = @current_processor and status='A')
	                                                       end
	                                                       else
	                                                       begin
	                                                         select @condCompareValue = approve_amount from teflow_title_approve_standard where title_id = (select title_id from tpma_staffbasic where staff_code = @origin_processor and status='A')
	                                                       end
	                                                       --IT1161 end                                                       
	                                                   end
                                                end

                                                if(isnull(@condLogicType,'')='') 
                                                       select @condLogicType = ' and '
                                                if(isnull(@condStr,'')='')
						begin 
	                                               select @condStr =  ' request_no in (select request_no from ' + @condTableName + ' where ' + @condFieldId + ' ' + @condCompareType  + @condCompareValue + ')'
--                                                       select @condStr =  'select request_no from ' + @condTableName + ' where ' + @condFieldId + ' ' + @condCompareType  + @condCompareValue + ' '
                                                       select @condLogicType_pre =  @condLogicType
						end
                                                else
						begin
                                                       select @condStr = @condStr +' ' + @condLogicType_pre + ' request_no in (select request_no from ' + @condTableName + ' where ' + @condFieldId + '  ' + @condCompareType + '  ' + @condCompareValue + ')'
--                                                       select @condStr = @condStr +' ' + @condLogicType_pre + ' ' + @condFieldId + ' ' + @condCompareType + ' ' + @condCompareValue + ' '
                                                       select @condLogicType_pre =  @condLogicType
						end

                                                FETCH NEXT FROM cond_cursor_1 INTO @condSectionId,@condFieldId,@condCompareType,@condCompareValue,@condLogicType,@isFunction
                                        End                                     
                                        CLOSE cond_cursor_1
                                        Deallocate cond_cursor_1
                                  end
                                  else ---11111
                                  begin
                                        if(isnull(@subSQL,'')<>'')
                                            select @condStr = ' request_no in (' + @subSQL + ')'
                                        else
                                            select @tempDefaultNodeId=@tempNodeId
                                  end



                                  --print @condStr
                                  if(@condStr<>'')
                                  begin
                                          --select @condStr = ' select count(*) from teflow_wkf_process where 1=1 and request_no='+'''' + @request_no+'''' + @condStr
                                          select @condStr = ' select count(*) from teflow_wkf_process where 1=1 and request_no='+'''' + @request_no+'''' +  ' and (' + @condStr + ')'

                                          create table #temp_count(r_num int)
                                          select @condStr = 'insert into #temp_count(r_num) ' + @condStr
                                          exec(@condStr)
                                          Declare @tCount int
                                          select @tCount = r_num from #temp_count
                                          --print 'count='+@tCount
                                          --�ҵ������������Ľڵ�
                                          if(@tCount>0)
                                          begin
                                                   select @nextNodeId =@tempNodeId,@approverGroupId=@tempApproverGroupId,@approverStaffCode=@tempApproverStaffCode
                                                   break; 
                                          end
                                          drop table #temp_count
                                 end
                                 select @condSectionId='',@condFieldId='',@condCompareType='',@condCompareValue=''
                                 select @condStr = ''
                                 --select @subSQL=''
                                 fetch next from rule_cursor_1 into @tempNodeId,@tempApproverGroupId,@tempApproverStaffCode
                             end
                         close rule_cursor_1
                         deallocate rule_cursor_1

                        -- print @nextNodeId

                        --���û���ҵ����������ĺ����ڵ㣬���Ȳ����Ƿ�������û�������ķ�֧������У���ѡ��÷�֧��Ϊ��һ���ڵ� (2007-09-26)
                        if(isnull(@nextNodeId,'')='') 
                        begin
                           if(@conditionType='1')  
                               select  @nextNodeId =node_id,@approverGroupId=approver_group_id,@approverStaffCode=approver_staff_code
                                      from teflow_wkf_detail where flow_id = @flowId and (pre_node_id like '%,'+@current_node_id+',%' or pre_node_id like @current_node_id+',%' or pre_node_id like '%,'+@current_node_id or pre_node_id=@current_node_id) and node_id not in (select end_node_id  from teflow_wkf_detail_rule where flow_id = @flowId AND begin_node_id = @current_node_id)
                           else
                                -- select @nextNodeId=@tempDefaultNodeId   
                               select  @nextNodeId =node_id,@approverGroupId=approver_group_id,@approverStaffCode=approver_staff_code
                                      from  teflow_wkf_detail where flow_id = @flowId and node_id=@tempDefaultNodeId
                        end
                        
                        --���û���ҵ����������ĺ����ڵ㣬����ֵ��Ϊ'-999'
                        if(isnull(@nextNodeId,'')='') 
                              select @nextNodeId = '-999'
            end
            else--ֻ����һ�������ڵ�
            begin
                   --��ȡ��һ���ڵ�������Ϣ
                   select @nextNodeId = node_id, @approverGroupId = approver_group_id, @approverStaffCode = approver_staff_code
                              from teflow_wkf_detail where flow_id = @flowId and (pre_node_id = @current_node_Id or pre_node_id like '%,'+@current_node_Id or pre_node_id like @current_node_Id+',%' or pre_node_id like '%,'+@current_node_Id+',%')
                              
                   --���û���ҵ����������ĺ����ڵ㣬����ֵ��Ϊ'-999'
                   if(isnull(@nextNodeId,'')='') 
                       select @nextNodeId = '-999'
            end     
     	--print @nextNodeId
  end
GO

