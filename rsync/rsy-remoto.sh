#!/bin/bash
# Usage: Mirror directories and files to our US, UK and Japan based server.
# --------------------------------------------------------------------------

_upstream="/home/ferarg/scripts/backup"
_servers="user@dominio.com:/var/ferarg/servidor/"
_rsync="/usr/bin/rsync"
_exclude="/root/scripts/rsync/excluir.txt"
_log="/root/logs/rsync_mirror.log"
_opts=""
msn="rsync a svr-web"

for e in $_servers
do
        [ -f "${_exclude}" ] && _opts="--exclude-from=$_exclude"
        $_rsync -z --compress-level=5 -a --delete $_opts  "$_upstream" "$e"
done

echo "$fecha - $hora">>$_log

twitter

unset _upstream
unset _servers
unset _rsync
unset _exclude
unset _log
unset _opts
unset fecha
unset hora
unset msn