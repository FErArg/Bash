#!/bin/bash
. ./funciones.lib
#     Copyright (c) 2008, 2009, 2010 FErArg
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


function control1 () {
    clear
    echo "---------------------------------------------------------------------------------"
    echo "Datos de Control                                               SerInformaticos.es"
    echo "----------------"
    echo "Origen: ${usuario[*]}"
    echo "---------------------------------------------------------------------------------"
    echo "Destino: ${usuarioD[*]}"
    echo "---------------------------------------------------------------------------------"
    echo "Asignaturas ${asignatura[*]}"
    echo "Nro asignaturas ${#asignatura[@]}"
    echo "---------------------------------------------------------------------------------"
    echo " "
        }

function archivousuario () {
    constantes
    destino="/root"
    fecha="$(date +%F.%H.%M)"
    echo "${usuario[1]};${usuario[3]};${usuario[5]};${usuario[6]};${usuario[7]};" >> $destino/$fecha-${usuario[1]}-modificado.txt
    echo "---------------------------------------------------------------------------------------------------------" >> $destino/$fecha-${usuario[1]}-asignaturas-modificado-final.txt
    echo "${usuario[1]};${usuario[3]};${usuario[5]};${usuario[6]};${usuario[7]};" >> $destino/$fecha-${usuario[1]}-asignaturas-modificado-final.txt
    echo "Asignaturas ${asignatura[*]}" >> $destino/$fecha-${usuario[1]}-asignaturas-modificado-final.txt
    echo "---------------------------------------------------------------------------------------------------------" >> $destino/$fecha-${usuario[1]}-asignaturas-modificado-final.txt
            }


function archivousuarioelimina () {
    destino="/root"
    fecha="$(date +%F.%H.%M)"
    echo "${usuario[1]};${usuario[2]};${usuario[3]};${usuario[4]};${usuario[5]};${usuario[6]};${usuario[7]};" >> $destino/$fecha-${usuario[1]}-modificados.txt
            }


function ejecutar () {
    constantes
    creausuario
    creaescritorio
    creaenlaces
    creadirasignaturas
    cambiopermisos
        }

# Programa ============================================================================
licencia
control1

echo "Modifica Usuario Profesor"
usuario[1]="profesor" # Tipo de Usuario
unset leer
echo ""

sleep 1

read -p "Ingrese Usuario: " leer
usuario[3]=$leer
unset leer

echo "Ahora Ingrese los Datos a Eliminar"

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
    unset leer
    echo "Años:"
    echo "[1] Uno"
    echo "[2] Dos"
    echo "[3] Tres"
    echo "[4] Cuatro"
    echo "[0] Salir"
    read -p "Ingrese una opción: " leer
    case $leer in
        1)
        unset leer
        usuario[6]="1"
        usuario[7]=${usuario[6]}
        ;;
        2)
        unset leer
        usuario[6]="2"
        usuario[7]=${usuario[6]}
        ;;
        3)
        unset leer
        usuario[6]="3"
        usuario[7]=${usuario[6]}
        ;;
        4)
        unset leer
        usuario[6]="4"
        usuario[7]=${usuario[6]}
        ;;
        0);;
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
    0);;
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
echo "[3] A-B"
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
    3)
    unset leer
    usuario[7]="ab"
    ;;
    0);; 
esac
else 
    echo "Usuario Infantil"
fi

control1

if [ "${usuario[7]}" == "a" ] 
then 
    echo "Eligio a"
    constantes
    eliminausuario
elif [ "${usuario[7]}" == "b" ] 
then 
    echo "Eligio B"
    constantes
    eliminausuario
elif [ "${usuario[7]}" == "ab" ] 
then
    echo "Eligio AB"
    constantesab
    eliminausuarioab
else
    echo "Eligio Infantil"
    constantes
    eliminausuario
fi

archivousuarioelimina

# Creacion y Modificaciones -------------------------------------------------------------------------------------------------------
control1
echo ""
echo "Ingrese las Nuevas Opciones"
echo ""

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
    unset leer
    echo "Años:"
    echo "[1] Uno"
    echo "[2] Dos"
    echo "[3] Tres"
    echo "[4] Cuatro"
    echo "[0] Salir"
    read -p "Ingrese una opción: " leer
    case $leer in
        1)
        unset leer
        usuario[6]="1"
        usuario[7]=${usuario[6]}
        ;;
        2)
        unset leer
        usuario[6]="2"
        usuario[7]=${usuario[6]}
        ;;
        3)
        unset leer
        usuario[6]="3"
        usuario[7]=${usuario[6]}
        ;;
        4)
        unset leer
        usuario[6]="4"
        usuario[7]=${usuario[6]}
        ;;
        0);;
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
    0);;
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
echo "[3] A-B"
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
    3)
    unset leer
    usuario[7]="ab"
    ;;
    0);; 
esac
else 
    echo "Usuario Infantil"
fi

control1

# Seleccion de Asignaturas
if [ "${usuario[5]}" != "inf" ] 
then 
I=1
while [ "$leer" != X ]
do
control1
asignaturas
echo "Seleccion ${I[*]}"
I=$[ $I + 1 ]
done
else 
    echo "Usuario Infantil"
fi

nroasig="${#asignatura[@]}"

control1
eleccioncorrecta

if [ "${usuario[7]}" == "a" ] 
then 
    echo "Eligio A"
    ejecutar
elif [ "${usuario[7]}" == "b" ] 
then 
    echo "Eligio B"
    ejecutar
elif [ "${usuario[7]}" == "ab" ] 
then
    echo "Eligio A-B"
    constantesab
    creausuario
    creaescritorio
    creaenlacesab
    creadirasignaturasab
    cambiopermisosD
else
    echo "Eligio Infantil"
    ejecutar
fi

archivousuario

#Actualizacion NIS
# /usr/lib/yp/ypinit -m 