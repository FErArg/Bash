#!/bin/sh
ETHTOOL="$(which ethtool)"
DEV="enp0s31f6"
SPEED1="speed 1000 duplex full"
SPEED2="speed 1000 duplex full autoneg on"
SPEED3="autoneg on"

echo "Antes"
ethtool $DEV | grep Speed
echo ""
$ETHTOOL -s $DEV $SPEED3;
sleep 3
echo ""
echo "Despues"
ethtool $DEV | grep Speed
echo ""
