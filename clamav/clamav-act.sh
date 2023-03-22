#!/bin/bash

#Constantes
destino1="/tmp"
msn="Clam-Av Actualizado"

echo "Actualizando archivos desde Internet"
mkdir $destino1

wget http://db.local.clamav.net/daily.cvd -P$destino1/
wget http://db.local.clamav.net/main.cvd -P$destino1/

echo "actualizando bases"
clamscan -d $destino1

rm $destino1/daily.cvd
rm $destino1/main.cvd