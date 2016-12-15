if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tpma_staffbasic]'))
drop view [dbo].[tpma_staffbasic]
GO

create view [dbo].[tpma_staffbasic]
as
select user_no collate chinese_prc_ci_as as user_no, staff_code collate chinese_prc_ci_as as staff_code, 
    id_card collate chinese_prc_ci_as as id_card, staff_name collate chinese_prc_ci_as as staff_name, 
    status collate chinese_prc_ci_as as status, logon_id collate chinese_prc_ci_as as logon_id, 
    team_code, email collate chinese_prc_ci_as as email, null as virtual_team_code, '0' collate chinese_prc_ci_as as user_type, 
    '1900-1-1' as from_date, case when status = 't' then term_date else '2100-1-1' end as to_date, title_id, '' as chinese_name, 
    '' as account_no, '' as bank_detail, '1' as display_type, '1900-1-1' as modified_date, '' as modified_staff, 
    'Z09003' as org_id, pacii_dept_code, res_type 
from db_pmaprd.dbo.tpma_staffbasic a where a.user_no = (
    select max(user_no) from db_pmaprd.dbo.tpma_staffbasic b where a.staff_code = b.staff_code)
union all
select '' collate chinese_prc_ci_as as user_no, u.staff_code collate chinese_prc_ci_as as staff_code, 
    '' collate chinese_prc_ci_as as id_card, u.staff_name collate chinese_prc_ci_as as staff_name, 
    u.status collate chinese_prc_ci_as as status, u.logonid collate chinese_prc_ci_as as logon_id, 
    u.team_code, u.email collate chinese_prc_ci_as as email, u.virtual_team_code, u.user_type collate chinese_prc_ci_as as user_type, 
    convert(varchar, u.from_date, 101) as from_date, convert(varchar, u.to_date, 101) as to_date, title_id, chinese_name, 
    account_no, '' as bank_detail, '2' as display_type, modified_date, modified_staff, 
    org_id, '' as pacii_dept_code, '' as res_type 
from teflow_user u

GO
