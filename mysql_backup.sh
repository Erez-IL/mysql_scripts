#!/bin/bash

# MySQL username and password. chmod this script to 0700.
USERNAME=""
PASSWORD=""
MYSQL_BASE="/usr/bin/mysql -u $USERNAME -p$PASSWORD"

BACKUP_DIR="/root/backups/sql"
BACKUP_DATE=$(date +'%Y_%m_%d')

# If you want to exclude databases, just add them to the egrep expression, pipe separated
BACKUP_DBS=$($MYSQL_BASE -e 'show databases;'|/bin/egrep -vi "(\+|database|information_schema|mysql)")

# Remove backups older than 10 days
/usr/bin/find $BACKUP_DIR -maxdepth 1 -type d -mtime +9 -exec rm -rf {} \;

# Backup
for db in $BACKUP_DBS
do
  DB_DIR="$BACKUP_DIR/$BACKUP_DATE/$db"
  TABLES=$($MYSQL_BASE -D $db -e 'show tables;'|/bin/egrep -vi "(\+|tables)")

  # Creating directory and dumping tables
  /bin/mkdir -p $DB_DIR

  for table in $TABLES
  do
    /usr/bin/mysqldump -u $USERNAME -p$PASSWORD --add-drop-table $db $table|/bin/gzip -9 > $DB_DIR/$table.gz
  done
done
