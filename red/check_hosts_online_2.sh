#!/bin/bash

mes="$(date +%G-%B)"
log="/root/logs/Red.$fecha.B.txt"
logmes="/root/logs/Red.$mes.B.txt"
red="172.26.0"

touch $log

echo "En el archivo Adjunto aparecen los ordenadores encendidos de todo el mes" >> $log
echo "" >> $log

echo "" >> $logmes
echo "-------------------------------------------------------------" >> $logmes
echo "" >> $logmes
echo "$fecha - $hora" >> $logmes
echo "" >> $logmes
echo "" >> $logmes

TOT=254
I=1
while [ $I -le $TOT ]
do
        ip=$red.$I

        if ping -c 1 -W 1 $ip>/dev/null
        then
                echo "$ip - Encendido" >> $log
                echo "$ip - Encendido" >> $logmes
        else
                echo "$ip - Apagado"
        fi

I=`expr $I + 1`
done

mutt -a $logmes -s "Equipos Encendidos - $fecha $hora" $email1 < $log