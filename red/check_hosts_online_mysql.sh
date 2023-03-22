#!/bin/bash

DB="/home/ferarg/scripts/scripts-servidores/red/check_host_online.db"
MySQLU="user"
MySQLP="pass"
MySQLD="database"
MySQLS="localhost"
MySQLT="hosts"

fecha2="$fecha $hora"
echo $fecha2
echo ""
echo ""

TOT=`wc -l < $DB`
I=1
while [ $I -le $TOT ]
do
 linea=`sed -n ${I}l $DB`
# mac=`echo $linea | cut -d";" -f1`
 ip=`echo $linea | cut -d";" -f1`
 host=`echo $linea | cut -d";" -f2`

 if ping -c 1 -W 1 $ip>/dev/null
 then
  echo "$ip - $host - Encendido"
  mysql --host=$MySQLS --user=$MySQLU --password=$MySQLP -D $MySQLD -Bse "INSERT INTO $MySQLT (hostname,ip,fecha) VALUES ('$host','$ip','$fecha2');"
 else
  echo "$ip - $host - Apagado"
 fi

I=`expr $I + 1`
done
