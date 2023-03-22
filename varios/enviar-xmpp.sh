#!/bin/bash
. /home/ferarg/scripts/./funciones.lib

usuario="user"
clave="pass"
server="domain"
destinatario="destiny_user"

#touch ~/.sendxmpprc
#chmod 600 ~/.sendxmpprc
#echo "$usuario@$server;$server $clave" > ~/.sendxmpprc

mensaje=$1

echo "$mensaje" | sendxmpp -v -e -u $usuario -p $clave -j $server $destinatario@$server
#echo "$mensaje" | sendxmpp -e -u $usuario -o $server $destinatario