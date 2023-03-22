#!/bin/bash

destino="8.8.4.4"

check=$(ping $destino -c 1 | awk '/data/ {print $7}')

if [ "$check" = "permitted" ]; 
then
    echo "Con Conexion"
    exit 0
else
    echo "Sin Conexion"
fi