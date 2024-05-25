#!/bin/bash
. /root/scripts/./funciones.lib

# Constantes
soft="zimbra"
msn="bkp-rsy-$soft "
origen="/opt/zimbra"
destino="/media/datos/backup/zimbra"
bkpdir="/media/datos/backup/$fecha/zimbra"

mkdir $bkpdir

# Stop Zimbra
su - zimbra -c"/opt/zimbra/bin/zmcontrol stop"
sleep 15

rsync -avzrtu --delete $origen $destino/

# Display Zimbra services status
su - zimbra -c"/opt/zimbra/bin/zmcontrol start"

tar cvzf $bkpdir/$soft-$fecha2.tgz $destino/$soft