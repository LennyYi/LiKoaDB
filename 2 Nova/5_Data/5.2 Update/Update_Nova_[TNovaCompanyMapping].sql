--2015-03-23 Sting Wu For NOVA-109
WITH MyCTE AS
(
    SELECT seq,org_name,compcode,
           ROW_NUMBER() OVER(PARTITION BY seq,org_name,compcode ORDER BY seq,org_name,compcode) AS row_num
    FROM TNovaCompanyMapping cta
)   
DELETE FROM MyCTE WHERE row_num <> 1;

update TNovaCompanyMapping set TEAMCD = '41' where COMPCODE = '10' and ORG_NAME = 'AIA Shenzhen'
update TNovaCompanyMapping set TEAMCD = '61' where COMPCODE = '12' and ORG_NAME = 'AIA Jiangsu'
update TNovaCompanyMapping set TEAMCD = '61' where COMPCODE = '12' and ORG_NAME = 'AIA Nanjing'
update TNovaCompanyMapping set TEAMCD = '61' where COMPCODE = '12' and ORG_NAME = 'AIA Suzhou'
update TNovaCompanyMapping set TEAMCD = '21' where COMPCODE = '25' and ORG_NAME = 'AIA Guangzhou'
update TNovaCompanyMapping set TEAMCD = '21' where COMPCODE = '25' and ORG_NAME = 'AIA Guangdong'
update TNovaCompanyMapping set TEAMCD = '31' where COMPCODE = '26' and ORG_NAME = 'AIA Foshan'
update TNovaCompanyMapping set TEAMCD = '81' where COMPCODE = '27' and ORG_NAME = 'AIA Jiangmen'
update TNovaCompanyMapping set TEAMCD = '71' where COMPCODE = '28' and ORG_NAME = 'AIA Dongguan'