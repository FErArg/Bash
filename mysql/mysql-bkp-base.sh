#!/bin/bash

#Constantes
msn="egroupware-bkp"
destino="/media/backup/$fecha/egroupware"

mkdir -p $destino

mysqldump --user=egroupware --password=clave10 egroupware > $destino/egroupware-backup.sql

cp /var/lib/egroupware/default/backup/*.bz2 $destino

tar czf $destino/var.www.egroupware.tgz  /var/www/egroupware/
tar czf $destino/var.lib.egroupware.tgz  /var/lib/egroupware/
tar czf $destino/usr.share.egroupware.tgz /usr/share/egroupware/

twitter