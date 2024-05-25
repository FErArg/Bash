#!/bin/bash
fecha="$(date +%F)"

touch /var/bkp-zimbra/backup_$(date +%a).log

# Outputs the time the backup started, for log/tracking purposes
echo "Time backup started = $(date +%T)" > /var/bkp-zimbra/backup_$(date +%a).log
before="$(date +%s)"

# Live sync before stopping Zimbra to minimize sync time with the services down
# Comment out the following line if you want to try single cold-sync only
#rsync -avHK --delete /opt/zimbra/ /var/bkp-zimbra

# which is the same as: /opt/zimbra /backup
# Including --delete option gets rid of files in the dest folder that don't exist at the src
# this prevents logfile/extraneous bloat from building up overtime.

# Now we need to shut down Zimbra to rsync any files that were/are locked
# whilst backing up when the server was up and running.
before2="$(date +%s)"

# Stop Zimbra Services
su - zimbra -c"/opt/zimbra/bin/zmcontrol stop"
sleep 15

# Kill any orphaned Zimbra processes
ORPHANED=`ps -u zimbra -o "pid="` && kill -9 $ORPHANED

# Only enable the following command if you need all Zimbra user owned
# processes to be killed before syncing
# ps auxww | awk '{print $1" "$2}' | grep zimbra | kill -9 `awk '{print $2}'`

# Sync to backup directory
rsync -avHK --delete /opt/zimbra/ /var/bkp-zimbra/$fecha

# Restart Zimbra Services
su - zimbra -c "/opt/zimbra/bin/zmcontrol start"

# Calculates and outputs amount of time the server was down for
after="$(date +%s)"
elapsed="$(expr $after - $before2)"
hours=$(($elapsed / 3600))
elapsed=$(($elapsed - $hours * 3600))
minutes=$(($elapsed / 60))
seconds=$(($elapsed - $minutes * 60))
echo "Server was down for: "$hours hours $minutes minutes $seconds seconds"" >> /var/bkp-zimbra/backup_$(date +%a).log

# Create a txt file in the backup directory that'll contains the current Zimbra
# server version. Handy for knowing what version of Zimbra a backup can be restored to.
# su - zimbra -c "zmcontrol -v > /backup/zimbra/conf/zimbra_version.txt"
# or examine your /opt/zimbra/.install_history

# Display Zimbra services status
echo "Displaying Zimbra services status..." >> /var/bkp-zimbra/backup_$(date +%a).log
su - zimbra -c "/opt/zimbra/bin/zmcontrol status" >> /var/bkp-zimbra/backup_$(date +%a).log

# Create archive of backed-up directory for offsite transfer
# cd /backup/zimbra
# umask 0177
# tar -zcvf /backup/mail.backup_$(date +%a).tgz -C /var/bkp-zimbra/zimbra .
# Transfer file to backup server
# transfer command goes here *
# rm /tmp/mail.backup.tgz

# Outputs the time the backup finished
echo "Time backup finished = $(date +%T)" >> /var/bkp-zimbra/backup_$(date +%a).log

# Calculates and outputs total time taken
after="$(date +%s)"
elapsed="$(expr $after - $before)"
hours=$(($elapsed / 3600))
elapsed=$(($elapsed - $hours * 3600))
minutes=$(($elapsed / 60))
seconds=$(($elapsed - $minutes * 60))
echo "Time taken: "$hours hours $minutes minutes $seconds seconds"" >> /var/bkp-zimbra/backup_$(date +%a).log