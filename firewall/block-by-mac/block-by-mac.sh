#!/bin/bash

DB="block-by-mac.db"

iptables="$(which iptables)"

TOT=`wc -l < $DB`
I=1
while [ $I -le $TOT ]
do
  linea=`sed -n ${I}l $DB`
  mac=`echo $linea | cut -d";" -f1`
  echo "$iptables -A INPUT -m mac --mac-source $mac -j DROP"
  I=`expr $I + 1`
done