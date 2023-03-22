#!/bin/bash

BACKUP="/media/backup/$fecha/mysql"
MUSER="USUARIO"
MPASS="CLAVE"
MHOST="localhost"
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
FUSER="USUARIO"
FPASS="CLAVE"
FHOST="backupsi.mine.nu"
FPORT="60021"
GZIP="$(which gzip)"
NOW=$(date +"%Y-%m-%d"-%H-%M)
msn="Backup MySQL"

mkdir -p $BACKUP

DBS="$($MYSQL -u $MUSER -h $MHOST -p$MPASS -Bse 'show databases')"
for db in $DBS
do
        FILE0="$db-$NOW.gz"
        FILE=$BACKUP/$FILE0
        $MYSQLDUMP -u $MUSER -h $MHOST -p$MPASS $db | $GZIP -9 > $FILE

        # ftp
        echo "
        open $FHOST $FPORT
        user $FUSER $FPASS
        bin
        passive
        prompt
        mkdir $fecha
        cd $fecha
        mkdir MySQL
        cd MySQL
        put $FILE $FILE0
        bye
        " | ftp -n
done


done

twitter