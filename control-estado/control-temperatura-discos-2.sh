#!/bin/bash

HDDS="/dev/sda /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf"
HDT=/usr/sbin/hddtemp
LOG=/usr/bin/logger
DOWN=/sbin/shutdown

ALERT_LEVEL=55

args="--numeric"
for disk in $HDDS
do
        if [ -b $disk ]; then
                HDTEMP=$($HDT $disk $args)
                $LOG "HDTEMP for $disk is $HDTEMP"
                if [ $HDTEMP -ge $ALERT_LEVEL ]; then
                        msn="Sistema procede a apagarse, temperatura de $disk es de $HDTEMP°C y ha cruzado el límite"
                        echo $msn
                        $LOG $msn
                        twitter > /dev/null 2>&1
                        $DOWN -h 0
                else
                        msn="Temperatura de $disk es de $HDTEMP°C"
                        echo $msn
                        twitter > /dev/null 2>&1
                fi
        fi
done