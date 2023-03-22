#!/bin/bash

# hace ping a server openvpn
# si no ping - restart opencpn client
#espera 10 segundos y reintenta

vpnS="172.26.1.1"

if ping -c 1 -W 1 $vpnS>/dev/null
then
        echo "$ip - Encendido"
else
        echo "$ip - Apagado"
        sudo service openvpn restart
fi