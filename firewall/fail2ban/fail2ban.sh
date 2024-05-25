#!/bin/bash
. /root/scripts/./funciones.lib

# Constantes
log="/tmp/fail2ban.txt"

fail2ban-client status sshd > $log

sleep 2

telegram "$(cat $log)"