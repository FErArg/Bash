#!/bin/sh
SIDSAMBA=2292169728-589480854-1072845425

groupadd ntadmin
groupadd ntadmindom
groupadd ntduplicadores
groupadd ntinvdom
groupadd ntinvitados
groupadd ntopecopias
groupadd ntopecuentas
groupadd ntopeimpresion
groupadd ntopesistema
groupadd ntusravanzados
groupadd ntusudom
groupadd ntusuarios

net groupmap add ntgroup="Administradores" \
sid="S-1-5-32-544" unixgroup=ntadmin \
comment="Los administradores tienen acceso completo y sin restricciones al equipo o dominio"

net groupmap add ntgroup="Administradores de Dominio" \
sid="S-1-5-21-$SIDSAMBA-512" unixgroup=ntadmindom \
comment="Administradores designados del dominio"

net groupmap add ntgroup="Duplicadores" \
sid="S-1-5-32-552" unixgroup=ntduplicadores \
comment="Pueden duplicar archivos en un dominio"

net groupmap add ntgroup="Invitados de Dominio" \
sid="S-1-5-21-$SIDSAMBA-514" unixgroup=ntinvdom \
comment="Todos los invitados del dominio"

net groupmap add ntgroup="Invitados" \
sid="S-1-5-32-546" unixgroup=ntinvitados \
comment="Los invitados tienen de mod opredeterminado el mismo \
acceso que los miembros del grupo Usuarios, excepto la cuenta \
Invitado que tiene mas restricciones"

net groupmap add ntgroup="Operadores de Copia" \
sid="S-1-5-32-551" unixgroup=ntopecopias \
comment="Los operadores de copia pueden sobrescribir restricciones \
de seguridad con el único propósito de hacer copias \
de seguridad o restaurar archivos"

net groupmap add ntgroup="Operadores de Cuenta" \
sid="S-1-5-32-548" unixgroup=ntopecuentas \
comment="Pueden administrar cuentas de usuarios y grupos del dominio"

net groupmap add ntgroup="Operadores de Impresion" \
sid="S-1-5-32-550" unixgroup=ntopeimpresion \
comment="Pueden operar impresoras del dominio"

net groupmap add ntgroup="Operadores de Sistema" \
sid="S-1-5-32-549" unixgroup=ntopesistema \
comment="Pueden administrar sistemas del dominio"

net groupmap add ntgroup="Usuarios Avanzados" \
sid="S-1-5-32-547" unixgroup=ntusravanzados \
comment="Los usuarios avanzados tienen mas derechos administrativos \
con algunas restricciones. De este modo, pueden ejecutar aplicaciones \
heredadas junto con aplicaciones certificadas"

net groupmap add ntgroup="Usuarios del Dominio" \
sid="S-1-5-21-$SIDSAMBA-513" unixgroup=ntusudom \
comment="Todos los usuarios del dominio"

net groupmap add ntgroup="Usuarios" \
sid="S-1-5-32-545" unixgroup=ntusuarios \
comment="Los usuarios no pueden hacer cambios accidentales o \
intencionados en el sistema. Pueden ejecutar aplic. certificadas, \
pero no la mayoría de las heredadas"

exit 0