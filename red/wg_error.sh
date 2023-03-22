#!/bin/bash

#Elimina rutas y configuraciones cuando al activar una conexión WG da el error RTLINK

sed -i '/^[[:blank:]]*sleep 1/d' /usr/bin/wg-quick # Revert adding the sleep, if already added.
sed -i '/^ListenPort[[:blank:]]/a\Table = off' /etc/wireguard/wg0.conf # Actively disable the routing table to force skipping "ip route add"
systemctl restart wg-quick@wg0