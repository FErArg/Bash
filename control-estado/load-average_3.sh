#!/bin/bash
. /root/scripts/./funciones.lib

# Constantes
log1='/tmp/load-average_3-1.log'
log2='/tmp/load-average_3-2.log'
loadAverageMaximo='5,00'
loadAverage1=$(uptime | awk '{print $8}' | cut -d "," -f 1)
loadAverage1=${loadAverage1/./,}

touch $log1
touch $log2

echo $loadAverageMaximo
echo $loadAverage1

if [ $loadAverage1 \> $loadAverageMaximo ]
  then
        echo "LA > loadAverageMaximo"
        echo "LoadAverage > $loadAverageMaximo, reinicia en 10 segundos" > $log1
        cat $log1
        telegram "$(cat $log1)"
        sleep 10
        reboot
  else
        echo "LA < loadAverageMaximo"
        echo "LoadAverage $loadAverage1 > LoadAverageMaximo $loadAverageMaximo" > $log2
        cat $log2
        telegram "$(cat $log2)"
fi

rm $log1
rm $log2