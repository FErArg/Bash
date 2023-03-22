#!/bin/bash

### System Setup ###
msn="mysql-bkp-ftp"
DIRS="/media/backup/bkp-ftp/desknow"
BACKUP=/media/backup/bkp-ftp/backup.$$
NOW=$(date +"%d-%m-%Y")
INCFILE="/media/backup/bkp-ftp/tar-inc-backup.dat"
DAY=$(date +"%a")
FULLBACKUP="Dom"


### MySQL Setup ###
MUSER=USUARIO
MPASS=CLAVE
MHOST="localhost"
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
GZIP="$(which gzip)"


### FTP server Setup ###
FTPD="//httpdocs/ferargsvr/incremental"
FTPU="USUARIO"
FTPP="CLAVE"
FTPS="SERVIDOR DESTINO"
NCFTP="$(which ncftpput)"


### Other stuff ###
EMAILID="avisos@serinformaticos.es"


### Start Backup for file system ###
[ ! -d $BACKUP ] && mkdir -p $BACKUP || :


### See if we want to make a full backup ###
if [ $DAY = $FULLBACKUP ]; then
  FTPD="//httpdocs/ferargsvr/full"
  FILE="fs-full-$NOW.tar.gz"
  tar -zcvf $BACKUP/$FILE $DIRS
  gpg -e -r $BACKUP/$FILE
  exit 0
else
  i=$(date +"%Hh%Mm%Ss")
  FILE="fs-i-$NOW-$i.tar.gz"
  tar -g $INCFILE -zcvf $BACKUP/$FILE $DIRS
  gpg -e -r $BACKUP/$FILE
fi


### Start MySQL Backup ###
# Get all databases name
DBS="$($MYSQL -u $MUSER -h $MHOST -p$MPASS -Bse 'show databases')"
for db in $DBS
do
FILE=$BACKUP/mysql-$db.$NOW-$(date +"%T").gz
$MYSQLDUMP -u $MUSER -h $MHOST -p$MPASS $db | $GZIP -9 > $FILE


### Encriptando BKP de MySQL ###
gpg -e -r $EMAILID $FILE
rm $FILE
done


### Dump backup using FTP ###
#Start FTP backup using ncftp
ncftp -u"$FTPU" -p"$FTPP" $FTPS<<EOF
mkdir $FTPD
mkdir $FTPD/$NOW
cd $FTPD/$NOW
lcd $BACKUP
mput *
quit
EOF


### Find out if ftp backup failed or not ###
if [ $? -eq 0 ]; then
 rm -f $BACKUP/*
 T=/tmp/backup.ok
 echo "Fecha: $(date)">$T
 echo "Equipo: $(hostname)" >>$T
 echo "Backup OK" >>$T
 mutt -s "BACKUP OK" "$EMAILID" <$T
 echo $T
 rm -f $T
exit 0
else
 T=/tmp/backup.fail
 echo "Fecha: $(date)">$T
 echo "Equipo: $(hostname)" >>$T
 echo "Backup ERROR" >>$T
 mutt -s "BACKUP ERROR" "$EMAILID" <$T
 rm -f $T
 echo $T
fi

twitter