

IF NOT EXISTS (SELECT 1  FROM syscolumns INNER JOIN sysobjects ON sysobjects.id = syscolumns.id WHERE sysobjects.name = 'TNovaProdPrem' AND syscolumns.name = 'OccClass')
ALTER TABLE TNovaProdPrem ADD OccClass VARCHAR(01) NULL;   

IF NOT EXISTS (SELECT 1  FROM syscolumns INNER JOIN sysobjects ON sysobjects.id = syscolumns.id WHERE sysobjects.name = 'TNovaProdPrem' AND syscolumns.name = 'Ship')
ALTER TABLE TNovaProdPrem ADD Ship VARCHAR(01) NULL;  