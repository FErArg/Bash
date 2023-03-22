#!/bin/bash

#constantes
destino1="/root/clamav/"
destino2=$destino1/virus
log="/root/logs/clamav-$fecha.log"
asunto="Antivirus $hostname"
msn="Clam-AV-Ejecutado"

# Mueve y elimina directorios destino archivos infectados
# almacena los últimos 20 días
min="10"
max="20"
for (( R = $max ; R >= $min ; R-- ))
     do
     fecha2="$(date +%Y-%m-%d --date="-$R day")"
     rm -Rf $destino2/$fecha2
echo $fecha2
done

#Preparando Archivo Log
echo ====================================================================================== >> $log
echo $fecha - $hora >> $log
echo ====================================================================================== >> $log
echo  >> $log

#"Escaneo de ClamAV"
clamscan /home/ --log=$log --recursive --move=$destino2/$fecha/ --unrar --arj

#"Comprimiendo Virus"
tar -cvzf $destino2/virus.$fecha.tgz $destino2/$fecha

# "eliminando directorio del dia con virus"
rm -R $destino2/$fecha

# "comprimiendo virus" tar echo "Enviando Email"
mutt -a $log -s "$asunto - $fecha $hora" $email1 < $destino1/email.txt
