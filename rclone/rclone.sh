#!/bin/bash

asunto="rClone resourcespace"
origen="/media/datos/backup/resourcespace/"
destino="hubic-crypt"
directorio="resourcespace/resourcespace"
archivo="resourcespace/diferencial"
log="/root/logs/rclone/$fecha-$hora-Resourcespace.log"

touch $log

rclone sync $origen $destino:$directorio/ \
 --backup-dir=$destino:$archivo/$fecha.$hora \
 --log-file=$log --log-level INFO

mutt -s "$asunto $fecha" $email1 < $log
