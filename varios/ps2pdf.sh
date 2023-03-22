#!/bin/bash
dirPS="/home/ferarg/PDF/PS"
dirPDF="/home/ferarg/PDF"
fecha="$(date +%Y-%m-%d-%H%M%S)";
FILE=""

if [ "$(ls -A $dirPS)" ];
then
    echo "Take action $dirPS is not Empty"
    for file in $dirPS/*
    do
        echo $file
        filename=$(basename "$file")
        extension="${filename##*.}"
        filename="${filename%.*}"
        echo "$filename - $extension"

    #    ps2pdf -dCompatibilityLevel=1.2 $file $dirPS/$filename.2.pdf
    #    ps2pdf -dCompatibilityLevel=1.3 $file $dirPS/$filename.3.pdf
    #    ps2pdf -dCompatibilityLevel=1.4 $file $dirPS/$filename.4.pdf
        ps2pdf -dCompatibilityLevel=1.3 $file $dirPDF/$fecha-$filename.pdf

    #    ps2pdf -dCompatibilityLevel=1.3 $file $file.pdf
        rm $file
    done

else
    echo "$dirPS is Empty"
fi