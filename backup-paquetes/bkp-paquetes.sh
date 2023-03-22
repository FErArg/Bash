#!/bin/bash

#Constantes
bkpfile="/media/backup/$fecha/paquetes-instalados.txt"
msn="Bkp Paquetes deb"
dpkg --get-selections | awk '{print $1}' > $bkpfile