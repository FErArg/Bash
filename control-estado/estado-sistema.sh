#!/bin/bash

log="/root/logs/$fecha.Server1.log"
asunto="Estado del Sistema"
msn=$asunto

echo $log
echo >> $log
echo Estado del Sistema - Enviado desde Su Servidor - $servidor $hostname>> $log
echo >> $log
echo $hostname >> $log
echo >> $log
echo >> $log
echo ======================================================================================== >> $log
date >> $log
echo ======================================================================================== >> $log
echo Tiempo en Funcionamiento >> $log
echo >> $log
uptime >> $log
echo ---------------------------------------------------------------------------------------- >> $log
echo Estado Particiones>> $log
echo >> $log
df -lh >> $log
echo ---------------------------------------------------------------------------------------- >> $log
echo Estado Memoria >> $log
echo >> $log
free -m >> $log
echo ---------------------------------------------------------------------------------------- >> $log
echo Estado Bond0>> $log
echo >> $log
cat /proc/net/bonding/bond0 >> $log
echo ---------------------------------------------------------------------------------------- >> $log
echo Estado RAIDS>> $log
echo >> $log
cat /proc/mdstat >> $log
echo ---------------------------------------------------------------------------------------- >> $log
echo Estado Red>> $log
echo >> $log
ifconfig >> $log
echo ---------------------------------------------------------------------------------------- >> $log
echo ""
echo ""
echo ""
echo ""
echo ""
echo Aviso por email de FErArg.com >> $log

mutt -s "$asunto $fecha" $email1 < $log