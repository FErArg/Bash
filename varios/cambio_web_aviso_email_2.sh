#!/bin/bash
. /root/scripts/./funciones.lib
# monitor.sh - Monitors a web page for changes
# sends an email notification if the file change

URL1="https://www.milanuncios.com/anuncios-en-valencia/caravana.htm?fromSearch=1&desde=2000&hasta=4500&demanda=n"
URL2="https://www.milanuncios.com/anuncios-en-castellon/caravana.htm?fromSearch=1&desde=2000&hasta=4500&demanda=n"
URL3="https://www.milanuncios.com/anuncios-en-alicante/caravana.htm?fromSearch=1&desde=2000&hasta=4500&demanda=n"

URLS=( $URL1 $URL2 $URL3 )

TOTAL=${#URLS[*]}

for (( ; ; )); do
  for f in "${URLS[@]}"; do
      mv /tmp/new.html /tmp/old.html 2> /dev/null
      curl $f -L --compressed -s > /tmp/new1.html
      DIFF_OUTPUT1="$(diff /tmp/new.html /tmp/old.html)"
      if [ "0" != "${#DIFF_OUTPUT1}" ]; then
         echo "cambio web"
         mutt -s "Novedades Caravana $fecha" $email2 < /tmp/url.txt
         sleep 10
      fi
      rm /tmp/url.txt
      rm
  done
done