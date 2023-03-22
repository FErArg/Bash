#!/bin/bash

# Constantes

if grep  "$1:" /etc/passwd
   then
        usu=$1
        clave="$(< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c8)"

echo    "3"
        echo -e $clave\\n$clave\\n | smbpasswd -as $usu
        echo $usu:$clave | chpasswd

echo    "7"
        echo "Cambio Clave Usuario: $usu - Clave: $clave "
        echo "Cambio Clave Usuario: $usu - Clave: $clave " >> /root/samba/cambiar_clave.txt
   else
        echo "El Usuario: " $usu " NO ya existe"
fi