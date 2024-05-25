#!/bin/bash
. /root/scripts/./funciones.lib

# Constantes
msn="desknow-bk-db"
destino="/media/backup/$fecha/Desknow"

mkdir -p $destino

mysqldump --user=desknow --password=CLAVE --single-transaction --skip-opt \
--add-drop-table --add-locks --create-options --disable-keys --extended-insert \
--quick --set-charset desknow | gzip -9 > $destino/$fecha-$hora-desknow-backup.gz