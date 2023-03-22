#!/bin/bash
#Constanstes
asunto="Backup a Box.net"
msn=$asunto
log="/root/logs/backup.box.net.log"
destino1="/tmp/$fecha"
destino2="/media/backup/$fecha/Box"
box="/media/box.net/$fecha"
ex1="--exclude"
ex2="   $ex1 BitPocket \
        $ex1 ownCloud \
        $ex1 clamav \
        $ex1 configuraciones.tgz \
        $ex1 dead.letter \
        $ex1 downloads \
        $ex1 Git \
        $ex1 clam* \
        $ex1 webmin
"
touch $log

echo "Inicio $(date)" >> $log

mount /media/box.net
sleep 5

mkdir -p $box
mkdir -p $destino1

tar cvzf $destino1/etc.tgz $ex2 /etc
tar cvzf $destino1/root.tgz $ex2 /root
tar cvzf $destino1/var.lib.samba.tgz /var/lib/samba
bkpfile="$destino1/paquetes-instalados.txt"
dpkg --get-selections | awk '{print $1}' > $bkpfile

tar cvzf /tmp/$fecha.tgz $destino1
rm -Rf $destino1

echo -n "CLAVE ENCRIPTAR" | openssl des3 -salt -in "/tmp/$fecha.tgz" -out "/tmp/$fecha.tgz.des3" -pass stdin

mv /tmp/$fecha.tgz $destino2/
mv /tmp/$fecha.tgz.des3 $box/

echo "Fin $(date)" >> $log
echo "--------------------" >> $log

mutt -s "$asunto $fecha" $email1 < $log
mutt -s "$asunto $fecha" $email2 < $log
twitter

umount /media/box.net