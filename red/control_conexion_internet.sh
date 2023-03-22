#!/bin/bash
destino="8.8.8.8"

chek=$(ping $destino -c 1 | awk '/data/ {print $7}')

if [ "$chek" = "data." ];
then
    echo "Con Conexion"
    exit 0
else
    echo "Sin Conexion"
fi

twitter