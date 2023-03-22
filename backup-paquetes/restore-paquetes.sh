#!/bin/bash

#Constantes
bkpfile="/home/ferarg/scripts/paquetes-instalados.txt"

apt-get update

dpkg --set-selections < $bkpfile
dselect

apt-get upgrade