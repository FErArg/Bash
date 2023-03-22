#!/bin/bash
. /root/scripts/./funciones.lib

msn="rsync remoto"
usuario="ferarg"
origen="/var/desknow"
destino="/media/archivos-3/SerInformaticos/Server"
remoto="192.168.1.10"
exclude="/home/ferarg/scripts/rsync/excluir.txt"

rsync -e 'ssh -p 1978' -avzlL --delete --stats --progress --exclude-from \
$exclude $origen $usuario@$remoto:$destino/

twitter