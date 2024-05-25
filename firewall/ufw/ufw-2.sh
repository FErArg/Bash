#/bin/bash
. /root/scripts/./funciones.lib

#constantes
DB="reglas.db"

#Elimina reglas
TOT=`wc -l < $DB`
	I=1
	while [ $I -le $TOT ]
	do
	linea=`sed -n ${I}l $DB`
		reglas=`echo $linea | cut -d";" -f1`

			ufw delete $reglas
		
		echo "Regla $reglas"
	I=`expr $I + 1`
	done

unset TOT
unset I
unset reglas

#agrega reglas
TOT=`wc -l < $DB`
        I=1
        while [ $I -le $TOT ]
        do
        linea=`sed -n ${I}l $DB`
                reglas=`echo $linea | cut -d";" -f1`

                        ufw $reglas

                echo "Regla $reglas"
        I=`expr $I + 1`
        done


ufw disable 
ufw enable
ufw logging on
ufw status