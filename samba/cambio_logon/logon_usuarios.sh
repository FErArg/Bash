#!/bin/bash
TOT=`wc -l < usuarios.txt`
I=1
while [ $I -le $TOT ]
do
linea=`sed -n ${I}l usuarios.txt`
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

#	useradd -g $dep1 -G profes -s /bin/false -d /home/$usu $usu
#	useradd -g $dep1 -s /bin/false -d /home/$usu $usu

#	cp /home/samba/netlogon/0_script/logon.bat /home/samba/netlogon/$usu/logon.bat
#	cp /home/samba/netlogon/0_script/$dep1.$dep2.bat /home/samba/netlogon/$usu/logon.bat
    cp /home/samba/netlogon/0_script/$dep1.bat /home/samba/netlogon/$usu/logon.bat

        echo Modificado archivo Logon profesor $nombre con Usuario: $usu del Departamento $dep1

#   fi
I=`expr $I + 1`
done