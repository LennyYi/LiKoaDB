
DELETE FROM TSYSPARMH WHERE PARMDESC = 'NOVASP' AND PARMTYPE='30322'
INSERT TSYSPARMH(PARMDESC,PARMVALUE,PARMTYPE,VALUEUSAGE,RCDUSRID,RCDDTSTMP)  VALUES(N'NOVASP',N'1',N'30322',N'USPGNOVAGENTBANKACCTINFO',SUSER_SNAME(),GETDATE())
INSERT TSYSPARMH(PARMDESC,PARMVALUE,PARMTYPE,VALUEUSAGE,RCDUSRID,RCDDTSTMP)  VALUES(N'NOVASP',N'2',N'30322',N'USPGNOVAGENTPOLFINCL',SUSER_SNAME(),GETDATE())
INSERT TSYSPARMH(PARMDESC,PARMVALUE,PARMTYPE,VALUEUSAGE,RCDUSRID,RCDDTSTMP)  VALUES(N'NOVASP',N'3',N'30322',N'USPGNOVAGENTMEMPTPOL',SUSER_SNAME(),GETDATE())
INSERT TSYSPARMH(PARMDESC,PARMVALUE,PARMTYPE,VALUEUSAGE,RCDUSRID,RCDDTSTMP)  VALUES(N'NOVASP',N'4',N'30322',N'USPGNOVAGENTUHCMEMBERID',SUSER_SNAME(),GETDATE())
INSERT TSYSPARMH(PARMDESC,PARMVALUE,PARMTYPE,VALUEUSAGE,RCDUSRID,RCDDTSTMP)  VALUES(N'NOVASP',N'5',N'30322',N'USPGNOVAUPDATEPLNDESC',SUSER_SNAME(),GETDATE())
INSERT TSYSPARMH(PARMDESC,PARMVALUE,PARMTYPE,VALUEUSAGE,RCDUSRID,RCDDTSTMP)  VALUES(N'NOVASP',N'0',N'30322',N'USPGNOVAGENTPOLPDTFLAK',SUSER_SNAME(),GETDATE())
INSERT TSYSPARMH(PARMDESC,PARMVALUE,PARMTYPE,VALUEUSAGE,RCDUSRID,RCDDTSTMP)  VALUES(N'NOVASP',N'6',N'30322',N'USPGNOVABENAMTMB',SUSER_SNAME(),GETDATE())