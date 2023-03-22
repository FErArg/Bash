#!/bin/bash

#Constantes
msn="bkp mdl"
origenMdl="/var/www/mdl"
origenMdldata="/var/www/mdldata"
destino="/media/backup/$fecha/moodle"
usuarioDB="moodle"
claveDB="moodleP"

mkdir -p $destino

mysqldump --user=$usuarioDB --password=$claveDB $usuarioDB > $destino/$usuarioDB.sql
tar cvzf $destino/$usuarioDB.mdl.tgz  $origen1
tar cvzf $destino/$usuarioDB.mdldata.tgz  $origen2

twitter