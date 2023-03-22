#!/bin/sh

# get rid of the cursor so we don't see it when videos are running
setterm -cursor off

# set here the path to the directory containing your videos
VIDEOPATH="/home/pi/Videos" 
IMGPATH="/home/pi/Imagenes"

# you can normally leave this alone
SERVICE="omxplayer"

# now for our infinite loop!
while true; do
#        if ps ax | grep -v grep | grep $SERVICE > /dev/null
#                then
#                sleep 1;
                # image2video
#               mencoder mf:///home/pi/Imagenes/*.jpg -mf w=800:h=600:fps=0.6:type=jpg -ovc copy -oac copy -o /home/pi/Videos/output5.avi

                #mencoder mf://$IMGPATH/*.jpg -mf w=800:h=600:fps=0.6:type=jpg -ovc copy -oac copy -o $VIDEOPATH/output4.mp4
                # rm -Rf $IMGPATH/*
#        else
                for entry in $VIDEOPATH/*
                do
                        #mencoder mf:///home/pi/Imagenes/*.jpg -mf w=800:h=600:fps=0.6:type=jpg -ovc copy -oac copy -o /home/pi/Videos/01-output5.avi
                        clear
                        #omxplayer $entry > /dev/null
                        echo $entry
                done
        fi
done