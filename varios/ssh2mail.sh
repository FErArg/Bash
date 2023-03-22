#!/bin/bash


# Aviso por mail por acceso via SSH

# instalar mutt y msmtp
# configurar /root/.muttrc
# configurar /root/.msmtprc
# copiar este archivo a /etc/profile.d

IP="$(echo $SSH_CONNECTION | cut -d " " -f 1)"
HOSTNAME=$(hostname)
NOW=$(date +"%e %b %Y, %a %r")
WHO="$(who)"
TMP="/tmp/$(date +%s | sha256sum | base64 | head -c 32 ; echo).txt"
LOCALIP="$(ip route get 8.8.8.8 | awk 'NR==1 {print $NF}')"
WANIP="$(dig +short myip.opendns.com @resolver1.opendns.com)"
touch $TMP
asunto="ALERTA ACCESO a $HOSTNAME"
echo -e "Fecha: $NOW \nAcceso a Servidor $HOSTNAME \nUsuario: $WHO \nLocal IP: $LOCALIP \nWan IP: $WANIP \n\nOtro Servicio de SerInformaticos \n\n" > $TMP && \
echo $asunto | mutt -s "$asunto" -- info@ferarg.com < $TMP && \
rm $TMP
