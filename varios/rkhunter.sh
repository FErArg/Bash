#!/bin/sh
asunto="Análisis de rootkit en $hotname"
log="/root/logs/rkhunter/$fecha.log"
rkhunter=$(which rkhunter)
chkrootkit=$(which chkrootkit)

$rkhunter --versioncheck
$rkhunter --update
$rkhunter --cronjob --report-warnings-only
$rkhunter --check --sk --append-log -l $log

$chkrootkit >> $log


# "comprimiendo virus" tar echo "Enviando Email"
mutt -s "$asunto $fecha" $email1 < $log
mutt -s "$asunto $fecha" $email2 < $log