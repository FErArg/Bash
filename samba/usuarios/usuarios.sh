#!/bin/bash

# Constantes
DB="/root/scripts/samba/usuarios.db"
usuCreados="/root/usuarioSamba.txt"

TOT=`wc -l < $DB`
I=1
while [ $I -le $TOT ]
do
linea=`sed -n ${I}l $DB`
usu=`echo $linea | cut -d";" -f2`

if grep  "^${usu}:" /etc/passwd
then
    echo "El Usuario: " $usu " ya existe"
else
    nombre=`echo $linea | cut -d";" -f1`
    usu=`echo $linea | cut -d";" -f2`
    grupo=`echo $linea | cut -d";" -f3`
    clave=`echo $linea | cut -d";" -f4`
    # clave="$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c6)"
    server="Server1"
    homeusu="/home/$usu"

    echo    "0 - Grupo"
        if grep  "^${grupo}:" /etc/groups
        then
            addgroup $grupo
        else
            echo "Grupo $grupo ya existe, no se agrega a /etc/groups"
        fi

    echo    "1 - Crea Directorios Usuario"
        mkdir -p $homeusu

    echo    "2 - Agrega Usuario"
        #useradd -g $dep1 -s /bin/false -d $homeusu $usu
        useradd -g $dep1 -s /bin/bash -d $homeusu $usu
        gpasswd -a $usu $dep1

    echo    "3 - Asigna clave a samba y a sistema"
        echo -e $clave\\n$clave\\n | smbpasswd -as $usu
        echo $usu:$clave | chpasswd

    echo    "4 - Cambia permisos"
        chown -R $usu:$dep1 $homeusu
        chmod -R 0755 $homeusu

    echo 	"5 - Agrega a Cambioclave"
        echo "$usu;$usu@colegioelarmelar.org;" >> /var/www/claves/tools/datos/usuarios.db

    echo 	"6 - Test de usuario SMB"
        echo $clave | smbclient -L localhost -U $usu

    echo 	"7 - FIN"
        echo "Creado $nombre - Usuario: $usu - Clave: $clave - Grupo $dep1 - Home: $homeusu"
        echo "Creado $(date) -$nombre - Usuario: $usu - Clave: $clave - Grupo $dep1 - Home: $homeusu" >> $usuCreados


  fi
I=`expr $I + 1`
done