#/bin/bash

fecha="$(date +%F)"
fecha2="$(date +%Y%m%d-%H%M)"

GPG_KEY=
export PASSPHRASE=GPGPassword
HUBIC_U=HubicUser
HUBIC_P=HubicPassword
origen="/etc"

PASSPHRASE="passphrase_for_GPG" duplicity cf+hubic://SI-Bkp-NAS1/pruebas/

# BACKUP ----------------------------------------------------------------
# duplicity $origen ftp://$HUBIC_U@ftp.domain.com/$fecha2

# Full
# duplicity full -v --no-encryption --include="/sourcedir/" --exclude="**" /  ssh://user@backupserver:22/destdir/

# Incremental
# duplicity incremental -v --no-encryption --include="/sourcedir/" --exclude="**" /  ssh://user@backupserver:22/destdir/


# Verificar Backup ------------------------------------------------------
# duplicity verify ftp://$HUBIC_U@ftp.domain.com/$fecha $origen


# Recovery --------------------------------------------------------------
# duplicity --no-encryption --file-to-restore / ssh://user@backupserver:22/destdir/

## If we need to restore data from 3 days ago:
## If we need to restore data from 3 days ago:
# duplicity --no-encryption -t 3D --file-to-restore / ssh://user@backupserver:22/destdir/
## The -t 3D option means restore a backup from three days ago. Similar options like -t 1M (for one month ago) or -t 5H (for 5 hours ago) also work.

unset PASSPHRASE
unset FTP_PASSWORD