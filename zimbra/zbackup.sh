#!/bin/bash
. /root/scripts/./funciones.lib

# Constantes
msn="bkp server2"
USER="server"
PASS="CLAVE"
HOST="192.168.1.1"
PORT="8022"
origen="/opt/zimbra"
destino="/media/backup/zimbra"
bkpdir="/media/backup/zimbra/$fecha-$hora"
export SSHPASS=$PASS

#su - zimbra -c"/opt/zimbra/bin/zmcontrol stop"
#sleep 15

# Kill any orphaned Zimbra processes
#ORPHANED=`ps -u zimbra -o "pid="` && kill -9 $ORPHANED

sshpass -e rsync -avrt --delete \
        -z --compress-level=5 \
        -b --backup-dir=$bkpdir \
        --no-owner --no-group \
        $origen -e 'ssh -p 8022' $USER@$HOST:$destino

# Only enable the following command if you need all Zimbra user owned
# processes to be killed before syncing
# ps auxww | awk '{print $1" "$2}' | grep zimbra | kill -9 `awk '{print $2}'`

# Display Zimbra services status
#su - zimbra -c "/opt/zimbra/bin/zmcontrol status"
#su - zimbra -c"/opt/zimbra/bin/zmcontrol start"

sshpass -e ssh -p 8022 $USER@$HOST "cd $destino && tar cvzf $bkpdir.tgz $bkpdir && rm -Rf $bkpdir"