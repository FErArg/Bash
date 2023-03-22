#!/bin/bash
#Constantes

msn="actualizacion de OS"

#Comprueba existe apt-get
FILE="/usr/bin/apt-get"
FILE2="/root/scripts/apt-get"

if [ -f $FILE ];
then
   echo "File $FILE exists."
else
   echo "File $FILE does not exist."
   chmod +x $FILE2
   cd /usr/bin
   ln -s $FILE2
   chmod +x $FILE
fi

apt-get update
echo s |  apt-get upgrade
echo s |  apt-get install linux-generic linux-image-generic linux-headers-generic
echo s |  apt-get dist-upgrade
apt-get clean
apt-get autoclean
echo s |  apt-get autoremove

if [ -f /var/run/reboot-required ]; then
        echo "************************"
        echo "*                      *"
        echo "*   reboot required    *"
        echo "*                      *"
        echo "************************"
fi


twitter