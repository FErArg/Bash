#!/bin/bash

# ROOT
cd
cd /opt/zimbra/ssl
mv mail mail-$(date +%F)
mkdir mail
cd mail
cp -RL /etc/letsencrypt/live/zimbra.domain.com/* .
cp /opt/zimbra/ssl/mail/privkey.pem /opt/zimbra/ssl/zimbra/commercial/commercial.key
wget -O /tmp/ISRG-X1.pem https://letsencrypt.org/certs/isrgrootx1.pem.txt
cat /tmp/ISRG-X1.pem >> /opt/zimbra/ssl/mail/chain.pem
chown zimbra:zimbra /opt/zimbra/ssl/zimbra/commercial/commercial.key
chown zimbra:zimbra -R /opt/zimbra/ssl/mail

#ZIMBRA
su - zimbra -c"/opt/zimbra/bin/zmcertmgr verifycrt comm /opt/zimbra/ssl/zimbra/commercial/commercial.key /opt/zimbra/ssl/mail/cert.pem /opt/zimbra/ssl/mail/chain.pem"
su - zimbra -c"/opt/zimbra/bin/zmcertmgr deploycrt comm /opt/zimbra/ssl/mail/cert.pem /opt/zimbra/ssl/mail/chain.pem"
su - zimbra -c"/opt/zimbra/bin/zmcertmgr deploycrt comm /opt/zimbra/ssl/mail/cert.pem /opt/zimbra/ssl/mail/chain.pem && /opt/zimbra/bin/zmcertmgr verifycrt comm /opt/zimbra/ssl/mail/privkey.pem /opt/zimbra/ssl/mail/cert.pem /opt/zimbra/ssl/mail/chain.pem"