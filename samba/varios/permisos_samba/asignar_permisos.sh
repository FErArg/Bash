#/bin/bash

net rpc rights grant 'Colegio\Administradores' \
SeMachineAccountPrivilege -S Servidor -U ntadministrador

#     SeMachineAccountPrivilege  Add machines to domain
#      SeTakeOwnershipPrivilege  Take ownership of files or other objects
#             SeBackupPrivilege  Back up files and directories
#            SeRestorePrivilege  Restore files and directories
#     SeRemoteShutdownPrivilege  Force shutdown from a remote system
#      SePrintOperatorPrivilege  Manage printers
#           SeAddUsersPrivilege  Add users and groups to the domain
#       SeDiskOperatorPrivilege  Manage disk shares


# Operadores de Sistema (S-1-5-32-549) -> ntopesistema
# Duplicadores (S-1-5-32-552) -> ntduplicadores
# Usuarios del Dominio (S-1-5-21-1622157102-1078586300-2170079295-513) -> ntusudom
# Invitados (S-1-5-32-546) -> ntinvitados
# Usuarios Avanzados (S-1-5-32-547) -> ntusravanzados
# Operadores de Impresion (S-1-5-32-550) -> ntopeimpresion
# Administradores (S-1-5-32-544) -> ntadmin
# Administradores de Dominio (S-1-5-21-1622157102-1078586300-2170079295-512) -> ntadmindom
# Operadores de Cuenta (S-1-5-32-548) -> ntopecuentas
# Invitados de Dominio (S-1-5-21-1622157102-1078586300-2170079295-514) -> ntinvdom
# Operadores de Copia (S-1-5-32-551) -> ntopecopias
# Usuarios (S-1-5-32-545) -> ntusuarios
