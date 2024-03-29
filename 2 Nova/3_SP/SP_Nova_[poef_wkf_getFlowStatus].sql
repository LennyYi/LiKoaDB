if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[poef_wkf_getFlowStatus]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
     drop procedure [dbo].[poef_wkf_getFlowStatus]
GO
/*********************** REVISION LOG: ***********************************
Version			Date			Revised by				Remark
1.0				20150304		Sting Wu				initial
**************************************************************************/
CREATE PROCEDURE [dbo].[poef_wkf_getFlowStatus]
( @request_no varchar(30), @form_system_id int )
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @flow_id int
	SELECT @flow_id= flow_id FROM teflow_wkf_define WHERE form_system_id=@form_system_id
	
	DECLARE @sql NVARCHAR(2000)
	
	--if the form have the pending error
	declare @tableName nvarchar(30), @sql2 nvarchar(400), @errorCode varchar(50),@count int
	
	set @tableName = N'teflow_'+cast(@form_system_id as NVARCHAR)+N'_SystemFW'
	
	select @errorCode = option_value from teflow_base_data_master t1 inner join teflow_base_data_detail t2 on t1.master_id = t2.master_id 
	and t1.field_name = 'ErrorMessage' and option_label like N'%照会%'
	set @count = 0
	
	if exists (select 1 from sys.columns where name = 'field_SystemFW_1' and object_id= object_id(@tableName))
	begin
		set @sql2 = N'select @count=COUNT(1) from '+@tableName+N' where request_no = '''+@request_no + ''' and field_SystemFW_1 = ''' + @errorCode +'''';
		exec sp_executesql @sql2,N'@count int output ',@count output 
	end
	
	if exists (select 1 from teflow_wkf_process where request_no = @request_no and node_id=-1)
	begin
		set @sql = N'select cast(left(d.node_alias,2) AS int) as no1,d.node_alias,d.node_id,d.node_name as ndName,p.request_no,1 as curNode
			from teflow_wkf_detail d 
			left join teflow_wkf_process p 
			on d.flow_id = p.flow_id and p.request_no = ''' + cast(@request_no as nvarchar(30)) +  N''' where d.flow_id= ' + cast(@flow_id  as nvarchar)
				+ '  and d.node_alias not like ''%ErrorHandle%''  and d.node_alias<>'''' ';
			
		if (@count = 0)
			set @sql = @sql + char(13)+char(10)  + ' and d.node_alias not like ''%WaitHandle%'' '
		
		set @sql = @sql + char(13)+char(10) + ' order by curNode desc,node_alias ';
	end
	else
	begin
		if exists (select 1 from teflow_wkf_process t1 
			inner join teflow_wkf_detail t2 on t1.node_id = t2.node_id 
				and t1.request_no= @request_no and t2.flow_id =@flow_id 
				and t1.flow_id=t2.flow_id and node_alias like '%ErrorHandle%')
		begin	
			set @sql = N'select DISTINCT 1 no1, d.node_alias, d.node_id as node_id, d.node_name as ndName,d.node_alias, 
							p2.request_no,(case when d.node_alias <=p2.node_alias then 1 else 0 end) curNode
						from teflow_wkf_detail d 
				cross join (select p2.request_no,d2.node_alias,p2.node_id,p2.flow_id from teflow_wkf_process p2 inner join teflow_wkf_detail d2 on p2.flow_id = d2.flow_id 
								and p2.node_id = d2.node_id 
								and p2.request_no = ''' + cast(@request_no as nvarchar(30)) + N''' ) p2
				 where d.flow_id= ' +cast(@flow_id  as nvarchar)+ N' AND d.node_alias<>'''' '
					
			if (@count = 0)
				set @sql = @sql + char(13)+char(10)  + N' and d.node_alias not like ''%WaitHandle%'' ';
	
			set @sql = @sql + char(13)+char(10)  + ' order by curNode desc, d.node_alias ';
			
		end
		else
		begin
			set @sql = N'select  cast(left(d.node_alias,2) AS int) as no1, d.node_alias, d.node_id as node_id, d.node_name as ndName,d.node_alias, 
							p2.request_no,(case when d.node_alias <=p2.node_alias then 1 else 0 end) curNode
						from teflow_wkf_detail d 
				cross join (select p2.request_no,d2.node_alias,p2.node_id,p2.flow_id from teflow_wkf_process p2 inner join teflow_wkf_detail d2 on p2.flow_id = d2.flow_id 
								and p2.node_id = d2.node_id 
								and p2.request_no = ''' + cast(@request_no as nvarchar(30)) + N''' ) p2
				 where d.flow_id= ' +cast(@flow_id  as nvarchar)+ N' AND d.node_alias<>'''' and d.node_alias not like ''%ErrorHandle%'' '
					
			if (@count = 0)
				set @sql = @sql + char(13)+char(10)  + N' and d.node_alias not like ''%WaitHandle%'' ';
	
			set @sql = @sql + char(13)+char(10)  + ' order by curNode desc, d.node_alias ';
			
		end
	end
	
	print @sql
	
	exec sp_executesql @sql;
	
	EXITS:

END
