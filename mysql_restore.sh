#!/bin/bash

if [ -z $1 ] || [ -z $2 ]; then
  echo "$0 database table.gz"
  exit
fi

# MySQL username and password. chmod this script to 0700.
USERNAME=""
PASSWORD=""
MYSQL_BASE="/usr/bin/mysql -u $USERNAME -p$PASSWORD"

echo "Restoring $2 in database $1"
$(/bin/gunzip -c $2|$MYSQL_BASE $1) 
