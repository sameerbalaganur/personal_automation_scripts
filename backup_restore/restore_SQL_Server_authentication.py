import pyodbc

server_name = 'LAPTOP-pppppppp\\SQLEXPRESS'
database_name = 'master'
target_database_name = 'empty'
windows_authentication = False
username = 'sa'
trusted_connection = 'no'
password = '8867'
backup_file_path = 'C:\\Program Files\\Microsoft SQL Server\\MSSQL16.SQLEXPRESS\\MSSQL\\Backup\\sam_test.bak'

if windows_authentication:
    conn_str = f'DRIVER={{SQL Server}};SERVER={server_name};DATABASE={database_name};Trusted_Connection=yes;'
else:
    conn_str = f'DRIVER={{SQL Server}};SERVER={server_name};DATABASE={database_name};UID={username};PWD={password};Trusted_Connection={trusted_connection};'

try:
    conn = pyodbc.connect(conn_str)
    cursor = conn.cursor()
except Exception as e:
    print(f"Error: {e}")

restore_query = f'''
RESTORE DATABASE {target_database_name}
FROM DISK = '{backup_file_path}'
WITH REPLACE, RECOVERY;
'''

try:
    conn.autocommit = True
    cursor.execute(restore_query)
    print(f"Database '{target_database_name}' restored successfully!")
except Exception as e:
    print(f"Error: {e}")
finally:
    conn.autocommit = False
    if conn is not None:
        while cursor.nextset():
            pass 
        conn.close()