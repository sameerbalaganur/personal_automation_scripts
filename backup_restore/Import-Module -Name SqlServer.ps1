Import-Module -Name SqlServer
$SharedFolder = "D:\BACKUPS"
$ServerInstance = "POCWDEVOPSPDB01\MSSQL2016DPRI"
$database = "master"
$Username = "sa"
Restore-SqlDatabase -ServerInstance $ServerInstance -Database $database -BackupFile "$($SharedFolder)\pop.bak" -Credential (Get-Credential $Username)