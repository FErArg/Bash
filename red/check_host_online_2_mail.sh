#!/bin/bash

mes="$(date +%G-%B)"
host="172.26.0.6"
asunto="Servidor Apagado"
log="/root/logs/$fecha.check_hosts_online_2_email.log"

if ping -c 1 -W 1 $host>/dev/null
then
  echo "$ip - Encendido - $fecha - $hora"
  // echo "$host - Encendido - $fecha - $hora" >> $log
else
  touch $log
  echo "" >> $log
  echo "-------------------------------------------------------------" >> $log
  echo "" >> $log
  echo "$host - APAGADO - $fecha - $hora"
  echo "$host - APAGADO - $fecha - $hora" >> $log
  echo "" >> $log
  echo "-------------------------------------------------------------" >> $log
  echo "" >> $log

  mutt -s "$asunto $fecha $hora" $email1 < $log
  mutt -s "$asunto $fecha $hora" $email2 < $log
fi
