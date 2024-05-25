#!/bin/bash
. /root/scripts/./funciones.lib

# Constantes
msn="desknowdata-rsy"
origen="/var/desknowdata"
destino="/media/backup/Desknow"
bkpdir="/media/backup/$fecha/Desknow"

mkdir -p $bkpdir

mysqldump --user=desknow --password=CLAVE --single-transaction \
	--skip-opt --add-drop-table --add-locks --create-options --disable-keys \
	--extended-insert --quick --set-charset desknow | gzip -9 > $destino/desknow-backup.gz

cp /etc/desknow.conf $destino/etc/
cp /etc/init.d/desknow $destino/etc/init.d/

# mueve desde destino a directorio de backup todo lo que no este en origen elimina en destino lo q no existe en origeb
rsync -avzrt -b --delete --suffix=."$(date +%F.%T)" --exclude ".Trash*" --exclude "*.*~" --exclude "log.*" --backup-dir=$bkpdir $origen $destino

#twitter

unset msn
unset origen
unset destino
unset bkpdir

# Constantes
msn="desknow-rsy"
origen="/var/desknow"
destino="/media/backup/Desknow"
bkpdir="/media/backup/1/Desknow/$fecha-backup"

rsync -avzrt -b --delete --suffix=."$(date +%F.%T)" --exclude ".Trash*" --exclude "*.*~" --exclude "log.*" --backup-dir=$bkpdir $origen $destino