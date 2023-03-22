#!/bin/bash

msn="NFS reiniciado"

/etc/init.d/portmap restart
/etc/init.d/nfs-common restart
/etc/init.d/nfs-kernel-server restart