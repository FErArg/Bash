#!/bin/bash

#Constantes
msn="bkp mdl ftp"
origenMdl="/var/www/mdl"
origenMdldata="/var/www/mdldata"

usuarioDB="MoodleUsuarioDB"
claveDB="MoodleClaveDB"

server="dominio.com 60021"
user="usuarioFTP"
passwd="claveFTP"

destino="/tmp/$fecha"

mkdir -p $destino

mysqldump --user=$usuarioDB --password=$claveDB $usuarioDB > $destino/$usuarioDB.sql
tar cvzf $destino/$usuarioDB.mdl.tgz  $origenMdl
tar cvzf $destino/$usuarioDB.mdldata.tgz  $origenMdldata

tar cvzf /tmp/$fecha.tgz $destino

echo "
open $server
user $user $passwd
bin
prompt
mkdir $fecha
cd $fecha
put /tmp/$fecha.tgz $fecha.tgz
bye
" | ftp -n

rm -Rf $destino/$fecha
rm -Rf /tmp/$fecha.mdl.tgz

twitter