#!/bin/bash

mes="$(date +%G-%B)"
log="/root/logs/Red.$fecha.A.$hora.txt"
logmes="/root/logs/Red.$mes.A.txt"
DB="/root/scripts/red/check_hosts_online.db"

touch $log
echo "En el archivo Adjunto aparecen los ordenadores encendidos de todo el mes" >> $log
echo "" >> $log

echo "" >> $logmes
echo "-------------------------------------------------------------" >> $logmes
echo "" >> $logmes
echo "$fecha - $hora" >> $logmes
echo "" >> $logmes
echo "" >> $logmes

TOT=`wc -l < $DB`
I=1
while [ $I -le $TOT ]
do
linea=`sed -n ${I}l $DB`
        mac=`echo $linea | cut -d";" -f1`
        ip=`echo $linea | cut -d";" -f2`
        host=`echo $linea | cut -d";" -f3`

        if ping -c 1 -W 1 $ip>/dev/null
        then
                echo "$ip - $host - Encendido" >> $log
                echo "$ip - $host - Encendido" >> $logmes
        else
                echo "$ip - $host - Apagado"
        fi

I=`expr $I + 1`
done

mutt -a $logmes -s "Equipos Encendidos - $fecha $hora" $email1 < $log