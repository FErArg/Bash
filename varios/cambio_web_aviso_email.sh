#!/bin/bash
. /root/scripts/./funciones.lib
# monitor.sh - Monitors a web page for changes
# sends an email notification if the file change

URL1="https://www.milanuncios.com/anuncios-en-valencia/caravana.htm?fromSearch=1&desde=2000&hasta=4500&demanda=n"
URL2="https://www.milanuncios.com/anuncios-en-castellon/caravana.htm?fromSearch=1&desde=2000&hasta=4500&demanda=n"
URL3="https://www.milanuncios.com/anuncios-en-alicante/caravana.htm?fromSearch=1&desde=2000&hasta=4500&demanda=n"

touch /tmp/url1.txt
echo $URL1 > /tmp/url1.txt
sleep 1
touch /tmp/url2.txt
echo $URL2 > /tmp/url2.txt
sleep 1
touch /tmp/url3.txt
echo $URL3 > /tmp/url3.txt
sleep 1

for (( ; ; )); do
    mv /tmp/new1.html /tmp/old1.html 2> /dev/null
    curl $URL1 -L --compressed -s > /tmp/new1.html
    DIFF_OUTPUT1="$(diff /tmp/new1.html /tmp/old1.html)"
    if [ "0" != "${#DIFF_OUTPUT1}" ]; then
       echo "cambio web 1"
       mutt -s "Novedades Caravana VLC $fecha" $email2 < /tmp/url1.txt
       sleep 600
    fi
    mv /tmp/new2.html /tmp/old2.html 2> /dev/null
    curl $URL2 -L --compressed -s > /tmp/new2.html
    DIFF_OUTPUT2="$(diff /tmp/new2.html /tmp/old2.html)"
    if [ "0" != "${#DIFF_OUTPUT2}" ]; then
       echo "cambio web2"
       mutt -s "Novedades Caravana CAS $fecha" $email2 < /tmp/url2.txt
       sleep 600
    fi
    mv /tmp/new3.html /tmp/old3.html 2> /dev/null
    curl $URL3 -L --compressed -s > /tmp/new3.html
    DIFF_OUTPUT3="$(diff /tmp/new3.html /tmp/old3.html)"
    if [ "0" != "${#DIFF_OUTPUT3}" ]; then
       echo "cambio web 3"
       mutt -s "Novedades Caravana ALI $fecha" $email2 < /tmp/url3.txt
       sleep 600
    fi
done