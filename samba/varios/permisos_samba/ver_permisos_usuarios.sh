#/bin/bash

net rpc rights list accounts 'Colegio\Administradores de Dominio' -U% -S Servidor1

#     SeMachineAccountPrivilege  Add machines to domain
#      SeTakeOwnershipPrivilege  Take ownership of files or other objects
#             SeBackupPrivilege  Back up files and directories
#            SeRestorePrivilege  Restore files and directories
#     SeRemoteShutdownPrivilege  Force shutdown from a remote system
#      SePrintOperatorPrivilege  Manage printers
#           SeAddUsersPrivilege  Add users and groups to the domain
#       SeDiskOperatorPrivilege  Manage disk shares
