#!/bin/bash

#Constantes
msn="ddclient v2"

IP=`wget -q -O - http://homer.meso.com/remoteip.php`
/usr/sbin/ddclient -p $IP

twitter