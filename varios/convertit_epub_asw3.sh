#! /bin/bash

function convert () {
        filename="$1"
        extension="${filename##*.}"
        root="${filename%.*}"
        outputExtension=".azw3"
        convertedName="${root}_converted${outputExtension}"
        polishedName="${root}_converted_and_polished${outputExtension}"

        echo ""
        echo "++++++ Converting book: $filename ++++++"
        ./ebook-convert "$filename" "$convertedName" \
        --change-justification justify \
        --margin-left 0 \
        --margin-right 0 \
        --margin-top 0 \
        --margin-bottom 0 \
        --remove-paragraph-spacing \
        --remove-paragraph-spacing-indent-size 1.0 \
        --filter-css font-family
        sleep 0.1

        echo ""
        echo "++++++ Polishing book: $convertedName ++++++"
        ./ebook-polish --add-soft-hyphens --upgrade-book "$convertedName" "$polishedName"
        sleep 0.1

       echo ""
        echo "++++++ Removing obsolete file: $convertedName ++++++"
        rm "$convertedName"
        sleep 0.1

       echo ""
        echo "++++++ Done, final book is: $polishedName ++++++"
        echo ""
}

for name in "$@"
do
        echo "++++++ Staring conversion of: "$name" ++++++"
            convert "$name"
            sleep 0.1
done