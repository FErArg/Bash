nano #!/bin/bash

#Constanstes
asunto="Estado Discos"
msn=$asunto
log="/root/logs/$fecha.$hora.Servidor1.log"

echo >> $log
echo "Estado del Sistema - Enviado desde Su Servidor - $servidor $hostname" >> $log
echo >> $log
echo "$hostname" >> $log
echo >> $log
echo >> $log
echo "========================================================================================" >> $log
date >> $log
echo "========================================================================================" >> $log
echo "Tiempo en Funcionamiento" >> $log
echo >> $log
uptime  >> $log
echo "----------------------------------------------------------------------------------------" >> $log
echo "Estado Particiones" >> $log
echo >> $log
df -h >> $log
echo "----------------------------------------------------------------------------------------" >> $log
echo "Estado Memoria" >> $log
echo >> $log
free -m >> $log
echo "----------------------------------------------------------------------------------------" >> $log
echo "Estado RAID" >> $log
echo >> $log
cat /proc/mdstat >> $log
echo "----------------------------------------------------------------------------------------" >> $log
echo "Estado RAID /dev/md0" >> $log
echo >> $log
mdadm --detail /dev/md0 >> $log
echo "----------------------------------------------------------------------------------------" >> $log
echo "Estado RAID /dev/md1" >> $log
echo >> $log
mdadm --detail /dev/md1 >> $log
echo "----------------------------------------------------------------------------------------" >> $log
echo "Estado RAID /dev/md2" >> $log
echo >> $log
mdadm --detail /dev/md2 >> $log
echo "----------------------------------------------------------------------------------------" >> $log
echo "Estado RAID /dev/md3" >> $log
echo >> $log
mdadm --detail /dev/md3 >> $log
echo "----------------------------------------------------------------------------------------" >> $log
echo "Estado RAID /dev/md4" >> $log
echo >> $log
mdadm --detail /dev/md4 >> $log
echo "----------------------------------------------------------------------------------------" >> $log
echo "Aviso por email de SerInformaticos.es" >> $log

mutt -s "$asunto $fecha" $email1 < $log