#!/bin/bash
# Constantes
free=`free -mt | grep Total | awk '{print $4}'`

# limite de memoria para que se limpir la RAM
# memoria en MB
memoria="10000" # mb

echo "memoria libre $free mb"
echo "mínimo memoria libre $memoria mb"
echo ""

if [ $free -lt $memoria ];  then
        echo "Memoria Libre '$free'mb'"
        echo "Se Limpia Memoria"
        msn="memoria ram libre $free, se limpia"
        twitter
        free && sync && echo 3 > /proc/sys/vm/drop_caches && free
else
        echo "No se limpia memoria"
fi