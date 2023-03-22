#!/bin/bash

#Constantes
files=( /home /media/datos /var / /opt )
max="50"
log="/root/logs/$fecha-Control-disco-lleno-email.log"
asunto="Discos en Estado Critico - $disco"
msn=$asunto

touch $log

# find total number of files in an array
total=${#files[*]}

# Use for loop iterate through an array
# $f stores current value
for f in "${files[@]}"
do
        echo -n "$f "
        echo
        paso1="$(df -P $f | grep $f | awk '{ print $5}')"
        porcentaje="$(echo $paso1 | sed 's/%//g')"

        if [ $max -gt $porcentaje ]
                then
                echo "Espacio ocupado $porcentaje % DEBAJO del Máximo de $max %"
                echo
        else
                msn="Espacio ocupado $porcentaje % SOBRE del Máximo de $max %"
                echo $msn
                echo
                # Email
                echo >> $log
                echo Estado de Disco - Enviado desde Su Servidor - $servidor $hostname >> $log
                echo >> $log
                echo ======================================================================================== >> $log
                echo $fecha $hora >> $log
                echo ======================================================================================== >> $log
                echo >> $log
                echo Estado Particiones $f >> $log
                echo >> $log
                echo $msn >> $log
                echo >> $log
                echo ---------------------------------------------------------------------------------------- >> $log
                echo >> $log
                echo Aviso por email de SerInformaticos.es >> $log
                echo >> $log
                #
                mutt -s "$asunto $msn $fecha" $email1 < $log
        fi

done