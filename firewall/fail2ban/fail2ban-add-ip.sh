#!/bin/bash
. /root/scripts/./funciones.lib

#Constantes
ips=( 194.169.175.36 200.105.183.118 129.226.196.145 194.169.175.35 103.130.214.232 42.101.89.233 )

for ip in "${ips[@]}"
do
	echo "$ip "
	rta=$(fail2ban-client set sshd banip $ip)
	#reply 0 - ya bloqueada
	#reply 1 - agregada al baneo
	if [ $rta -eq 0 ]
		then
			echo "Ya estaba bloqueada - $ip"
		else
			echo "Nuevo IP bloqueada - $ip"
	fi
done
echo ""