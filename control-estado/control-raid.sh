#!/bin/bash

# Constantes
msn="RAID Error"
msn2="RAID OK"
log="/root/logs/raid.log"

touch $log
echo "---------------------------------------------------------------" >> $log
echo " " >> $log
echo "Fecha = $fecha" >> $log
echo " " >> $log
echo "Hora  = $hora" >> $log
echo " " >> $log
echo "---------------------------------------------------------------" >> $log
echo " " >> $log

if egrep "\[.*_.*\]" /proc/mdstat  > /dev/null
then
  logger -p daemon.error "mdcheck: Failure of one or more software RAID devices"
  cat /proc/mdstat >> $log
  echo " " >> $log
  echo "---------------------------------------------------------------" >> $log
  echo " " >> $log
  tail /var/log/dmesg >> $log
  echo " " >> $log
  echo "---------------------------------------------------------------" >> $log
  echo " " >> $log
  tail /var/log/syslog >> $log
  echo " " >> $log
  echo "---------------------------------------------------------------" >> $log
  echo " " >> $log
  tail /var/log/daemon.log >> $log
  echo " " >> $log
  echo "---------------------------------------------------------------" >> $log
  echo " " >> $log
  cat /proc/diskstats >> $log
  echo " " >> $log
  echo "---------------------------------------------------------------" >> $log
  echo " " >> $log

  echo "Error en uno o mas RAID por software en ${hostname}" | \
  mutt -s "Software RAID device failure on " ${email1} < $log

  for i in $(seq 1 2 20)
    do
    beep -f 300.7 -r 2 -d 100 -l 400
  done
else
 echo $msn2
fi