#!/bin/bash

#     Copyright (c) 2008, 2009, FErArg
#
#     Este programa es software libre: usted puede redistribuirlo y / o modificarlo
#     bajo los términos de la GNU General Public License publicada por la
#     la Free Software Foundation, bien de la versión 3 de la Licencia, o de
#     la GPL2, o cualquier versión posterior.
#
#     Este programa se distribuye con la esperanza de que sea útil,
#     pero SIN NINGUNA GARANTÍA, incluso sin la garantía implícita de
#     COMERCIABILIDAD o IDONEIDAD PARA UN PROPÓSITO PARTICULAR. Véase el
#     GNU General Public License para más detalles.
#
#     Usted debería haber recibido una copia de la Licencia Pública General de GNU
#     junto con este programa. Si no, visite <http://www.gnu.org/licenses/>.
#
#     Puede descargar la version completa de la GPL3 desde < https://ferarg.com >
#

# Arrays ===============================================================================
# usuario[1] profesor/alumno
# usuario[2] nombre completo
# usuario[3] usuario
# usuario[4] clave
# usuario[5] grupo (eso/pri/inf)
# usuario[6] año 1/2/3/4/5/6
# usuario[7] division a/b/ab

# Funciones ============================================================================
. ./funciones.lib

function control1 () {
    clear
    echo "---------------------------------------------------------------------------------"
    echo "Datos de Control                                               SerInformaticos.es"
    echo "----------------"
    echo "${usuario[*]}"
    echo "---------------------------------------------------------------------------------"
    echo " "
        }

function archivousuario () {
    destino="/home/ferarg"
    fecha="$(date +%F.%H.%M)"
    echo "${usuario[1]};${usuario[2]};${usuario[3]};${usuario[4]};${usuario[5]};${usuario[6]};${usuario[7]};" >> $destino/$fecha-${usuario[1]}-creados.txt
            }


function importardatos () {
    origen="/home/nis/${usuario[1]}/${usuario[5]}/${usuario[6]}/${usuario[7]}/${usuario[3]}/Escritorio/Enlaces/${usuario[5]}/${usuario[6]}/${usuario[7]}/trabajos_alumnos"
    destino="/home/smb/${usuario[1]}/${usuario[5]}/${usuario[6]}/${usuario[7]}/${usuario[3]}/enlaces/${usuario[5]}/${usuario[6]}/${usuario[7]}/trabajos_alumnos"
    cp -R $origen/* $destino/
            }


function ejecutar () {
    constantes
    creausuario
    creaenlaces
    importardatos
    cambiopermisos
        }

# Programa ============================================================================
licencia
echo " Como base de datos se necesitan solo los nombres de los usuarios "
echo " en una sola columna y al final del nombre un punto y coma (;)    "
echo ""
echo " Ejemplo:"
echo ""
echo "       Nombre Alumno;Usuario;Clave;"
echo ""
echo "Nombre del Archivo de Base de Datos"
echo ""
echo "       alumno-crea-db.txt"
echo ""
echo ""
echo ""
echo " Ingrese los Datos de Origen de los Usuarios Alumnos a Modificar"
sleep 3

control1

echo "Tipo Usuario Alumno"
usuario[1]="alumno" # Tipo de Usuario
unset leer

control1

# Tipo de Grupo
echo "[1] Infantil"
echo "[2] Primaria"
echo "[3] E.S.O."
echo "[0] Salir"
read -p "Ingrese una opción: " leer
case $leer in
    1)
    unset leer
    usuario[5]="inf"
    control1
    # Año
    echo "Años:"
    echo "[3] Tres"
    echo "[4] Cuatro"
    echo "[4] Cinco"
    echo "[0] Salir"
    read -p "Ingrese una opción: " leer
    case $leer in
        3)
        unset leer
        usuario[6]="3"
        usuario[7]="3"
        ;;
        4)
        unset leer
        usuario[6]="4"
        usuario[7]="4"
        ;;
        5)
        unset leer
        usuario[6]="5"
        usuario[7]="5"
        ;;
    esac # Fin Año
    ;;
    2)
    unset leer
    usuario[5]="pri"
    ;;
    3)
    unset leer
    usuario[5]="eso"
    ;;
    0);;
esac # Fin Grupo

control1

# Año
if [ "${usuario[5]}" != "inf" ]
then
unset leer
echo "Año:"
echo "[1] Primero"
echo "[2] Segundo"
echo "[3] Tercero"
echo "[4] Cuarto"
echo "[5] Quinto"
echo "[6] Sexto"
echo "[0] USUARIO INFANTIL o SALIR"
read -p "Ingrese una opción: " leer
case $leer in
    1)
    unset leer
    usuario[6]="1"
    ;;
    2)
    unset leer
    usuario[6]="2"
    ;;
    3)
    unset leer
    usuario[6]="3"
    ;;
    4)
    unset leer
    usuario[6]="4"
    ;;
    5)
    unset leer
    usuario[6]="5"
    ;;
    6)
    unset leer
    usuario[6]="6"
    ;;
    esac
else
    echo "Usuario Infantil"
fi # Fin Año

control1

# Tipo de Division
if [ "${usuario[5]}" != "inf" ]
then
echo "[1] A"
echo "[2] B"
echo "[0] USUARIO INFANTIL o SALIR"
read -p "Ingrese una opción: " leer
case $leer in
    1)
    unset leer
    usuario[7]="a"
    ;;
    2)
    unset leer
    usuario[7]="b"
    ;;
    0);;
esac
else
    echo "Usuario Infantil"
fi

control1
eleccioncorrecta

if [ "${usuario[7]}" == "a" ]
then
    echo "Eligio A"
    TOT=`wc -l < alumno-crea-db.txt`
    I=1
    while [ $I -le $TOT ]
    do
    linea=`sed -n ${I}l alumno-crea-db.txt`
        nombre=`echo $linea | cut -d";" -f1`
        	usuario=`echo $linea | cut -d";" -f2`
        #
        usuario[2]=$nombre
        usuario[3]=$usuario
        usuario[4]=${usuario[3]}
        #
        ejecutar
        #
        echo " Creado Usuario:  Nombre: ${usuario[2]} - Usuario: ${usuario[3]} - Clave: ${usuario[4]} "
    I=`expr $I + 1`
    done
elif [ "${usuario[7]}" == "b" ]
then
    echo "Eligio B"
    TOT=`wc -l < alumno-crea-db.txt`
    I=1
    while [ $I -le $TOT ]
    do
    linea=`sed -n ${I}l alumno-crea-db.txt`
        nombre=`echo $linea | cut -d";" -f1`
        usuario=`echo $linea | cut -d";" -f2`
        #
        usuario[2]=$nombre
        usuario[3]=$usuario
        usuario[4]=${usuario[3]}
        #
        ejecutar
        #
        echo " Creado Usuario:  Nombre: ${usuario[2]} - Usuario: ${usuario[3]} - Clave: ${usuario[4]} "
    I=`expr $I + 1`
    done
else
    echo "Eligio Infantil"
    TOT=`wc -l < alumno-crea-db.txt`
    I=1
    while [ $I -le $TOT ]
    do
    linea=`sed -n ${I}l alumno-crea-db.txt`
        nombre=`echo $linea | cut -d";" -f1`
        	usuario=`echo $linea | cut -d";" -f2`
        #
        usuario[2]=$nombre
        usuario[3]=$usuario
        usuario[4]=${usuario[3]}
        #
        ejecutar
        #
        echo " Creado Usuario:  Nombre: ${usuario[2]} - Usuario: ${usuario[3]} - Clave: ${usuario[4]} "
    I=`expr $I + 1`
    done
fi

archivousuario