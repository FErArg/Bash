#!/bin/bash

red="10.10.0"
log="/media/backup/$fecha/red/log-ip-online.txt"

rm $log

TOT=255
I=1
while [ $I -le $TOT ]
do
    ping -c 1 -w 1 $red.$I 2>&1 > /dev/null && echo "$red.$I" && echo "$red.$I" >> $log

I=`expr $I + 1`

done

msn=`cat $log`

twitter