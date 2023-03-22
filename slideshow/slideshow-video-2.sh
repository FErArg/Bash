#!/bin/sh
# apt-get install omxplayer
# get rid of the cursor so we don't see it when videos are running
setterm -cursor off

# Variables
VIDEOPATH="/media/datos/Videos"

# configurar mejor resolución segun pantalla
# se calculan desde arriba izquierda de la pantalla
# primer  0 estira imagen hacia izquierda
# segundo 0 estira imagen hacia arriba
# tercer  1600 estira imagen hacia derecha
# cuarto  900 estira imagen hacia abajo

#resulociones pantallas
tamanoVideo="0 0 1920 1080" # 800x600 1280x720 1360x768 1440x900 1536x864 1600x900 1920x1080 2560x1440

# you can normally leave this alone
SERVICE="omxplayer"

# now for our infinite loop!
while true; do
  for entry in $VIDEOPATH/*
  do
    clear
    omxplayer --win "$tamanoVideo" $entry > /dev/null
    # omxplayer -o local -r "$tamanoVideo" $entry > /dev/null
    # omxplayer -o hdmi -r "$tamanoVideo" $entry > /dev/null
    # omxplayer -o hdmi -r "$tamanoVideo" --align center $entry > /dev/null
    #echo $entry
  done
done
