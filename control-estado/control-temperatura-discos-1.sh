#!/bin/bash

HDDS="/dev/sda /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf"
HDT=/usr/sbin/hddtemp
LOG=/usr/bin/logger
DOWN=/sbin/shutdown

ALERT_LEVEL=55

for disk in $HDDS
do
  if [ -b $disk ]; then
        HDTEMP=$($HDT $disk | awk '{ print $4}' | awk -F '°' '{ print $1}')
        re='^[0-9]+$'
        if ! [[ $HDTEMP =~ $re ]] ; then
           #echo "error: Not a number" >&2; exit 1
           HDTEMP=$($HDT $disk | awk '{ print $3}' | awk -F '°' '{ print $1}')
        fi

        if [ $HDTEMP -ge $ALERT_LEVEL ]; then
           msn="$hostname - Sistema procede a apagarse, temperatura de $disk es de $HDTEMP°C y ha cruzado el límite"
           echo $msn
           $LOG $msn
           sync;sync
           # $DOWN -h 0
        else
           msn="$hostname - Temperatura de $disk es de $HDTEMP°C"
           echo $msn
        fi
  fi
done