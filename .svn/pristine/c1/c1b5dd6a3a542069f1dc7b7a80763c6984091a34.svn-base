--20150506 Justin Bin
begin tran
delete from nova.TPOLADDH_template where FORM_SYSTEM_ID='30319'

SELECT * into #TPOLADDH_template  FROM nova.TPOLADDH_template where FORM_SYSTEM_ID='20259'

update #TPOLADDH_template set FORM_SYSTEM_ID='30319'

INSERT nova.TPOLADDH_template SELECT * FROM #TPOLADDH_template

commit tran
