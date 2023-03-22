#!/bin/bash

# Constantes
msn="rsy home/smb"
origen="/home/smb"
destino="/media/nas/Archivos/"
bkpdir="/media/nas/$fecha/"

# mueve desde destino a directorio de backup todo lo que no este en origen
rsync -e 'ssh -p 2223' \
    -z --compress-level=5 \
    -avrt -b --backup-dir=$bkpdir \
    $origen $destino

# sincroniza y elimina lo que se haya eliminado en origen y excluye lo el/los directorio ".Trash*"
rsync -e 'ssh -p 2223' \
    -z --compress-level=5 \
    -av --delete \
    $origen $destino

twitter

