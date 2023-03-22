#!/bin/bash

BACKUP="/media/backup/$fecha/mysql"
MUSER=USUARIO
MPASS=CLAVE
MHOST="localhost"
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
GZIP="$(which gzip)"
NOW=$(date +"%Y-%m-%d"-%H-%M)
msn="Backup MySQL"

mkdir -p $BACKUP

DBS="$($MYSQL -u $MUSER -h $MHOST -p$MPASS -Bse 'show databases')"
for db in $DBS
do
    FILE=$BACKUP/mysql-$db-$NOW-$fecha.gz
    $MYSQLDUMP -u $MUSER -h $MHOST -p$MPASS $db | $GZIP -9 > $FILE
done

twitter