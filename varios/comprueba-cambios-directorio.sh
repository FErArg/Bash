#!/bin/bash
#dir="/home/ferarg/0"
#inotifywait -m $dir -e create |
    #while read path action file; do
        #echo "The file '$file' appeared in directory '$path' via '$action'"
        ## do something with the file
    #done

while :
do
    inot="$(inotifywait $dir -e create)"
    if [[ -z $inot ]]
    then
        echo $inot
    fi
done