#!/bin/bash

for directorio in /*; do
    if [[ -d $directorio ]]; then
        # $f is a directory
        echo $directorio
    fi
done
