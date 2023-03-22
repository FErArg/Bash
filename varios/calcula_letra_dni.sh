#!/bin/bash
#programa calcular letra dni
clear
read -p "Intruduzca el NIF:" nif
let dni=$nif%23
n=0
for i in T R W A G M Y F P D X B N J Z S Q V H L C K E T
do
    if [ $n -eq $dni ]
    then
        echo "LA LETRA ES $i"
    break
    else
        n=`expr $n + 1`
    fi
done