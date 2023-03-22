#!/bin/bash

mes="$(date +%G-%B)"
log="/root/logs/robotRw.$fecha.B.txt"
red="172.26.1"

touch $log
echo "" >> $log

echo "" >> $log
echo "-------------------------------------------------------------" >> $log
echo "" >> $log
echo "$fecha - $hora" >> $log
echo "" >> $log
echo "" >> $log

TOT=254
I=1
while [ $I -le $TOT ]
do
        ip=$red.$I

        if ping -c 1 -W 1 $ip>/dev/null
        then
                echo "$ip - Encendido" >> $log
                nmap -sC -p445 --open --max-hostgroup 3 --script smb-vuln-ms17-010.nse $ip >> $log
                echo "-------------------------------------------------------------" >> $log
                echo "" >> $log

        else
                echo "$ip - Apagado"
        fi

I=`expr $I + 1`
done

mutt -a $logmes -s "Equipos Encendidos - $fecha $hora" $email1 < $log
mutt -a $logmes -s "Equipos Encendidos - $fecha $hora" $email2 < $log