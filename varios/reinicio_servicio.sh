!/bin/bash

ps axu | grep "[s]erver.js" >/dev/null 2>&1
if [ $? != 0 ] ; then
    # do something
    echo "off"
    cd /home/ivan/server_demo/
    node server.js &
    echo "Reinicio Server $(date)" >> /root/scripts/reinicio_server.log
else
    echo "on"
    echo "Server OK $(date)" >> /root/scripts/reinicio_server.log
fi
