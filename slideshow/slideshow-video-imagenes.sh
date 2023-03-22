#!/bin/sh
# apt-get install omxplayer ffmpeg

# deb http://www.deb-multimedia.org stretch main non-free
# apt update
# apt install deb-multimedia-keyring
# apt update && apt dist-upgrade
# apt install gstreamer1.0-libav gstreamer1.0-plugins-bad gstreamer1.0-vaapi

# get rid of the cursor so we don't see it when videos are running
setterm -cursor off

# set here the path to the directory containing your videos
VIDEOPATH="/media/datos/Videos"
IMGPATH="/media/datos/Imagenes"
MINUTO="$(date +%M)"
videoJpg="$VIDEOPATH/imagenes-jpg.mp4"
videoPng="$VIDEOPATH/imagenes-png.mp4"

# you can normally leave this alone
SERVICE="omxplayer"

# now for our infinite loop!
while true;
do
  if [ $MINUTO -eq "13" ]
  then
    # elimina videos creados antiguos
    rm -Rf $videoJpg
    rm -Rf $videoPng

    # convierte imagenes en video ---------------------------------------------------
    cd $IMGPATH

    # limpia nombres de archivos y los pasa a minusculas
    find -name "* *" -type f | rename 's/ /_/g'
    find -name "*%20*" -type f | rename 's/%20/_/g'
    find -name "*%*" -type f | rename 's/%/_/g'
    ls | while read -r FILE
    do
        mv -v "$FILE" `echo $FILE | tr ' ' '_' | tr -d '[{}#@$%&(),\!]' | tr -d "\'" | tr '[A-Z]' '[a-z]' | sed 's/_-_/_/g'`
    echo $FILE
    done
    # ====================================================================
    # renombra los JPG a numeros consecutivos
    a=1
    for i in *.jpg; do
      new=$(printf "%04d.jpg" "$a") #04 pad to length of 4
      mv -i -- "$i" "$new"
      let a=a+1
    done

    # renombra los PNG a numeros consecutivos
    a=1
    for i in *.png; do
      new=$(printf "%04d.png" "$a") #04 pad to length of 4
      mv -i -- "$i" "$new"
      let a=a+1
    done

    # ====================================================================
    # convierte JPG a video
    ffmpeg -framerate 1 -pattern_type glob -i '*.jpg' -c:v libx264 -r 300 -pix_fmt yuv420p $videoJpg
    sleep 1
    # convierte PNG a video
    ffmpeg -framerate 1 -pattern_type glob -i '*.png' -c:v libx264 -r 300 -pix_fmt yuv420p $videoPng
    # --------------------------------------------------------------------
  fi
  for video in $VIDEOPATH/*
  do
          clear
          omxplayer $video > /dev/null
          #echo $video
  done
done
