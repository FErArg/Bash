#!/bin/bash
. /root/scripts/./funciones.lib

# Constantes
msn="Backup DB Desknow PG"
destino="/media/backup/$fecha/Desknow/"
export PGPASSWORD=CLAVEDB

mount -t auto /dev/sdc1 /media/backup

mkdir -p $destino

pg_dump -h 127.0.0.1 -p 5432 -U desknowserver -v desknow -f $destino/$hora-desknowDB.dump

tar cvzf $destino/$hora-desknowDB.dump.tgz $destino/$hora-desknowDB.dump

rm -Rf $destino/$hora-desknowDB.dump

umount /media/backup