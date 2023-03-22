#!/bin/bash


#Constantes
msn="Actualiza Hora"
horafile="/root/logs/hora.log"
hora1="$(/bin/date)"
horaH1="$(/sbin/hwclock)"

echo "" >> $horafile
echo $(uptime) >> $horafile
echo "" >> $horafile
echo "hora antes de actualizar: $hora1" >> $horafile
echo "hora antes H de actualizar: $horaH1" >> $horafile

/etc/init.d/ntp stop
/usr/sbin/ntpdate es.pool.ntp.org
/sbin/hwclock --systohc
/etc/init.d/ntp start

hora2="$(/bin/date)"
horaH2="$(/sbin/hwclock)"

echo "Hora despues de actualizar: $hora2" >> $horafile
echo "hora despues H de actualizar: $horaH2" >> $horafile

echo "----------------------------------------------------------" >> $horafile

