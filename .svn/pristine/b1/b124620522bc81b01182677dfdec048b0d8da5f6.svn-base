--
IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[teflow_wkf_detail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN

CREATE TABLE [dbo].[teflow_wkf_detail](
	[flow_id] [decimal](18, 0) NOT NULL,
	[node_id] [varchar](10) NOT NULL,
	[node_type] [char](1) NULL,
	[pre_node_id] [varchar](500) NULL,
	[node_name] [varchar](50) NULL,
	[limited_hours] [decimal](18, 2) NULL,
	[has_rule] [char](1) NULL,
	[rule_id] [decimal](18, 0) NULL,
	[approver_group_id] [varchar](100) NULL,
	[approver_staff_code] [varchar](100) NULL,
	[position_x] [varchar](10) NULL,
	[position_y] [varchar](10) NULL,
	[update_section_fields] [varchar](max) NULL,
	[fill_section_fields] [varchar](1000) NULL,
	[hidden_section_fields] [varchar](1000) NULL,
	[node_alias] [varchar](100) NULL,
	[approve_alias] [varchar](50) NULL,
	[reject_alias] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]	
	


END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[teflow_wkf_detail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
 BEGIN  

IF NOT EXISTS (SELECT TC.NAME FROM SYSOBJECTS TS, SYSCOLUMNS TC WHERE TS.ID = TC.ID AND TS.NAME = 'teflow_wkf_detail' AND TC.NAME = 'hidden_section_fields')
                BEGIN
                                ALTER TABLE DBO.teflow_wkf_detail ADD hidden_section_fields varchar(1000) NULL
                END
END


