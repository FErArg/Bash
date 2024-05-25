#!/bin/bash
. /root/scripts/./funciones.lib

export RESTIC_PASSWORD='PASSWORD_REPO_RESTIC'
ORIGEN="/opt/zimbra"
DESTINO="/media/datos/backup/zimbra/zimbra-bkp"
app="zimbra"
log="/root/logs/restic/$app.log"

touch $log

echo Inicio $fecha - $hora >> $log
telegram "restic zimbra Inicio"

su - zimbra -c"/opt/zimbra/bin/zmcontrol stop"

restic -r $DESTINO backup $ORIGEN

su - zimbra -c"/opt/zimbra/bin/zmcontrol start"

echo Fin $fecha - $hora >> $log
telegram "restic zimbra Fin"