#!/bin/bash
TOT=`wc -l < ususmb.txt`
I=1
while [ $I -le $TOT ]
do
linea=`sed -n ${I}l ususmb.txt`
usu=`echo $linea | cut -d";" -f1`

#if grep  "^${usu}:" /etc/passwd
#   then
#      echo "El Usuario: " $usu " ya existe"
#   else 
        usu=`echo $linea | cut -d";" -f1`
        nombre=`echo $linea | cut -d";" -f2`
        clave=`echo $linea | cut -d";" -f3`
        dep1=`echo $linea | cut -d";" -f4`	
#        dep2=`echo $linea | cut -d";" -f5`


echo	"4 Actualizando Clave"
    echo -e $clave\\n$clave\\n | smbpasswd -as $usu
        echo $usu:$clave | chpasswd
        

        echo Actualizando Clave de $nombre con Usuario: $usu y Clave: $clave del Departamento $dep1

#fi
I=`expr $I + 1`
done