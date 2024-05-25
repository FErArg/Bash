#!/bin/bash
. /root/scripts/./funciones.lib

export RESTIC_PASSWORD='PASSWORD_RESTIC_REPO'
ORIGEN="/var/www"
DESTINO="/media/datos/backup/www"
app="www"
log="/root/logs/restic/$app.log"

touch $log

echo Inicio $fecha - $hora >> $log
telegram "restic www Inicio"

restic -r $DESTINO backup $ORIGEN \
	--exclude="/var/www/rs" \
	--exclude="/var/cloudsi" 

twitter
echo Fin $fecha - $hora >> $log
telegram "restic www Fin"