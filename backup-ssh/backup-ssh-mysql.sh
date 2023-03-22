#!/bin/bash

BACKUP="/tmp/$fecha"
MUSER="root"
MPASS="CLAVE_ROOT_MYSQL"
MHOST="localhost"
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"

FUSER="ftp_user"
FPASS="ftp_pass"
FHOST="ftp.domain.es"
FPORT="21"
GZIP="$(which gzip)"
NOW=$(date +"%Y-%m-%d"-%H-%M)
msn="Backup MySQL"

mkdir -p $BACKUP

export SSHPASS=$FPASS
sshpass -e sftp -oPort=$FPORT -oBatchMode=no -b - $FUSER@$FHOST << !
   mkdir $fecha/MySQL
!


DBS="$($MYSQL -u $MUSER -h $MHOST -p$MPASS -Bse 'show databases')"
for db in $DBS
do
        FILE0="$db-$NOW.gz"
        FILE=$BACKUP/$FILE0
        $MYSQLDUMP -u $MUSER -h $MHOST -p$MPASS $db | $GZIP -9 > $FILE

        # sftp
export SSHPASS=$FPASS
sshpass -e sftp -oPort=$FPORT -oBatchMode=no -b - $FUSER@$FHOST << !
   cd $fecha
   put $FILE MySQL/$FILE0
   bye
!
                        rm $FILE
done

rm -Rf $BACKUP
