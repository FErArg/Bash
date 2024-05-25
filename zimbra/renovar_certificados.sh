#!/bin/bash
. /root/scripts/./funciones.lib

/snap/bin/certbot certonly --agree-tos --preferred-chain "ISRG Root X1" --webroot -d zimbra.domain.com

sudo -u zimbra zmcontrol stop

mkdir -p /opt/zimbra/backup/certificados
cd /opt/zimbra/backup/certificados
tar cvzf $fecha.mail.tgz /opt/zimbra/ssl/mail
rm -Rf /opt/zimbra/ssl/mail/*
cp -L /etc/letsencrypt/live/zimbra.domain.com/* /opt/zimbra/ssl/mail/
chown zimbra:zimbra -R /opt/zimbra/ssl/mail/

cp /etc/letsencrypt/live/zimbra.domain.com/privkey.pem /opt/zimbra/ssl/zimbra/commercial/commercial.key
chown zimbra:zimbra /opt/zimbra/ssl/zimbra/commercial/commercial.key
wget -O /tmp/ISRG-X1.pem https://letsencrypt.org/certs/isrgrootx1.pem.txt
cat /tmp/ISRG-X1.pem >> /etc/letsencrypt/live/zimbra.domain.com/chain.pem
cp -LR /etc/letsencrypt/live/zimbra.domain.com/* /opt/zimbra/ssl/zimbra.domain.com/

chown zimbra:zimbra -R /opt/zimbra/ssl/zimbra.domain.com
chown zimbra:zimbra -R /opt/zimbra/ssl/zimbra/
#su zimbra
sudo -u zimbra /opt/zimbra/bin/zmcertmgr verifycrt comm /opt/zimbra/ssl/zimbra/commercial/commercial.key /opt/zimbra/ssl/zimbra.domain.com/cert.pem /opt/zimbra/ssl/zimbra.domain.com/chain.pem
sudo -u zimbra /opt/zimbra/bin/zmcertmgr deploycrt comm /opt/zimbra/ssl/zimbra.domain.com/cert.pem /opt/zimbra/ssl/zimbra.domain.com/chain.pem

sudo -u zimbra zmcontrol start