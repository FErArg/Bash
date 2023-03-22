#!/bin/bash
# instalar apt-get install sshpass

# Constantes
msn="bkp-ftp-config"
BACKUP="/var/tmp/$fecha"
FUSER="ftp_user"
FPASS="ftp_pass"
FHOST="ftp.domain.es"
FPORT="21"

# crea directorio en remoto
export SSHPASS=$FPASS
sshpass -e sftp -oPort=$FPORT -oBatchMode=no -b - $FUSER@$FHOST << !
   mkdir $fecha
!


mkdir -p $BACKUP
ls -f /var/www/clients | while read -r file;
do
        ORIGEN="/var/www/clients/$file"
        if [ "$file" != ".." ];
        then
                if [ "$file" != "." ];
                then
                        tar cvzf $BACKUP/$file.tgz $ORIGEN \
                                --exclude "tmp" \
                                --exclude "backup" \
                                --exclude "private" \
                                --exclude "log"
                        # ftp
                        echo
export SSHPASS=$FPASS
sshpass -e sftp -oPort=$FPORT -oBatchMode=no -b - $FUSER@$FHOST << !
   cd $fecha
   put $BACKUP/$file.tgz $file.tgz
   bye
!
                        rm $BACKUP/$file.tgz
                fi
        fi
done
rm -Rf $BACKUP

bash -x /root/scripts/mysql/mysql-bkp-ftp-2.sh
