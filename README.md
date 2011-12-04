# Two simple bash scripts to backup and restore databases.

It uses mysqldump for backups, please do what the manual says and consider using mysqlhotcopy. 

Also, don't use this on heavily witten databases as mysqldump will table-lock and you'll have problems. The correct approach is to use
[mysql replication][mr] for this.

## mysql_backup.sh

Three bash variables you want to edit: USERNAME, PASSWORD, BACKUP_DIR. Own it to root and chmod 0500 or similar.

## mysql_restore.sh

Configure USERNAME, PASSWORD. Same permissions as with above.

[mr]: http://dev.mysql.com/doc/refman/5.0/en/replication.html
