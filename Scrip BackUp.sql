--Crear dispositivo de backups

EXEC sp_addumpdevice 'disk', 'AdventureWorksBackupDevice',
'C:\Backup\AdventureWorksBackupDevice.bak'
GO

-- Creacion de backups con nombres unicos
DECLARE @BACKUP_NAME VARCHAR(50)
SET @BACKUP_NAME =N'AdventureWorks2019_full_Backup'+FORMAT(GETDATE(),'yyyyMMdd_hhmmss')
BACKUP DATABASE AdventureWorks2019
TO AdventureWorksBackupDevice
WITH NOFORMAT , NOINIT , NAME = @BACKUP_NAME
GO 

DECLARE @BACKUP_NAME VARCHAR(100)
SET @BACKUP_NAME =N'AdventureWorks2019_Differential_Backup'+FORMAT(GETDATE(),'yyyyMMdd_hhmmss')
BACKUP DATABASE AdventureWorks2019
TO AdventureWorksBackupDevice
WITH DIFFERENTIAL , NAME = @BACKUP_NAME
GO 


RESTORE HEADERONLY FROM AdventureWorksBackupDevice
GO


--Restauracion de backup AwExamenBDII

Restore DATABASE AwExamenBDII
FROM AdventureWorksBackupDevice
WITH FILE=1,
	MOVE N'AdventureWorks2017' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\AwExamenBDII.mdf',
	MOVE N'AdventureWorks2017_log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\AwExamenBDII_Log.ldf',
NOUNLOAD, REPLACE, STATS =10
GO

Restore DATABASE AwExamenBDII
FROM AdventureWorksBackupDevice
WITH FILE=5,
	MOVE N'AdventureWorks2017' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\AwExamenBDII.mdf',
	MOVE N'AdventureWorks2017_log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\AwExamenBDII_Log.ldf',
NOUNLOAD, REPLACE, STATS =10
GO

CREATE TABLE CARLOS(ID UNIQUEIDENTIFIER)

RESTORE HEADERONLY FROM AdventureWorksBackupDevice
GO
RESTORE FILELISTONLY FROM AdventureWorksBackupDevice
GO

