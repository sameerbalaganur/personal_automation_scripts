# Import SQL Server Module
Import-Module -Name SqlServer

# Define variables
$SharedFolder = "D:\BACKUPS"
$ServerInstance = "POCPDB01\MSSQL2016DPRI"
$Database = "pop"
$Username = "sa"
$Password = "password"
$BackupFileName = "pop.bak"  # Replace with your actual backup file name

# Secure Password
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

# Credential Object
$Credential = New-Object System.Management.Automation.PSCredential ($Username, $SecurePassword)

# Construct Full Backup File Path
$BackupFilePath = Join-Path -Path $SharedFolder -ChildPath $BackupFileName

# Verify the backup file exists
if (-Not (Test-Path -Path $BackupFilePath)) {
    Write-Host "Backup file does not exist: $BackupFilePath"
    exit
}

# Restore Database
try {
    Restore-SqlDatabase -ServerInstance $ServerInstance -Database $Database -BackupFile $BackupFilePath -Credential $Credential
    Write-Host "Database restored successfully."
} catch {
    Write-Host "An error occurred during the database restore: $_"
}