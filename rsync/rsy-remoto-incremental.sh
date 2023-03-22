#!/bin/bash

# Backup incremental, almacena los archivos modificados en $bkpdir de remoto, NO EN LOCAL
# elimina los archivos remoto que no existan el local
# envia bkp de a DB

# Constantes
msn = "Rsync Nuevo Inicio $fechaHora"
twitter
msn="rsync /home nas1"
destino="/media/datos/Server1"
bkpdir="/media/datos/Server1/$fecha"
servidor="nas1"
usuario="root"
exclude="/root/scripts/rsync/excluir.txt"

origenes="/home /opt /var /root /etc"

for origen in $origenes;
do
  rsync -avrt --delete \
          -z --compress-level=5 \
          -b --backup-dir=$bkpdir \
          --no-owner --no-group \
          $origen -e 'ssh -p 2223' $usuario@$servidor:$destino/

  #        --exclude "owncloud-alumnos1.ext4" \
  #        --exclude "/home/ferarg*" \
  #        --exclude ".Trash*" --exclude "*.*~" --exclude-from $exclude \
  #        --max-size=200M \

  sleep 5
done