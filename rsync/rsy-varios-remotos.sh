#!/bin/bash
. /root/scripts/./funciones.lib

# Usage: Mirror directories and files to our US, UK and Japan based server.
# --------------------------------------------------------------------------
_upstream="/var/www/corporate_lan"
_servers="root@us.example.com:/var/www/ root@uk.example.com:/var/www/ root@jp.example.com:/var/www/"
_rsync="/usr/bin/rsync"
_exclude="/root/mirror.exclude"
_log="/var/log/rsync_mirror.log"
_opts=""
mns="rsync varios remotos"
for e in $_servers
do
        [ -f "${_exclude}" ] && _opts="--exclude-from=$_exclude"
        $_rsync -z -a --delete $_opts  "$_upstream" "$e"
done &>$_log
twitter