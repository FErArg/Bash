#!/bin/bash

interface="bond0"
red="172.26.2."
log="/root/logs/Red3/$fecha.log"
asunto="$hostname - Red3 Bloquear"

#Hora a la que envía email
horaEnvio="23.00"

echo "$hora - $horaEnvio"

touch $log

#arp-scan --interface bond0 -l | grep '172.26.1.*' | awk '{print $1,"\t",$2}'
arp-scan --interface $interface -l | \
        grep $red'.*' | \
        awk '{print $1,"\t",$2,"\t",$3}' >> $log

sort -u $log > $log.tmp
#uniq $log.1 > $log.2
mv $log.tmp $log


if [[ $hora == $horaEnvio ]];
then
        tar cvzf $log.tgz $log
        echo $asunto | mutt -s "$asunto $fecha" -a "$log.tgz" -- $email1
else
        echo "no es la hora de envio"
fi