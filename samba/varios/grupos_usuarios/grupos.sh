#!/bin/bash
TOT=`wc -l < grupos.txt`
I=1
while [ $I -le $TOT ]
do
linea=`sed -n ${I}l grupos.txt`
usu=`echo $linea | cut -d";" -f1`

#if grep  "^${usu}:" /etc/passwd
#   then
      echo El Usuario: " $usu " se agregara al grupo " $dep1 "
#   else 
        usu=`echo $linea | cut -d";" -f1`
        dep1=`echo $linea | cut -d";" -f4`

echo	"2"
    gpasswd -a $usu $dep1

echo	$usu agregado a grupo de trabajo $dep1

# fi
I=`expr $I + 1`
done