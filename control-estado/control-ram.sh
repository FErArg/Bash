#!/bin/bash
. /root/scripts/./funciones.lib

# Constantes
log="/tmp/control-ram.log"

# free | grep Mem | awk '{print $4/$2 * 100.0}' >> $log
# echo " %" >> $log

freeRam=$(free | grep Mem | awk '{print $4/$2 * 100.0}')

echo "Ram Libre $freeRam %"
echo "Ram Libre $freeRam %" >$log

sleep 1

if [ $freeRam \> 10 ]
  then
    echo "RAM > 10 %"
  else
    echo "RAM < 10 %"
	  telegram "$(cat $log)"
fi

rm $log