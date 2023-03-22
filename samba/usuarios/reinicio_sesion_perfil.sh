#!/bin/bash

# Constantes

if grep  "$1:" /etc/passwd
   then
        usu=$1
        mv /home/$usu/profiles/Escritorio/ /home/$usu/personal/ 
        mv /home/$usu/profiles/Mis\ documentos/ /home/$usu/personal/ 
        rm -Rf /home/$usu/profiles/*
        
        echo "Reinicio sesion Usuario: $usu "
        echo "Reinicio sesion Usuario: $usu " >> /root/samba/reinicio_sesion_perfil.txt
   else
        echo "El Usuario: " $usu " NO ya existe"
fi