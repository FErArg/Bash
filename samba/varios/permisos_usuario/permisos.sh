#!/bin/bash
TOT=`wc -l < permisos.txt`
I=1
while [ $I -le $TOT ]
do
linea=`sed -n ${I}l permisos.txt`
usu=`echo $linea | cut -d";" -f1`

        usu=`echo $linea | cut -d";" -f1`
        nombre=`echo $linea | cut -d";" -f2`
        clave=`echo $linea | cut -d";" -f3`
        dep1=`echo $linea | cut -d";" -f4`	
#        dep2=`echo $linea | cut -d";" -f5`

echo	"HOME"
    chown -R $usu /home/$usu
        chgrp -R profes /home/$usu
        chmod -R 0755 /home/$usu

echo    "Netlogon"
    chown -R $usu /home/samba/netlogon/$usu
    chgrp -R profes /home/samba/netlogon/$usu
    chmod -R 0755 /home/samba/netlogon/$usu

echo    "Profiles"
        chown -R $usu /home/samba/profiles/$usu
        chgrp -R profes /home/samba/profiles/$usu
        chmod -R 0755 /home/samba/profiles/$usu

        echo Permisos Modificados  profesor $nombre con Usuario: $usu Departamento $dep1

#  fi
I=`expr $I + 1`
done