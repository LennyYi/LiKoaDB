if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[poef_wkf_node_process]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[poef_wkf_node_process]
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*************************
  poef_wkf_node_process
--------------------------
  @version: 2014-07-11
*************************/

CREATE PROCEDURE [dbo].[poef_wkf_node_process] 
@form_system_id            int,                 --所属表单标识
@request_no                varchar(30),         --申请表单的流水号
@current_node_Id           varchar(10),         --当前节点id
@handle_staff_code         varchar(10),         --处理人的staff_code
@handle_type               char(2),             --处理类型
@handle_comments           varchar(500),        --处理意见
@request_staff_code        varchar(10),         --表单申请人的code
@nodeHandleHours           float,               --Node Handle Hours
@nodeOverduHours           float,               --Node Overdue Hours
@attach_file               varchar(200),        --Attached File
@reject_to_node_id         varchar(10),         --如果是Reject操作，则该参数表示需要Reject到的节点id
@nextApprover              varchar(200),        --当前处理的人可以手动设定下一个节点的处理人（如果不为空，则选择了，那么将使用该人做下一个节点的处理人）.只有approve 操作时，该参数才有效
												--Length:10->200
@nextNodeId                varchar(50)  OUTPUT
 AS
     Declare @flowId  int
     Declare @nextHandleStaff    varchar(300)
     Declare @status char(2)
     Declare @approverGroupId      varchar (100)
     Declare @approverStaffCode    varchar (300)
     Declare @handleStaff                varchar(300)
     Declare @teamCode                  varchar(10)
     Declare @dealTime                    datetime
     Declare @nodeName            varchar(100)
     Declare @remain_approvers		int
     declare @next_node_approvers	int
     declare @node_type 			char(1)
     declare @tmpcnt 		int
     declare @tmppos 		int
     
    --eclare @reject_to_node_id varchar(10)
   
    SELECT @dealTime = GETDATE()

    set @nextHandleStaff = ''
     set @handleStaff = ''

     if(@handle_type='01')  --submit
            set @status = '01' --submitted
     else if(@handle_type='03')  --approve
            set @status = '02' --approved
    else if(@handle_type='04') --reject
           set @status='03'   --rejected

    --首先需要将当前所邀请的专家清空。
   --update teflow_wkf_process set  invited_expert = '' where request_no = @request_no

    --计算该环节的超时时间。当然，如果该环节没有设定处理时限，则超时时间为0
    --select @nodeOverduHours = CASE when d.limited_hours>0 then  Round(((d.limited_hours * 60 - DATEDIFF(minute, a.receiving_date, GETDATE()))/60.0),2) else  0 end
   --         from teflow_wkf_process a, teflow_wkf_detail d   where a.flow_id = d.flow_id AND a.node_id = d.node_id and a.request_no = @request_no

     --获取当前处理记录中的字段origin_processor，is_deputy作为当前处理轨迹记录中的该字段的值
      Declare @temp_processor varchar(10)
      Declare @is_deputy char(1)
      Declare @origin_processor varchar(300)
      set @is_deputy = '0'
      select @is_deputy=is_deputy, @origin_processor=origin_processor, @remain_approvers=isnull(remain_approvers_num,0) from teflow_wkf_process where request_no=@request_no

     --add By Robin 2008-06-02: 如果当前节点存在代理人，并且原来的处理人就只有一人（存在多人的情况暂不考虑），则在处理意见中增加这个标识
     if(@is_deputy='1' and isnull(@origin_processor,'')<>'' and len(rtrim(@origin_processor))<=10)
            begin
               declare @originProcessor varchar(50)
               select @originProcessor=staff_name from tpma_staffbasic where staff_code = @origin_processor 
               select @handle_comments = @handle_comments + ' (Dealed with it on behalf of '+ltrim(rtrim(@originProcessor))+' ) '
            end

    --如果是reject操作（@handle_type='04'），则更新当前的处理实例的当前处理人为表单申请人，状态为“reject(03)”,并且记录操作轨迹，然后结束退出
    --add 2008-06-02 Robin :并且需要更新两个字段: is_deputy='0', origin_processor = ''
    if(@handle_type='04')
      begin
              select   @flowId = flow_id from teflow_wkf_define where form_system_id = @form_system_id
              select @nodeName=node_name from teflow_wkf_detail where flow_id=@flowId and node_id=@current_node_Id
             --如果@reject_to_node_id为空，则表示reject到开始节点； 如果是reject到begin节点，则就是到开始节点
            if(isnull(@reject_to_node_id,'')<>'' and @reject_to_node_id<>'0') 
                begin
                     Declare @approveStaffCode  varchar(300)
                     Declare @approveGroupId     varchar(100)
                    
                     select @approveStaffCode=approver_staff_code,@approveGroupId=approver_group_id from teflow_wkf_detail where flow_id=@flowId and node_id = @reject_to_node_id

                     exec poef_getNextProccessor @approveGroupId,@approveStaffCode,@form_system_id,@flowId,@request_no,@reject_to_node_id,'-',@nextHandleStaff OUTPUT,@nextNodeId OUTPUT,@origin_processor OUTPUT
                     
                     --Multi-approver的情况，计算有几个处理人 2013-4-11
                     select @tmpcnt = 1, @tmppos = 1
                     while(@tmppos<Len(@nextHandleStaff) and @tmppos>0)
                     begin
                     	select @tmppos=Charindex(',' ,@nextHandleStaff, @tmppos) 
                     	if @tmppos>0                  		
                 			select @tmpcnt = @tmpcnt+1, @tmppos = @tmppos+1
                     end
                     
                     update teflow_wkf_process set status = @status,previous_processor = @handle_staff_code,current_processor = @nextHandleStaff,receiving_date = @dealTime,node_id =@reject_to_node_id ,open_flag='0',is_deputy='0',origin_processor='',
                     		remain_approvers_num = @tmpcnt
                     where request_no = @request_no 
                     
                      select @nextNodeId=@reject_to_node_id
                end
            else  --reject到开始节点
                update teflow_wkf_process set status = @status,previous_processor = @handle_staff_code,current_processor = request_staff_code,receiving_date = @dealTime,node_id = '0',open_flag='0',is_deputy='0',origin_processor=''
                where request_no = @request_no 
           

            update teflow_wkf_process set handle_date = GETDATE() where request_no = @request_no 
            INSERT INTO teflow_wkf_process_trace(request_no,flow_id,node_id,current_processor,handle_date,handle_type,handle_comments,is_deputy,origin_processor,handle_hours,overdue_hours,attach_file,node_name)
                      SELECT @request_no,@flowId,@current_node_Id,@handle_staff_code,GETDATE() ,@handle_type,@handle_comments,@is_deputy,@origin_processor,@nodeHandleHours,@nodeOverduHours,@attach_file,@nodeName
         return
      end
 
    --如果不是第一次表单提交操作，则需要获取该表单的提交人code
    if(@handle_type<>'01' OR @request_staff_code is NULL)
             select @request_staff_code = request_staff_code from teflow_wkf_process where request_no = @request_no

             --将当前form表单申请人所属的所有上级team都查找到，保存到临时表#team_temp中
	create table #team_temp(team_code int NOT NULL)
	 --insert into test_team
              insert into #team_temp
		select tpma_team.team_code from tpma_team,tpma_staff 
		where  tpma_staff.staff_code = @request_staff_code   AND tpma_staff.team_code = tpma_team.team_code
		and tpma_team.status='A'	
		
	while @@rowcount > 0
	      insert into #team_temp
                    --insert into test_team
			select a.subordinate from tpma_team a
				where a.team_code in ( select team_code from   #team_temp)  -- #team_temp )
				  and a.subordinate not in ( select team_code from  #team_temp) --#team_temp )
				  and a.status='A'

    --0.获取该表单类型所使用的流程id
     select @flowId = flow_id from teflow_wkf_define where form_system_id = @form_system_id
     select @nodeName=node_name, @node_type=node_type from teflow_wkf_detail where flow_id=@flowId and node_id=@current_node_Id
     
	if(@handle_type='03' and @node_type='m' and @remain_approvers > 1)
	begin		
        UPDATE teflow_wkf_process SET previous_processor = @handle_staff_code,current_processor = replace(current_processor+',',@handle_staff_code+',',''),
               open_flag='0', handle_date=GETDATE(), remain_approvers_num=@remain_approvers-1
               WHERE request_no = @request_no and flow_id = @flowId
                        
		INSERT INTO teflow_wkf_process_trace(request_no,flow_id,node_id,current_processor,handle_date,handle_type,handle_comments,is_deputy,origin_processor,handle_hours,overdue_hours,attach_file,node_name)
               SELECT @request_no,@flowId,@current_node_Id,@handle_staff_code,GETDATE() ,@handle_type,@handle_comments,@is_deputy,@origin_processor,@nodeHandleHours,@nodeOverduHours,@attach_file,@nodeName
		select @nextNodeId = @current_node_Id
		return
	end 
     
     if(@flowId>0)
          begin 
               --2.记录表teflow_wkf_process
              --获取下一个节点数，如果大于1个，则表示存在分支，需要进行条件判断选择正确的分支
               Declare @nodeCount int
               select @nodeCount = count(node_id) from   teflow_wkf_detail where flow_id = @flowId and (pre_node_id = @current_node_Id or pre_node_id like '%,'+@current_node_Id or pre_node_id like @current_node_Id+',%' or pre_node_id like '%,'+@current_node_Id+',%')
              
               --获取下一个节点与其对应的处理人或组
               --2010-08-03 增加参数@origin_processor， 在最后
               if(@origin_processor<>null)
               	begin
               		exec poef_wkf_getNextNode @form_system_id,@current_node_id,@request_no,@handle_staff_code,@nextNodeId OUTPUT,@approverGroupId OUTPUT,@approverStaffCode OUTPUT,@origin_processor
               	end
               else            
				begin
					exec poef_wkf_getNextNode @form_system_id,@current_node_id,@request_no,@handle_staff_code,@nextNodeId OUTPUT,@approverGroupId OUTPUT,@approverStaffCode OUTPUT,''
				end 
                if(@nextNodeId='-1')
                   begin
                      set @status = '04'   --如果下一个节点是“结束节点”，则设置状态为“结束”
                      UPDATE teflow_wkf_process SET receiving_date = GETDATE(),previous_processor = @handle_staff_code,current_processor = '', origin_processor = '', node_id = '-1' ,status=@status, has_next_node = '0',open_flag='0'
                          WHERE request_no = @request_no and flow_id = @flowId

                      --1.记录表teflow_wkf_process_trace,设置操作类型为“completed”(05)
	              update teflow_wkf_process set handle_date = GETDATE() where request_no = @request_no 
                      INSERT INTO teflow_wkf_process_trace(request_no,flow_id,node_id,current_processor,handle_date,handle_type,handle_comments,is_deputy,origin_processor,handle_hours,overdue_hours,attach_file,node_name)
                            SELECT @request_no,@flowId,@current_node_Id,@handle_staff_code,GETDATE() ,'05',@handle_comments,@is_deputy,@origin_processor,@nodeHandleHours,@nodeOverduHours,@attach_file,@nodeName
                   end 
         
               else if(@nextNodeId='-999') --- 没有找到符合条件的后续节点
                  begin
                      --将teflow_wkf_process该form的处理 实例的字段‘has_next_node’修改成“-1”，表示没有合适的下一个节点
                      update teflow_wkf_process set has_next_node = '-1'  WHERE request_no = @request_no and flow_id = @flowId
                  end
               else
                  begin
                      --置标识表示找到了下一个节点
                      update teflow_wkf_process set has_next_node = '0'  WHERE request_no = @request_no and flow_id = @flowId

                      --1.记录表teflow_wkf_process_trace
	              update teflow_wkf_process set handle_date = GETDATE() where request_no = @request_no 
                      INSERT INTO teflow_wkf_process_trace(request_no,flow_id,node_id,current_processor,handle_date,handle_type,handle_comments,is_deputy,origin_processor,handle_hours,overdue_hours,attach_file,node_name)
                      SELECT @request_no,@flowId,@current_node_Id,@handle_staff_code,GETDATE() ,@handle_type,@handle_comments,@is_deputy,@origin_processor,@nodeHandleHours,@nodeOverduHours,@attach_file,@nodeName
                     --用来保存之前获取的下一个节点
                     Declare @tempNextNodeId   varchar(10)
                     select @tempNextNodeId = @nextNodeId
                     --获取下一个节点的处理人
                     exec poef_getNextProccessor @approverGroupId,@approverStaffCode,@form_system_id,@flowId,@request_no,@current_node_id,@handle_staff_code,@nextHandleStaff OUTPUT,@nextNodeId OUTPUT,@origin_processor OUTPUT
                     
                     --Multi-approver的情况，计算有几个处理人 2013-4-11
                     select @tmpcnt = 1, @tmppos = 1
                     while(@tmppos<Len(@nextHandleStaff) and @tmppos>0)
                     begin
                     	select @tmppos=Charindex(',' ,@nextHandleStaff, @tmppos) 
                     	if @tmppos>0                  		
                 			select @tmpcnt = @tmpcnt+1, @tmppos = @tmppos+1
                 		
                     end
                     --如果是存在多个后续节点的，则换成之前获取的下一个节点
                    if(@nodeCount>1)
                             select   @nextNodeId = @tempNextNodeId                   
                    
                    if(isnull(@nextApprover,'')<>'')  --如果手动选择了下一个节点的处理人，则使用其做下一个节点的处理者 2008-04-10
                          select @nextHandleStaff = @nextApprover
                     
                     --查找下一个处理人，是否存在设置了“代理人“，如果有，则设置标志为1
                     if(isnull(@origin_processor,'')<>'') 
                                  set @is_deputy = '1'
                     else
                                  set @is_deputy = '0'


                     if(@handle_type='01')
                        UPDATE teflow_wkf_process SET receiving_date = @dealTime,previous_processor = @handle_staff_code,current_processor = @nextHandleStaff,node_id = @nextNodeId ,
                                 status=@status,submission_date =  GETDATE(),is_deputy=@is_deputy,origin_processor=@origin_processor,open_flag='0',
                                 remain_approvers_num = @tmpcnt
                                       WHERE request_no = @request_no and flow_id = @flowId
                     else
                        UPDATE teflow_wkf_process SET receiving_date = @dealTime,previous_processor = @handle_staff_code,current_processor = @nextHandleStaff,node_id = @nextNodeId ,
                                 status=@status,is_deputy=@is_deputy,origin_processor=@origin_processor,open_flag='0',remain_approvers_num = @tmpcnt
                                       WHERE request_no = @request_no and flow_id = @flowId
                  
                   --add on 2007-10-19 : 检查下一个节点，如果下一个节点的处理人就是当前处理人（只有一个处理人），则系统自动处理掉该节点
                   --如果帮自己申请并提交，刚好下一个节点的处理人是自己且并非代理，则系统自动处理掉该节点
                   --如果下一个节点存在需要修改的section，则不能够让系统自动处理掉该节点
                   --如果下一个节点是auto-flow节点 (node_type='4'), 则系统自动skip该节点
                   --如果下一个节点是waiting节点 (node_type='a'), 则系统cannot skip该节点
                   --add on 2010-10-25 : 增加submitter<>requestor，且下一节点就是自动类型的情况
                     --根据CHO ePayment的需求，设置代理时，代理人批复自己的表单之前须邀请原审批人，所以不自动通过（保留@is_deputy='0'）
                    --if(@handle_type='03' or @handle_type='01' and @request_staff_code=@handle_staff_code and @is_deputy='0')
	                   --add on 2011-07-28 : 扩大自动处理的适用范围：当下一审批人在此前已经批准过该表单，且自那以后内容再无修改的情况
	                    if(@handle_type='03' or @handle_type='01' and @is_deputy='0')
	                    begin
	                        declare @updateSectionFields varchar(1000)
	                        declare @newSectionFields varchar(1000)
	                        declare @approvedTime datetime, @lastUpdateTime datetime, @lastCommentTime datetime
	                        select @updateSectionFields=update_section_fields,@newSectionFields=fill_section_fields, @node_type=node_type from teflow_wkf_detail where flow_id=@flowId and node_id = @nextNodeId
	                        select @approvedTime=MAX(handle_date) from teflow_wkf_process_trace where request_no=@request_no and current_processor=@nextHandleStaff and handle_type='03'
	                        
	                        select @lastUpdateTime=Submission_date from teflow_wkf_process where request_no=@request_no
	                        	and exists(select 1 from teflow_param_config where param_code='auto_approve_level' and CAST(param_value as int)<3)
	                        select @lastUpdateTime=update_date from teflow_wkf_process where request_no=@request_no
	                        	and exists(select 1 from teflow_param_config where param_code='auto_approve_level' and CAST(param_value as int)<2) 
	                        select @lastCommentTime=MAX(handle_date) from teflow_wkf_process_trace 
	                        	where request_no=@request_no and ((rtrim(isnull(handle_comments,''))<>'' and handle_type='07') or isnull(attach_file,'') not in ('','null')) 
	                        	and exists(select 1 from teflow_param_config where param_code='auto_approve_level' and CAST(param_value as int)<1) 
							select @lastUpdateTime='2099-12-31' from teflow_wkf_process where 
								exists(select 1 from teflow_param_config where param_code='auto_approve_level' and CAST(param_value as int)<0)	                        	

							--if ((@node_type <> 'a' and @handle_staff_code=@nextHandleStaff and isnull(@updateSectionFields,'')='' and isnull(@newSectionFields,'')='') or @node_type='4')
	                        if ((@node_type <> 'a' and @handle_staff_code=@nextHandleStaff and isnull(@updateSectionFields,'')='' and isnull(@newSectionFields,'')='') 
	                        	or @node_type='4'
	                        	or (@approvedTime is not null and @approvedTime > isnull(@lastUpdateTime, '1970-1-1') 
	                        		and @approvedTime > isnull(@lastCommentTime, '1970-1-1') 
	                        		and isnull(@updateSectionFields,'')='' and isnull(@newSectionFields,'')='')
	                        	)
							begin
								declare @nextNodeId2 varchar(50),@remark varchar(50)  
								if @node_type='4'
									select @remark='System automatically skip this auto-flow node '
								else
									select @remark='System automatically approve this node '
					
								if @handle_type='01'
									select @handle_type='03'
									
								if @handle_staff_code=@nextHandleStaff or isnull(@nextHandleStaff,'')=''
									exec poef_wkf_node_process @form_system_id,@request_no,@nextNodeId,@handle_staff_code,@handle_type,@remark,@request_staff_code,0,0,'','','',@nextNodeId2 OUTPUT
								else 
									exec poef_wkf_node_process @form_system_id,@request_no,@nextNodeId,@nextHandleStaff,@handle_type,@remark,@request_staff_code,0,0,'','','',@nextNodeId2 OUTPUT
								
							    select @nextNodeId=@nextNodeId2
						    end
                    end
               end 
                  
          end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
