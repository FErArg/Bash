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

function constantes () {
    homeusu=/home/smb/${usuario[1]}/${usuario[3]}
    enlaces=/home/smb/enlaces/${usuario[5]}/${usuario[6]}/${usuario[7]}
            }

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
    destino="/root"
    fecha="$(date +%F.%H.%M)"
    echo "${usuario[1]};${usuario[2]};${usuario[3]};${usuario[4]};${usuario[5]};${usuario[6]};${usuario[7]};" >> $destino/$fecha-${usuario[1]}-eliminado.txt
            }


function eliminausuario () {
    constantes
    userdel ${usuario[3]}
    rm -Rf $homeusu
    rm -Rf $enlaces/trabajos_profesor/${usuario[3]}
    gpasswd -d ${usuario[3]} ${usuario[1]}
    gpasswd -d ${usuario[3]} ${usuario[5]}
    gpasswd -d ${usuario[3]} ${usuario[6]}
    gpasswd -d ${usuario[3]} ${usuario[7]}
                }


function eleccioncorrecta () {
    # Seguir o Salir
    echo " Controle la Información que aparece en la cabecera de la pantalla "
    echo ""
    echo " Es Esta Información Correcta?"
    echo ""
    echo "[1] Es Correcta, Continuar"
    echo "[0] No es Correcta, Salir"
    read -p "Ingrese una opción: " leer
    case $leer in
            1)
        	echo "Información Correcta"
            unset leer
        	;;
           	0)
            exit 0
        	;;
    esac
            }


function licencia () {
clear
echo ""
echo "     Copyright (c) 2008, 2009, 2010, Fernando A. Rodriguez"
echo ""
echo "     Este programa es software libre: usted puede redistribuirlo y / o modificarlo"
echo "     bajo los términos de la GNU General Public License publicada por la"
echo "     la Free Software Foundation, bien de la versión 3 de la Licencia, o de"
echo "     la GPL2, o cualquier versión posterior."
echo ""
echo "     Este programa se distribuye con la esperanza de que sea útil,"
echo "     pero SIN NINGUNA GARANTÍA, incluso sin la garantía implícita de"
echo "     COMERCIABILIDAD o IDONEIDAD PARA UN PROPÓSITO PARTICULAR. Véase el"
echo "     GNU General Public License para más detalles."
echo ""
echo "     Usted debería haber recibido una copia de la Licencia Pública General de GNU"
echo "     junto con este programa. Si no, visite <http://www.gnu.org/licenses/>."
echo ""
echo "     Puede descargar la version completa de la GPL3 desde < http://serinformaticos.es/node/46 >"
sleep 3
            }


function eliminausuarioab () {
    homeusu=/home/smb/${usuario[1]}/${usuario[3]}
    enlaces=/home/smb/enlaces/${usuario[5]}/${usuario[6]}/
    userdel ${usuario[3]}
    rm -Rf $homeusu
    rm -Rf mkdir -p $enlaces/a/trabajos_profesor/${usuario[3]}
    rm -Rf mkdir -p $enlaces/b/trabajos_profesor/${usuario[3]}
                }
# Programa ----------------------------------------------------------------------------------------------
licencia
control1

echo "Elimina Profesor"
usuario[1]="profesor"

read -p "Ingrese Usuario: " leer
usuario[3]=$leer
unset leer

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
    0);; esac # Fin Grupo

control1

# Año
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
esac # Fin Año

control1

# Tipo de Division
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

control1
eleccioncorrecta

if [ "${usuario[7]}" == "a" ] 
then 
    echo "Eligio A"
    eliminausuario
elif [ "${usuario[7]}" == "b" ] 
then 
    echo "Eligio B"
    eliminausuario
elif [ "${usuario[7]}" == "ab" ] 
then
    echo "Eligio A-B"
    eliminausuarioab
else
    echo "Eligio Infantil"
    eliminausuario
fi


control1
archivousuario