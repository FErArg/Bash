#!/bin/sh
# apt-get install ffmpeg imagemagick

# Variables  ===========================================================
VIDEOPATH="/media/datos/Videos"
IMGPATH="/media/datos/Imagenes"
TMP="/media/datos/tmp"
FECHA="$(date +%Y-%M-%d-%H-%M)"
videoJpgTmp="$TMP/$FECHA.mp4" #nombre de archivo de video
tiempo="0.2" # numero mas pequeño mas tiempo en pantalla
tamanoImagenes="1600x900" # 800x600 1280x720 1360x768 1440x900 1536x864 1600x900 1920x1080 2560x1440

# Comprueba si existen imagenes ========================================

FILE=""
DIR="/media/datos/Imagenes"
# init
# look for empty dir
if [ "$(ls -A $IMGPATH)" ]; then
  # elimina videos creados antiguos  =====================================
  rm -Rf $videoJpgTmp

  # convierte imagenes en video ==========================================
  cd $IMGPATH

  # limpia nombres de archivos y los pasa a minusculas  ==================
  find -name "* *" -type f | rename 's/ /_/g'
  find -name "*%20*" -type f | rename 's/%20/_/g'
  find -name "*%*" -type f | rename 's/%/_/g'
  ls | while read -r FILE
  do
    mv -v "$FILE" `echo $FILE | tr ' ' '_' | tr -d '[{}#@$%&(),\!]' | tr -d "\'" | tr '[A-Z]' '[a-z]' | sed 's/_-_/_/g'`
    echo $FILE
  done

  #convierta PNG a JPG ===================================================
  for i in *.png; do
    if [ "$i" != "*.png" ]; then
      imagen="${i%%.*}"
      convert $i -quality 95 $imagen.jpg
      sleep 1
      rm $i
    fi
  done
  sleep 2

  # renombra los JPG a numeros consecutivos  =============================
  #a=1
  for i in *.jpg; do
    # new=$(printf "%04d.jpg" "$a")
    # mv -i -- "$i" "$new"
    # let a=a+1
    NEW_UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    imagen="${i%%.*}"
    mv $i $NEW_UUID.jpg
    convert $NEW_UUID.jpg -resize $tamanoImagenes $NEW_UUID.jpg
    sleep 1
  done

  # convierte JPG a video  ===============================================
  ffmpeg -framerate $tiempo -pattern_type glob -i '*.jpg' -c:v libx264 -r 25 -pix_fmt yuv420p $videoJpgTmp

  # sobreescribe video ===================================================
  mv $videoJpgTmp $VIDEOPATH

  # limpia nombres de videos y los pasa a minusculas  ==================
  cd $VIDEOPATH
  find -name "* *" -type f | rename 's/ /_/g'
  find -name "*%20*" -type f | rename 's/%20/_/g'
  find -name "*%*" -type f | rename 's/%/_/g'
  ls | while read -r FILE
  do
    mv -v "$FILE" `echo $FILE | tr ' ' '_' | tr -d '[{}#@$%&(),\!]' | tr -d "\'" | tr '[A-Z]' '[a-z]' | sed 's/_-_/_/g'`
    echo $FILE
  done

  # Elimina todas las imagenes con las que se crearon el video
  sleep 5
  rm -Rf $IMGPATH/*

  # cambio permisos ======================================================
  chown raspberry:raspberry -R $VIDEOPATH
  chown raspberry:raspberry -R $IMGPATH

  # mata procesosomxplayer  ==============================================
  killall -9 omxplayer
  sleep 1
  killall -9 omxplayer.bin
  sleep 1
  killall -9 omxplayer
  sleep 1

else
    echo "No hay nuevas imágenes en $IMGPATH"
fi



