if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[poef_getNextProccessor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[poef_getNextProccessor]
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/*************************
  poef_getNextProccessor
--------------------------
  @version: 2014-07-11
*************************/

CREATE PROCEDURE [dbo].[poef_getNextProccessor] 
@approverGroupId        varchar(100),
@approverStaffCode      varchar(300),
@form_system_id         int,
@flowId                 int,
@request_no             varchar(50),
@current_node_id        varchar(10),
@handle_staff_code      varchar(10),
@nextHandleStaff        varchar(300)  OUTPUT,
@nextNodeId             varchar(50)   OUTPUT,
@deputyOriginStaff      varchar(300)  OUTPUT
AS

begin
   -- Declare @nextHandleStaff   varchar(100)
   declare  @handleStaff        varchar(300)
   declare  @request_staff_code varchar(10)
   declare  @request_org_id varchar(10)
   declare  @temp_staff_code varchar(10)
   declare  @teamCode int   --当前form申请者所属的orgchart上的team
   declare  @preTeamCode int  
   declare  @orgChart char(1) --Y 表示属于orgchart上的team. N 表示不属于orchart上的team
   declare  @lastchar char(1)
   declare  @approverGroupType varchar(10)  --'01'-head office, '02'--branch, '03'---sub branch
   declare  @form_id varchar(50)
   declare  @form_org_id varchar(10)
   declare  @form_type_id char(2)
   declare @node_type char(1)

   if isnull(@flowId,'')=''   ------added by Wincent 09/20/2009  if flowid is null means the SP is only used to directly retrieve the next processor.
   begin
      select @nextHandleStaff = current_processor, @nextNodeId=node_id, @deputyOriginStaff=origin_processor from teflow_wkf_process where request_no = @request_no
      return
   end

   select @flowId=flow_id from teflow_wkf_process where request_no=@request_no	
   select @form_system_id=form_system_id from teflow_wkf_define where flow_id=@flowId
   select @handleStaff = ''
   select @nextNodeId = node_id from teflow_wkf_detail where flow_id = @flowId and pre_node_id = @current_node_Id


--Begin for the specified company flow instead of requester's company 1/20/2010

   declare @approverGroupId1  varchar(100),@approverStaffCode1 varchar(300),@nextNodeId1 varchar(50)

   if (@handle_staff_code = '-') --- Indicate the @current_node_id is used as the @nextNodeId
   begin
	   select @nextNodeId = @current_node_id
	   select @nextNodeId1 = @current_node_id
   end 
   --2010-08-03 增加参数@deputyOriginStaff IT1161 by Mario
   else if (@deputyOriginStaff <> null)
   begin
   		exec poef_wkf_getNextNode @form_system_id,@current_node_id,@request_no,@handle_staff_code,@nextNodeId1 OUTPUT,@approverGroupId1 OUTPUT,@approverStaffCode1 OUTPUT,@deputyOriginStaff
   end
   else            
   begin
		exec poef_wkf_getNextNode @form_system_id,@current_node_id,@request_no,@handle_staff_code,@nextNodeId1 OUTPUT,@approverGroupId1 OUTPUT,@approverStaffCode1 OUTPUT,''
   end
   Declare @sp_tablename  varchar(100), @sp_fieldname  varchar(100), @SpecStaff varchar(100), @staffcode_temp varchar(10)
   Declare @sp_sql  varchar(300)
   create table #processor(staff_org_code varchar(50) COLLATE Chinese_PRC_CI_AS)


   --if exists system field flow_org_id(改走哪个公司流程) 3/10/2010 begin
   if exists (select field_id from teflow_form_section_field where form_system_id = @form_system_id and field_id='flow_org_id')
   begin
	   select @sp_tablename = 'teflow_'+convert(varchar(20),@form_system_id)+'_'+section_id  
	          from teflow_form_section_field where form_system_id = @form_system_id and field_id='flow_org_id'   
	   if @sp_tablename is not null
	   begin	
		  select @sp_sql = ' insert into #processor select flow_org_id from ' + @sp_tablename + ' where request_no=' +''''+ @request_no+''''
		  exec(@sp_sql)
		  if @@rowcount=1
	          begin
	        	select @request_org_id = staff_org_code from #processor 
	  	  end
		  delete from #processor
	   end	
   end
   --if exists system field flow_org_id(改走哪个公司流程) 3/10/2010 end


   --if exists special field (company) defined in node for approver group filter  
   select @sp_tablename=null
   if exists (select field_id from teflow_wkf_special_field where flow_id = @flowid and node_id=@nextNodeId1 and field_type = 2)
   begin
	   select @sp_tablename = 'teflow_'+convert(varchar(20),@form_system_id)+'_'+section_id, @sp_fieldname = field_id 
	          from teflow_wkf_special_field where flow_id = @flowid and node_id=@nextNodeId1 and field_type = 2   -- specify for one company
	   if @sp_tablename is not null
	   begin	
		  select @sp_sql = ' insert into #processor select '+ @sp_fieldname + ' from ' + @sp_tablename + ' where request_no=' +''''+ @request_no+''''
		  exec(@sp_sql)
		  if @@rowcount=1
	          begin
	        	select @request_org_id = (b.org_id) from #processor a, teflow_company b where isnull(a.staff_org_code,'')<>'' and a.staff_org_code like rtrim(b.org_id)+'%'
	  	  end
		  delete from #processor
	   end
  end

--End for the specified company flow instead of requester's company 1/20/2010

   select @request_staff_code = request_staff_code from teflow_wkf_process where request_no = @request_no
   if isnull(@request_org_id,'')=''	
	   select @request_org_id=org_id from tpma_staffbasic where staff_code=@request_staff_code

   select @teamCode=team_code,@orgChart=org_chart from tpma_team where team_code in (select team_code from  tpma_staffbasic where staff_code=@request_staff_code and status='A')

   select @form_id = form_id, @form_org_id = org_id from teflow_form where form_system_id = @form_system_id
   -- #后面注解已无效# Skip for AIAIT forms: HR-04, ADMIN-ST-02 
   --if ((@orgChart = 'N') and (@form_org_id <> 'Z09003' or (@form_id <> 'HR-04' and @form_id <> 'ADMIN-ST-02')))
   declare @preOrgChart char(1) 
   if (@orgChart = 'N') 
   begin
       select @preTeamCode=@teamCode,@preOrgChart=@orgChart,@teamCode=team_code,@orgChart=org_chart from tpma_team where team_code in (select subordinate from tpma_team where team_code=@teamCode) 
	   while (@@rowcount > 0 and @orgChart <> 'Y')	    
           select  @preTeamCode=@teamCode,@preOrgChart=@orgChart,@teamCode=team_code,@orgChart=org_chart from tpma_team where team_code in (select subordinate from tpma_team where team_code=@teamCode)
       
        --如果没有找到合适的上级team,则采用之前的team
        if(isnull(@teamCode,'')='')
                select @teamCode=team_code,@orgChart=org_chart from tpma_team where team_code in (select team_code from  tpma_staffbasic where staff_code=@request_staff_code and status='A')
        else --找到了
        		select @teamCode=@preTeamCode, @orgChart=@preOrgChart 
   end

   --获取下一个节点的处理人
   Declare @tmp  varchar(2)
   Declare @staff_code  varchar(300)
   select @tmp = ''

   if(@approverGroupId is not null)
   begin
              while(@approverGroupId<>'')
              begin
                      select @tmp = SUBSTRING(@approverGroupId,1,2)
                      if(LEN(@approverGroupId)>2)
                             set @approverGroupId = SUBSTRING(@approverGroupId,4,LEN(@approverGroupId))
                      else
                             select @approverGroupId = ''
                      select @staff_code = '' 
                                          
                      select @approverGroupType=group_type from teflow_approver_group where approver_group_id=@tmp
                      --default is 'head office'
                      if(isnull(@approverGroupType,'')='')
                             select @approverGroupType = '01'
                                           
                      if(@tmp='00') --Requestor
                             select @staff_code = @request_staff_code                      
                      else if(@tmp='01') --PL
                      begin
                             Declare @tableName  varchar(50)
                             Declare @sql  varchar(300)
                             --建个临时表，把查找到结果保存在临时表中
                             create table #project_leader(prj_ld_id char(5))
                             --由于project_leader在form申请资料中存在，则需要根据该表单form_system_id查找
                             select @tableName = table_name from teflow_form_section where form_system_id = @form_system_id and section_id =
                                          (select section_id from teflow_form_section_field where form_system_id = @form_system_id and field_id = 'prj_ld_id')
                             select @sql = ' insert into #project_leader  select prj_ld_id from ' + @tableName + ' where request_no=' +''''+ @request_no+''''
                             exec(@sql)
                             if @@rowcount=1
	                           select @staff_code = prj_ld_id from #project_leader
                      end
                      else if(@tmp='02' or @tmp='34') -- TL1,TL2
                      begin
                              --将当前form表单申请人所属的直接上级leader
                              select @staff_code = staff_code from teflow_approver_group_member where approver_group_id = @tmp and staff_code in
                                                      (select staff_code from tpma_staffbasic where logon_id in 
                                                        ( select tl_id from tpma_team where team_code = @teamCode
                                                       )
                                                     )
                              if(@tmp='34' and isnull(@staff_code,'')='')
                                     --将当前form表单申请人所属的间接上级leader
                                     select @staff_code = staff_code from teflow_approver_group_member where approver_group_id = @tmp and staff_code in
                                                      (select staff_code from tpma_staffbasic where logon_id in 
                                                        ( select tl_id from tpma_team where team_code 
                                                           in (select subordinate from tpma_team where team_code=@teamCode)
                                                       )
                                                     )
                                     --如果requestor与当前处理人是同一个人，则需要查找其直接上级leader 2007-09-12
                                     --为了处理连续两层都是同一个人的情况，一直向上找到不同Leader为止       2011-02-17
                                     /*IF (LTRIM(RTRIM(@staff_code))=@request_staff_code)
                                     BEGIN
                                            --查找上级leader
                                            select @temp_staff_code = staff_code from tpma_staffbasic where logon_id in (select tl_id from tpma_team where status='A' and team_code in 
                                                           (select subordinate from tpma_team where team_code=@teamCode)
                                                        )
                                            if(isnull(@temp_staff_code,'')<>'')
                                                     select @staff_code = @temp_staff_code
                                     END*/
                                     select @temp_staff_code = @staff_code
									 select @preTeamCode = -999 		
									 WHILE (LTRIM(RTRIM(@temp_staff_code))=@request_staff_code and @preTeamCode <> @teamCode)--再无上级则跳出循环
									 BEGIN
											select @preTeamCode = @teamCode										    
									        --查找上级leader
									        select @temp_staff_code = a.staff_code, @teamCode = b.team_code
											from tpma_staffbasic a, tpma_team b, tpma_team c
											where a.logon_id = b.tl_id and a.status='A'
											and b.status='A' and b.team_code = c.subordinate 
											and c.team_code=@teamCode                    
									 END
							         if(isnull(@temp_staff_code,'')<>'')
							                 select @staff_code = @temp_staff_code
                      end
                      else if( @tmp='12') -- DH
                      begin
                              --将当前form表单申请人所属的所有上级team都查找到，保存到临时表#team_temp中
	                      create table #team_temp_2(order_no int IDENTITY (1, 1) NOT NULL, team_code int NOT NULL)
                              insert into #team_temp_2 (team_code)
		                          select a.team_code from tpma_team a,tpma_staffbasic b
		                                  where  b.staff_code = @request_staff_code  and b.team_code = a.team_code
		                                 and a.status='A' and b.status='A' 
                              while @@rowcount > 0
                                  insert into #team_temp_2 (team_code)
			              select a.subordinate from tpma_team a
          				  where a.team_code in ( select team_code from #team_temp_2)  -- #team_temp_2 )
		            		     and a.subordinate not in ( select team_code from  #team_temp_2) --#team_temp_2)
				             and a.status='A'
                              --如果是DH( @tmp='12')
                              if( @tmp='12')
                              begin
                                   Declare @temp_count int
					
                                   /*if(@request_org_id='Z09003')		--For AIAIT                                   
                                   delete from #team_temp_2 where team_code not in (select c.team_code 
						from teflow_approver_group_member a, tpma_staffbasic b, tpma_team c
						where a.approver_group_id = @tmp and a.staff_code=b.staff_code and b.logon_id=c.tl_id)									
							 -- and b.team_code = c.team_code ) one staff may be the TL of more than one team 
							 	   else								--For AIA China*/							 	                             
                                   delete from #team_temp_2 where team_code not in (select c.team_code 
						from tpma_team c where isnull(c.department,'N')='Y')	
			
                                   select @temp_count = count(staff_code) from teflow_approver_group_member where approver_group_id = @tmp and staff_code in
                                           (select staff_code from tpma_staffbasic where logon_id in 
                                                   ( select tl_id from tpma_team where team_code 
                                                             in ( select team_code from  #team_temp_2) -- #team_temp)
                                                               )
                                                            )
                                   if(@temp_count>1)  --如果存在多余一个，则只找出与requestor最接近的一个, 无需再排除AGM 2011-04-01
                                           select @staff_code = staff_code from teflow_approver_group_member where approver_group_id = @tmp and staff_code in
                                                   (select staff_code from tpma_staffbasic where logon_id in 
                                                        ( select tl_id from tpma_team where team_code 
                                                              in ( select team_code from #team_temp_2 where order_no=(select min(order_no) from #team_temp_2)) -- #team_temp)
                                                                                 )
                                                                          )

                                   else
                                           select @staff_code = staff_code from teflow_approver_group_member where approver_group_id = @tmp and staff_code in
                                                   (select staff_code from tpma_staffbasic where logon_id in 
                                                         ( select tl_id from tpma_team where team_code 
                                                              in ( select team_code from  #team_temp_2) -- #team_temp)
                                                                   )
                                                                       ) 
                              end
                              else
                                   select @staff_code = staff_code from teflow_approver_group_member where approver_group_id = @tmp and staff_code in
                                            (select staff_code from tpma_staffbasic where logon_id in 
                                                       ( select tl_id from tpma_team where team_code 
                                                           in ( select team_code from  #team_temp_2) -- #team_temp)
                                                       )
                                                     )
                              --如果requestor与当前处理人是同一个人，则需要查找其直接上级leader 2007-09-12；或者当前处理人找不到，则找其直接leader 2008-04
                              --为了处理连续两层都是同一个人的情况，一直向上找到不同Leader为止       
                              /*IF (LTRIM(RTRIM(@staff_code))=@request_staff_code or isnull(@staff_code,'')='')
                              BEGIN
                                    --查找上级leader
                                    select @temp_staff_code = ''
                                    select @temp_staff_code = staff_code from tpma_staffbasic where logon_id in (select tl_id from tpma_team where status='A' and team_code in ( select subordinate from tpma_team where team_code in 
                                            (select team_code from  tpma_staffbasic where staff_code=@request_staff_code and status='A')))
                                    if(isnull(@temp_staff_code,'')<>'')
                                            select @staff_code = @temp_staff_code
                              END*/                                                     
                             select @temp_staff_code = @staff_code
                             select @teamCode=team_code from  tpma_staffbasic where staff_code=@request_staff_code and status='A'
							 select @preTeamCode = -999 		
							 WHILE ((LTRIM(RTRIM(@temp_staff_code))=@request_staff_code or isnull(@temp_staff_code,'')='')  and @preTeamCode <> @teamCode)--再无上级则跳出循环
							 BEGIN
									select @preTeamCode = @teamCode										    
							        --查找上级leader
							        select @temp_staff_code = a.staff_code, @teamCode = b.team_code
									from tpma_staffbasic a, tpma_team b, tpma_team c
									where a.logon_id = b.tl_id and a.status='A'
									and b.status='A' and b.team_code = c.subordinate 
									and c.team_code=@teamCode                    
							 END
					         if(isnull(@temp_staff_code,'')<>'')
					                 select @staff_code = @temp_staff_code
					                 
                      end                                                 
                      else if (@tmp='06' or @tmp='05'  or @tmp='04')  --AIAIT HELP , AIAIT LEADER, IT Section Header
                      begin
                              declare staff_cursor cursor scroll 
                              for select staff_code from teflow_approver_group_member where approver_group_id = @tmp
                              open staff_cursor
                              declare @code varchar(10)
                              FETCH NEXT FROM staff_cursor  into @code 
                              while @@FETCH_STATUS = 0
                              begin
                                     select @staff_code =   @code + ',' + @staff_code 
                                     FETCH NEXT FROM staff_cursor  into @code 
                              end 
                              close staff_cursor
                              DEALLOCATE staff_cursor
                              declare @lastchar1 char(1)
                              select @lastchar1 = SUBSTRING(@staff_code,LEN(@staff_code),1)
                              if(@lastchar1=',')
                                 select @staff_code = SUBSTRING(@staff_code,1,LEN(@staff_code) - 1)
                      end      
                      else if (@tmp='07') --System Owner
                      begin
                              Declare @soTableName  varchar(50)
                              Declare @sqlSO  varchar(300)
                              --建个临时表，把查找到结果保存在临时表中
                              create table #system_owner(system_owner_code char(5))
                              --由于system_owner 在 form 申请资料中存在，则需要根据该表单form_system_id查找
                              select @soTableName = table_name from teflow_form_section where form_system_id = @form_system_id and section_id =
                                          (select section_id from teflow_form_section_field where form_system_id = @form_system_id and field_id = 'system_id')
                              select @sqlSO = ' insert into #system_owner  select system_owner_code  from  teflow_system_owner where system_id in ( select system_id from ' + @soTableName + ' where request_no=' +''''+ @request_no+'''' + ')'
                              exec(@sqlSO)
                              select @staff_code = system_owner_code from #system_owner
                      end
                      else if (@tmp='08' ) --Resource
                      begin
                              Declare @dbTableName  varchar(50)
                              --  Declare @sqlDB  varchar(300)
                              --建个临时表，把查找到结果保存在临时表中
                              create table #db_owner(db_owner_code char(5))
                              --由于db_owner 在 form 申请资料中存在，则需要根据该表单form_system_id查找
                              select @dbTableName = table_name from teflow_form_section where form_system_id = @form_system_id and section_id =
                                            (select section_id from teflow_form_section_field where form_system_id = @form_system_id and field_id = 'database_id')
                              select @sqlSO = ' insert into #db_owner  select db_owner_code  from  teflow_db_owner where db_id in ( select database_id from ' + @dbTableName + ' where request_no=' +''''+ @request_no+'''' + ')'
                              exec(@sqlSO)
                              select @staff_code = db_owner_code from #db_owner
                      end
                      else if (@tmp='15' ) -- Resource Owner
                      begin
                              Declare @dbTableName1  varchar(50)
                              --    Declare @sqlDB1  varchar(300)
                              --建个临时表，把查找到结果保存在临时表中
                              create table #resource_owner(db_owner_code char(5))
                              --由于resource_owner 在 form 申请资料中存在，则需要根据该表单form_system_id查找
                              select @dbTableName1 = table_name from teflow_form_section where form_system_id = @form_system_id and section_id =
                                            (select section_id from teflow_form_section_field where form_system_id = @form_system_id and field_id = 'resource_owner_code')
                              select @sqlSO ='insert into #resource_owner select resource_owner_code  from ' + @dbTableName1 + ' where request_no=' + ''''+ @request_no+''''
                              exec(@sqlSO)
                              if @@rowcount=1
                                   select @staff_code = db_owner_code from #resource_owner
                      end
                      else if (@tmp='30' or @tmp='03' ) --GZ AGM
                      begin
                              --将当前form表单申请人所属的所有上级team都查找到，保存到临时表#team_temp3中
	                      create table #team_temp_3(order_no int IDENTITY (1, 1) NOT NULL, team_code int NOT NULL)
                              insert into #team_temp_3 (team_code)
		                          select a.team_code from tpma_team a,tpma_staffbasic b
		                                  where  b.staff_code = @request_staff_code  and b.team_code = a.team_code
		                                 and a.status='A' and b.status='A' 
                              while @@rowcount > 0
                                  insert into #team_temp_3 (team_code)
			              select a.subordinate from tpma_team a
          				  where a.team_code in ( select team_code from #team_temp_3)  -- #team_temp_3 )
		            		     and a.subordinate not in ( select team_code from  #team_temp_3) --#team_temp_3)
				             and a.status='A'

                              delete from #team_temp_3 where team_code not in (select c.team_code 
					from teflow_approver_group_member a, tpma_staffbasic b, tpma_team c
					where a.approver_group_id = @tmp and a.staff_code=b.staff_code and b.logon_id=c.tl_id
						and b.team_code = c.team_code )

                              select @staff_code = staff_code from teflow_approver_group_member where approver_group_id = @tmp and staff_code in
                                             (select staff_code from tpma_staffbasic where logon_id in 
                                                  ( select tl_id from tpma_team where team_code 
                                                           in ( select team_code from  #team_temp_3 where order_no=(select min(order_no) from #team_temp_3))))

                             --如果requestor与当前处理人是同一个人，则需要查找其直接上级leader 2007-09-12；或者当前处理人找不到，则找其直接leader 2008-04
                              IF (LTRIM(RTRIM(@staff_code))=@request_staff_code or isnull(@staff_code,'')='')
                              BEGIN
                                    --查找上级leader
                                    select @temp_staff_code = ''
                                    select @temp_staff_code = staff_code from tpma_staffbasic where logon_id in (select tl_id from tpma_team where status='A' and team_code in ( select subordinate from tpma_team where team_code in 
                                             ( select team_code from  tpma_staffbasic where staff_code=@request_staff_code and status='A')))
                                    if(isnull(@temp_staff_code,'')<>'')
                                             select @staff_code = @temp_staff_code
                              END
                       END
                       else if (@tmp='09' OR @tmp='10' or @tmp='11' or @tmp='19') --TS LEADER,Admin Leader,Account Leader,HR Leader
                              select @staff_code = staff_code from teflow_approver_group_member where approver_group_id = @tmp 
                       else
                       begin
                              if(@approverGroupType='01') --head office
                                     declare staff_cursor cursor scroll 
                                                         for select staff_code from teflow_approver_group_member where approver_group_id = @tmp
                              else if(@approverGroupType='02') --branch 
                              begin
                                     declare @companyType   varchar(10)
                                     --获取当前申请者所在公司的类型，如果是Branch(02)，则直接获取，如果是sub-branch(03),则需要获取其上级公司的员工
                                     select @companyType = company_type from teflow_company where org_id = @request_org_id
                                     if(@companyType='03') ---03-sub-branch
                                                declare staff_cursor cursor scroll 
                                                             for select staff_code from teflow_approver_group_member where approver_group_id = @tmp
                                                              and staff_code in (select staff_code from tpma_staffbasic where status='A' and
                                                               org_id in (select parent_org_id from teflow_company where org_id=@request_org_id))
                                      else --02---Branch
                                                declare staff_cursor cursor scroll 
                                                             for select staff_code from teflow_approver_group_member where approver_group_id = @tmp and staff_code in 
                                                                   (select staff_code from tpma_staffbasic where status='A' and org_id = @request_org_id )
                              end
                              else
                              begin
                                      if @tmp='52' and exists(select form_system_id from teflow_form where form_system_id=@form_system_id and form_name like '%Service Request%')
                                      --speical handling for local IT Head, with same company code with previous approver:local user head  07/30/2009
                                           declare staff_cursor cursor scroll 
                                                for select staff_code from teflow_approver_group_member where approver_group_id = @tmp
                                                          and staff_code in (select staff_code from tpma_staffbasic where status='A' and
                                                             org_id in ( select org_id from teflow_company where org_id=(select org_id
                                                          from tpma_staffbasic where staff_code=@handle_staff_code)))
                                      else if exists(select staff_code from teflow_approver_group_member where approver_group_id = @tmp
                                                         and staff_code in (select staff_code from tpma_staffbasic where status='A' and
                                                             org_id in ( select org_id from teflow_company where org_id=@request_org_id)))
                                            declare staff_cursor cursor scroll 
                                                for select staff_code from teflow_approver_group_member where approver_group_id = @tmp
                                                         and staff_code in (select staff_code from tpma_staffbasic where status='A' and
                                                             org_id in ( select org_id from teflow_company where org_id=@request_org_id))
                                      else 
                                            declare staff_cursor cursor scroll 
                                                 for select staff_code from teflow_approver_group_member where approver_group_id = @tmp
                                                         and staff_code in (select staff_code from tpma_staffbasic where status='A' and
                                                             org_id in (select parent_org_id from teflow_company where org_id=@request_org_id))
                              end
                                                          
                              open staff_cursor
                              declare @code_1 varchar(10)
                              FETCH NEXT FROM staff_cursor  into @code_1 
                              while @@FETCH_STATUS = 0
                              begin
                                      select @staff_code = rtrim(@code_1) + ',' + @staff_code 
                                      FETCH NEXT FROM staff_cursor  into @code_1 
                              end 
                              close staff_cursor
                              DEALLOCATE staff_cursor
                                                      
                              declare @lastchar2 char(1)
                              select @lastchar2 = SUBSTRING(@staff_code,LEN(@staff_code),1)
                              if(@lastchar2=',')
                                      select @staff_code = SUBSTRING(@staff_code,1,LEN(@staff_code) - 1)
                       end      
                       if(@staff_code<>'')                                           
                              select @handleStaff =   @staff_code   + ',' + @handleStaff            
               end
   end

   if(isnull(@approverStaffCode,'')<>'')
   begin    
        select @nextHandleStaff =  @approverStaffCode
   end
   if(@handleStaff is not null and @handleStaff <>'') --判断最后一位是否是“,”，如果是则将其去掉
   begin
        select @lastchar = ''
        select @lastchar = SUBSTRING(@handleStaff,LEN(@handleStaff) ,1)
   if(@lastchar=',')
        select @handleStaff = SUBSTRING(@handleStaff,1,LEN(@handleStaff) - 1)
   end
   if(isnull(@nextHandleStaff,'')<>'')
   begin
        select  @nextHandleStaff   = @nextHandleStaff + ','  +   @handleStaff
   end
   else
        select  @nextHandleStaff   =  @handleStaff
 
 

   --Begin for the processor specified by form's field  07/20/2009
   --Amend for BJ staff code like: C005, 2013-02-06
   select @sp_tablename=null
   select @sp_tablename = 'teflow_'+convert(varchar(20),@form_system_id)+'_'+section_id, @sp_fieldname = field_id 
          from teflow_wkf_special_field where flow_id = @flowid and node_id=@nextNodeId1 and field_type = 1   -- specify for one staff
   if @sp_tablename is not null
   begin	
	  select @sp_sql = ' insert into #processor select '+ @sp_fieldname + ' from ' + @sp_tablename + ' where request_no=' +''''+ @request_no+''''
	  exec(@sp_sql)
	  if @@rowcount=1
          begin
        	/*select @SpecStaff = rtrim(b.staff_code) from #processor a, tpma_staffbasic b where ','+rtrim(a.staff_org_code)+',' like '%,'+rtrim(b.staff_code)+',%'
       	        --if charindex(@SpecStaff,@nextHandleStaff)=0		
               	--     select @nextHandleStaff = @nextHandleStaff + ','  + @SpecStaff
		select @nextHandleStaff = @SpecStaff*/
		select @nextHandleStaff = rtrim(a.staff_org_code) from  #processor a
	          
          end
   end	
   --End for the processor specified by form's field  07/20/2009

   ---Check for system field: Staff Location (09/23/2013)
    if exists (select field_id from teflow_form_section_field where form_system_id = @form_system_id and field_id = 'staff_location')
    begin
		select @node_type = node_type from teflow_wkf_detail where flow_id = @flowId and node_id = @nextNodeId1
		if @node_type = '3'
		begin
			select @request_org_id = ''
			select @sp_tablename = 'teflow_' + convert(varchar(20), @form_system_id) + '_' + section_id
				from teflow_form_section_field where form_system_id = @form_system_id and field_id = 'staff_location'
			select @sp_sql = 'insert into #processor select staff_location from ' + @sp_tablename + ' where request_no = ''' + @request_no + ''''
			exec(@sp_sql)
			if @@rowcount = 1
			begin
				select @request_org_id = staff_org_code from #processor
			end
			delete from #processor
			if (isnull(@request_org_id, '') <> '')
			begin
				select @staff_code = ''
				declare @_nextHandleStaff varchar(300)
				select @_nextHandleStaff = ',' + @nextHandleStaff + ','
				declare staff_cursor cursor scroll for
					select rtrim(staff_code) staff_code from tpma_staffbasic where pacii_dept_code = @request_org_id and @_nextHandleStaff like ('%,' + rtrim(staff_code) + ',%')
				open staff_cursor
				declare @_code varchar(10)
				declare @comma varchar(1)
				select @comma = ''
                fetch next from staff_cursor into @_code
                while @@fetch_status = 0
                begin
                	select @staff_code = @staff_code + @comma + @_code
                	select @comma = ','
                	fetch next from staff_cursor into @_code
                end
                close staff_cursor
                deallocate staff_cursor
                if @staff_code <> ''
                begin
	                select @nextHandleStaff = @staff_code
                end 
			end 
		end
    end
   ------------------------------------------

   --check if exist deputy
   Declare @deputyStaffCode varchar(10)
   Declare @tempNextStaff varchar(300)
   Declare @tempStaffCode varchar(100)
   select @tempNextStaff = @nextHandleStaff + ',ZZZZ'
   --计数器
   declare @i   int 
   --获取索引
   set @i=charindex(',',@tempNextStaff) 
   select @tempStaffCode = ''
   select @nextHandleStaff = ''
   select @deputyOriginStaff = ''
   --遍历截取 
   while @i >= 1
   begin
                  --排除开始处有分隔字符的怀况
                 if(left(@tempNextStaff,@i-1) <> '') 
                 begin
                       --查到一次,检查是否存在设置deputy
                       select @tempStaffCode = (left(@tempNextStaff,@i-1))
                       select @deputyStaffCode=''
                       select @form_type_id = form_type from teflow_form where form_system_id=@form_system_id
                       select @deputyStaffCode = authority_deputy from teflow_deputy_manage where (Convert(varchar(10),Getdate(),111)  between delegate_from and delegate_to)  and (status='01') and authority_approver=@tempStaffCode
                       		and (apply_org_id like '%'+@request_org_id+'%' or isnull(apply_org_id,'')='')
                       		and delegate_level like '%3%' and form_system_id like '%,'+cast(@form_system_id as varchar)+',%'
                       if(isnull(@deputyStaffCode,'')='')select @deputyStaffCode = authority_deputy from teflow_deputy_manage where (Convert(varchar(10),Getdate(),111)  between delegate_from and delegate_to)  and (status='01') and authority_approver=@tempStaffCode
                       		and (apply_org_id like '%'+@request_org_id+'%' or isnull(apply_org_id,'')='')
                       		and delegate_level like '%2%' and form_type_id like '%,'+@form_type_id+',%'																
                       if(isnull(@deputyStaffCode,'')='')select @deputyStaffCode = authority_deputy from teflow_deputy_manage where (Convert(varchar(10),Getdate(),111)  between delegate_from and delegate_to)  and (status='01') and authority_approver=@tempStaffCode
                       		and (apply_org_id like '%'+@request_org_id+'%' or isnull(apply_org_id,'')='')
                       		and delegate_level like '%1%'
                       																		
                       if(isnull(@deputyStaffCode,'')<>'')
                       begin
                                declare @temp varchar(10) 
                                declare @d_count int                 
                                select @temp = @deputyStaffCode
                                while(isnull(@deputyStaffCode,'')<>'')
                                begin
                                       select @deputyStaffCode = authority_deputy from teflow_deputy_manage where (Convert(varchar(10),Getdate(),111)   between delegate_from and delegate_to)  and (status='01') and authority_approver=@temp
                                       				and (apply_org_id like '%'+@request_org_id+'%' or isnull(apply_org_id,'')='')				 
                                       				and ((delegate_level like '%3%' and form_system_id like '%,'+cast(@form_system_id as varchar)+',%')
                                       				   or (delegate_level like '%2%' and form_type_id like '%,'+@form_type_id+',%')
                                       				   or  delegate_level like '%1%')
                                                    and authority_deputy not in (select authority_approver from teflow_deputy_manage where (Convert(varchar(10),Getdate(),111)   between delegate_from and delegate_to)  and (status='01') )
                                                    order by delegate_level desc                       
                                       if @@rowcount = 0 break
                                       if(isnull(@deputyStaffCode,'')<>'')
                                       begin
                                                 select @temp = @deputyStaffCode
                                       end
                                end   
                                select  @nextHandleStaff = @temp + ',' + @nextHandleStaff 
                                select  @deputyOriginStaff = @tempStaffCode + ',' + @deputyOriginStaff
                       end
                       else
                       begin
                                select  @nextHandleStaff = @tempStaffCode + ',' + @nextHandleStaff 
                       end
                 end
                 -- 获取还未拆分的字符
                 select @tempNextStaff = substring(@tempNextStaff,@i+1,len(@tempNextStaff)-@i)
                 -- 获取标记所在索引
                 select @i = charindex(',',@tempNextStaff) 
   end --end while
   --保存最后一节非空字符
 /*  select @deputyStaffCode = ''

   if(@tempNextStaff <> '')
   begin 
                 select @deputyStaffCode = authority_deputy from teflow_deputy_manage where (Convert(varchar(10),Getdate(),111)   between delegate_from and delegate_to)  and (status='01') and authority_approver=@tempNextStaff
                 if(isnull(@deputyStaffCode,'')<>'')
                 begin
                       if(isnull(@deputyOriginStaff,'')<>'')
                             select  @deputyOriginStaff = @tempNextStaff + ',' + @deputyOriginStaff
                       else
                             select  @deputyOriginStaff = @tempNextStaff
                             
                       if(isnull(@nextHandleStaff,'')<>'')
                             select  @nextHandleStaff = @deputyStaffCode + ',' + @nextHandleStaff 
                       else
                             select  @nextHandleStaff = @deputyStaffCode
                 end
                 else
                 begin
                       if(isnull(@nextHandleStaff,'')<>'') 
                             select  @nextHandleStaff = @tempNextStaff + ',' + @nextHandleStaff 
                       else
                             select  @nextHandleStaff = @tempNextStaff
                 end
   end*/
   if(@deputyOriginStaff is not null and @deputyOriginStaff <>'') --判断最后一位是否是“,”，如果是则将其去掉
   begin
                 select @lastchar2 = ''
                 select @lastchar2 = SUBSTRING(@deputyOriginStaff,LEN(@deputyOriginStaff) ,1)             
                 if(@lastchar2=',') 
                        select @deputyOriginStaff = SUBSTRING(@deputyOriginStaff,1,LEN(@deputyOriginStaff) - 1)
   end          
   if(@nextHandleStaff is not null and @nextHandleStaff <>'') --判断最后一位是否是“,”，如果是则将其去掉
   begin
                 select @lastchar2 = ''
                 select @lastchar2 = SUBSTRING(@nextHandleStaff,LEN(@nextHandleStaff) ,1)
                 if(@lastchar2=',')
                       select @nextHandleStaff = SUBSTRING(@nextHandleStaff,1,LEN(@nextHandleStaff) - 1)
   end
   select @nextHandleStaff = @nextHandleStaff
   select @deputyOriginStaff = @deputyOriginStaff
end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
