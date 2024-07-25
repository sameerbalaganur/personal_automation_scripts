import pymssql
import argparse
from pymssql import _mssql


parser = argparse.ArgumentParser(description="Database Banckup script")
parser.add_argument("-H", "--dbserver", help="DB Host")
parser.add_argument("-u", "--dbuser", help="DB User")
parser.add_argument("-p", "--dbpassword", help="DB Password")
parser.add_argument("-d", "--dbname", help="DB To be connected")
parser.add_argument("-b", "--dbbackup", help="DB to be backed up")
parser.add_argument("-f", "--dbfile", help="DB File")
parser.add_argument("-s", "--sec_db", help="Secondary DB")
parser.add_argument("-x", "--db_pub_server", help="Publication Server")
parser.add_argument("-y", "--db_sec_file", help="Secondary")
# parser.add_argument("H", "--dbserver", help="DB Host")
args = parser.parse_args()
import pdb
backup_file_path = 'C:\\Program Files\\Microsoft SQL Server\\MSSQL16.SQLEXPRESS\\MSSQL\\Backup\\<name>.bak'

ACTIVITIES = ["drop_pub", "drop_sub", "restore_db_prim", "restore_db_sec" ,"restore_pub", "restore_sub"]


SQL_BACKUP_FILES = {
    "drop_pub": "1_Drop publication.sql",
    "drop_sub": "2_Drop Subscription.sql",
    "restore_db_prim": "p_db_restore.sql",
    "restore_db_sec": "p_db_restore.sql",
    "restore_pub": "3_Distribution_publication.sql",
    "restore_sub": "4_Subscription.sql"
}
database=args.dbname
conn = _mssql.connect(server=args.dbserver, user=args.dbuser, password=args.dbpassword, database=args.dbname)
restore_query = f'RESTORE DATABASE {database} FROM DISK={backup_file_path}'



# conn.execute_non_query("IF EXISTS (SELECT 0 FROM sys.databases WHERE name = 'mydb') BEGIN ALTER DATABASE mydb MODIFY NAME = mydb_old END")
# conn.execute_non_query("RESTORE DATABASE mydb FROM DISK='C:\mydb.bak'")

# connection = pymssql.connect(server=args.dbserver,
#                         user=args.dbuser,
#                         password=args.dbpassword,
#                         database=args.dbname,
#                         autocommit=True)

# cur = connection.cursor()