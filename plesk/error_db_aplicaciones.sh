#!/bin/bash

DB="/root/scripts/samba/usuarios.db"


TOT=`wc -l < $DB`
I=1
while [ $I -le $TOT ]
do
linea=`sed -n ${I}l $DB`
app=`echo $linea | cut -d";" -f1`
    mkdir $app
I=`expr $I + 1`
done