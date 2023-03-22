#!/bin/bash

# VARIABLES
app="resourcespace"
asunto="rClone $app"
origen="/media/datos/backup/$app"
destino="hubic-crypt"
directorio="$app/$app"
archivo="$app/diferencial"
log="/root/logs/rclone/$app-$fecha-$hora.log"
GZIP="$(which gzip)"
MYSQLDUMP="$(which mysqldump)"
BKPDIR="/opt/www/rs/bkp-myql"

$MYSQLDUMP -u mysqlUser -pmysqlPass mysqlDb | $GZIP -9 > $BKPDIR/$(date +%Y%m%d-%H%M)-resourcespace.sql.gz
chown www-data:www-data -R $BKPDIR
chmod 006 -R $BKPDIR

touch $log

rclone sync $origen $destino:$directorio/ \
 --backup-dir=$destino:$archivo/$fecha.$hora \
 --exclude=.svn \
 --log-file=$log --log-level INFO

tar cvzf $log.tgz $log

# mutt -s "$asunto $fecha" $email1 < $log
mutt -s "$asunto $fecha" $email1 < "$asunto $fecha"
# mutt -s "$asunto $fecha" $email1 < $asunto $fecha -a $log

rm $log
twitter