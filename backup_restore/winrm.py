import winrm
import argparse
import os
from sys import argv
import sys

server_name = "DEVOPSPDB01\MSSQL2016DPRI"
shared_folder = "D:\BACKUPS"
database = "pop"
username = "sa"
backup_file_name = "pop.bak"
password = "password"
def connect_to_windows():
    hostname = 'POCWDEVOPSPDB01'
    url = "http://%s:%s/wsman" % (hostname, 5986)
    try:
        remote = winrm.Session(url, auth=(argv[1], argv[2]), transport='ntlm', server_cert_validation='ignore')
        ps_script =f'''
            # Import SQL Server Module
            Import-Module -Name SqlServer

            # Define variables
            $SharedFolder = {shared_folder}
            $ServerInstance = {server_name}
            $Database = {database}
            $Username = {username}
            $Password = {password}
            $BackupFileName = {backup_file_name}  # Replace with your actual backup file name

            # Secure Password
            $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

            # Credential Object
            $Credential = New-Object System.Management.Automation.PSCredential ($Username, $SecurePassword)

            # Construct Full Backup File Path
            $BackupFilePath = Join-Path -Path $SharedFolder -ChildPath $BackupFileName

            # Restore Database

            Restore-SqlDatabase -ServerInstance $ServerInstance -Database $Database -BackupFile $BackupFilePath -Credential $Credential
            Write-Host "Database restored successfully."
'''

        remote.run(ps_script)

    except:
        print(f"Error connecting to {hostname}" + url)
        sys.exit(1)

    