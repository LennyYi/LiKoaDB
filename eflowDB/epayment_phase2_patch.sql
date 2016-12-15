
-- updated table_teflow_team: added field department
ALTER TABLE teflow_team ADD department CHAR(1) NULL;

-- added module 'status monitoring report'
INSERT INTO teflow_module
      (module_id, module_name, parent_id, target_url, order_id, remark, image_file_name)
VALUES (60, 'menu.report.statusmonitoring', 5, 'reportAction.it?method=statusMonitoring', 
      10, 'status monitoring report', 'odr.gif');

INSERT INTO teflow_module_operate
      (operate_id, module_id, operate_name, remark, form_type_id)
VALUES (1, 60, 'Query', 'status monitoring report', NULL);

-- added module 'processing trail report'
INSERT INTO teflow_module
      (module_id, module_name, parent_id, target_url, order_id, remark, image_file_name)
VALUES (61, 'menu.report.processingTrail', 5, 'reportAction.it?method=processingTrail', 
      10, 'processing trail report', 'odr.gif');

INSERT INTO teflow_module_operate
      (operate_id, module_id, operate_name, remark, form_type_id)
VALUES (1, 61, 'Query', 'processing trail report', NULL);

-- added module 'processing amount report'
INSERT INTO teflow_module
      (module_id, module_name, parent_id, target_url, order_id, remark, image_file_name)
VALUES (62, 'menu.report.processingAmount', 5, 'reportAction.it?method=processingAmount', 
      10, 'processing amount report', 'odr.gif');

INSERT INTO teflow_module_operate
      (operate_id, module_id, operate_name, remark, form_type_id)
VALUES (1, 62, 'Query', 'processing amount report', NULL);


-- updated view_tpma_team: added field department
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tpma_team]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[tpma_team]
GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW dbo.tpma_team
AS
SELECT Team_code, Team_name COLLATE Chinese_PRC_CI_AS AS Team_name, 
      Status COLLATE Chinese_PRC_CI_AS AS Status, 
      Tl_id COLLATE Chinese_PRC_CI_AS AS Tl_id, Superiors_code AS subordinate, 
      Modified_date, Modified_staff COLLATE Chinese_PRC_CI_AS AS Modified_staff, 
      org_chart COLLATE Chinese_PRC_CI_AS AS org_chart, 
      department COLLATE Chinese_PRC_CI_AS AS department, 
      org_id COLLATE Chinese_PRC_CI_AS AS org_id
FROM dbo.teflow_team
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


--view for flow handle type
IF EXISTS (SELECT *
            FROM dbo.sysobjects
            WHERE id = object_id(N'veflow_flow_handletype') AND 
                  OBJECTPROPERTY(id, N'IsView') = 1) 
DROP VIEW dbo.veflow_flow_handletype 

--view for flow status
IF EXISTS (SELECT *
            FROM dbo.sysobjects
            WHERE id = object_id(N'veflow_flow_status') AND 
                  OBJECTPROPERTY(id, N'IsView') = 1) 
DROP VIEW dbo.veflow_flow_status 
GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO 
CREATE VIEW dbo.veflow_flow_status AS
          SELECT p.request_no,f.form_id, f.form_name, f.form_type,pd.flow_id, pd.flow_name,
			  'flow_status' = CASE WHEN p.status = '01' THEN 'Submitted' 
			  WHEN p.status = '02' THEN 'In Progress' 
			  WHEN p.status = '03' THEN 'Rejected'
			  WHEN p.status = '00' THEN 'Draft'
			  WHEN p.status = '04' THEN 'Completed'           
              END, 
              c.org_id, c.org_name, 
              p.submission_date, f.status AS form_status,s.staff_code, s.staff_name
        FROM 
             dbo.teflow_wkf_process p INNER JOIN dbo.teflow_wkf_define pd ON p.flow_id = pd.flow_id 
             INNER JOIN dbo.teflow_form f ON f.form_system_id = pd.form_system_id 
             INNER JOIN dbo.tpma_staffbasic s ON p.request_staff_code  = s.staff_code 
             INNER JOIN dbo.teflow_company c ON s.org_id = c.org_id 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--view for processing trail report
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[veflow_flow_trail]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[veflow_flow_trail]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.veflow_flow_trail
AS
SELECT process.request_no, process.submission_date, req.staff_name AS requestor, 
      handler.staff_name AS processor, trace.handle_date, trace.handle_type, 
      detail.node_name, def.flow_name, trace.handle_comments, form.form_name, 
      team.Team_name, trace.attach_file, team.Team_code, com.org_id, com.org_name, 
      req.staff_code AS req_staff_code, form.form_system_id, def.flow_id, 
      handler.staff_code AS han_staff_code, form.form_id, form.form_type
FROM dbo.teflow_wkf_process process INNER JOIN
      dbo.tpma_staffbasic req ON process.request_staff_code = req.staff_code INNER JOIN
      dbo.tpma_team team ON req.team_code = team.Team_code INNER JOIN
      dbo.teflow_wkf_process_trace trace ON 
      process.request_no = trace.request_no INNER JOIN
      dbo.tpma_staffbasic handler ON 
      trace.current_processor = handler.staff_code INNER JOIN
      dbo.teflow_wkf_detail detail ON trace.flow_id = detail.flow_id AND 
      trace.node_id = detail.node_id INNER JOIN
      dbo.teflow_wkf_define def ON trace.flow_id = def.flow_id INNER JOIN
      dbo.teflow_form form ON def.form_system_id = form.form_system_id INNER JOIN
      dbo.teflow_company com ON com.org_id = req.org_id

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
