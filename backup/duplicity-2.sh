#!/bin/bash
#
# Copyright (c) 2008-2010 Damon Timm.
# Copyright (c) 2010 Mario Santagiuliana.
# Copyright (c) 2012 Marc Gallet.
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <http://www.gnu.org/licenses/>.
#
# MORE ABOUT THIS SCRIPT AVAILABLE IN THE README AND AT:
#
# http://zertrin.org/projects/duplicity-backup/ (for this version)
# http://damontimm.com/code/dt-s3-backup (for the original programi by Damon Timm)
#
# Latest code available at:
# http://github.com/zertrin/duplicity-backup
#
# ---------------------------------------------------------------------------- #

# #############################################
# #       DUPLICITY-BACKUP CONFIG FILE        #
# #############################################

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# ! DO NOT edit duplicity-backup.conf.example !
# !    please copy it to anywhere you want    !
# !     (typically duplicity-backup.conf)     !
# !        and edit this file instead         !
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# AMAZON S3 INFORMATION
# Comment out these lines if you're not using Amazon S3
AWS_ACCESS_KEY_ID="foobar_aws_key_id"
AWS_SECRET_ACCESS_KEY="foobar_aws_access_key"

# S3CMD INFORMATION
# Most people don't need this, but in some cases
# you may want to specify a custom configuration file
# to pass to s3cmd. If so, set the S3CMD_CONF_FILE variable
# to the full path of this custom config file.
# Per default s3cmd uses ${HOME}/.s3cfg
# S3CMD_CONF_FILE='/path/to/your/s3cmd/conf/file'

# ENCRYPTION INFORMATION
# Do you want your backup to be encrypted? yes/no
# If yes, please make sure you specify either PASSPHRASE or GPG_ENC_KEY/GPG_SIGN_KEY
ENCRYPTION='yes'

# If you are NOT running this from a cron, comment this line out
# and duplicity should prompt you for your password.
# Otherwise this password is either used for symmetric encryption
# (your backups will be encrypted with this password) or is used
# for the "GPG_SIGN_KEY" (see below).
# Comment out if you aren't using encryption
PASSPHRASE="foobar_gpg_passphrase"

# Specify which GPG keys you would like to use (even if you have only one).
# If you are running this from a cron, it is highly recommended to create separate
# signature and encryption keys, because you have to specify the password for the
# GPG_SIGN_KEY via the above PASSPHRASE variable
# (see http://www.debian-administration.org/articles/209#d0e109).
# If you are not running the script from a cron, duplicity should prompt you for the
# GPG_SIGN_KEY password.
# If you choose to use the same GPG key for encryption and signature, set it both
# in GPG_ENC_KEY and GPG_SIGN_KEY.
# Comment out if you're using only PASSPHRASE (symmetric encryption) or not using
# encryption at all.
GPG_ENC_KEY="foobar_gpg_key"
GPG_SIGN_KEY="foobar_gpg_key"

# BACKUP SOURCE INFORMATION
# The ROOT of your backup (where you want the backup to start);
# This can be / or somwhere else -- I use /home/ because all the
# directories start with /home/ that I want to backup.
ROOT="/home"

# BACKUP DESTINATION INFORMATION
# In my case, I use Amazon S3 use this - so I made up a unique
# bucket name (you don't have to have one created, it will do it
# for you).  If you don't want to use Amazon S3, you can backup
# to a file or any of duplicity's supported outputs.
#
# The s3+http scheme uses the default aws s3 hostname.
# Use s3://host/bucket/[backup-folder/] if you want to specify the host name.
# If using the s3://... scheme and you have s3cmd installed, be sure to change
# 's3.amazonaws.com' to the appropriate host in your .s3cfg file so that the
# remote file size check will work.
#DEST="s3://host/backup-bucket/backup-folder/"
DEST="s3+http://backup-bucket/backup-folder/"
# Other possible locations
#DEST="ftp://user[:password]@other.host[:port]/some_dir"
#DEST="rsync://user@host.com[:port]//absolute_path"
#DEST="scp://user[:password]@other.host[:port]/[/]some_dir"
#DEST="ssh://user[:password]@other.host[:port]/[/]some_dir"
#DEST="file:///home/foobar_user_name/new-backup-test/"

# INCLUDE LIST OF DIRECTORIES
# Here is a list of directories to include; if you want to include
# everything that is in root, you could leave this list empty (I think).
#
# Here is an example with multiple locations:
#INCLIST=(  "/home/*/Documents" \
#           "/home/*/Projects" \
#           "/home/*/logs" \
#           "/home/www/mysql-backups" \
#        )
#
# Simpler example with one location:
INCLIST=( "/home/foobar_user_name/Documents/Prose/" )

# EXCLUDE LIST OF DIRECTORIES
# Even though I am being specific about what I want to include,
# there is still a lot of stuff I don't need.
EXCLIST=(   "/home/*/Trash" \
            "/home/*/Projects/Completed" \
            "/**.DS_Store" "/**Icon?" "/**.AppleDouble" \
        )

# STATIC BACKUP OPTIONS
# Here you can define the static backup options that you want to run with
# duplicity. Reference is the manpage of duplicity (available at
# http://duplicity.nongnu.org/duplicity.1.html for example)
# Useful examples are `--full-if-older-than` option and (for those using
# Amazon S3 in Europe) `--s3-use-new-style` and `--s3-european-buckets` options
# Be sure to separate your options with appropriate spacing.
STATIC_OPTIONS="--full-if-older-than 14D --s3-use-new-style"

# FULL BACKUP & REMOVE OLDER THAN SETTINGS
# Because duplicity will continue to add to each backup as you go,
# it will eventually create a very large set of files.  Also, incremental
# backups leave room for problems in the chain, so doing a "full"
# backup every so often is not a bad idea.
#
# You can either remove older than a specific time period:
#CLEAN_UP_TYPE="remove-older-than"
#CLEAN_UP_VARIABLE="31D"

# Or, If you would rather keep a certain (n) number of full backups (rather
# than removing the files based on their age), you can use what I use:
CLEAN_UP_TYPE="remove-all-but-n-full"
CLEAN_UP_VARIABLE="2"

# LOGFILE INFORMATION DIRECTORY
# Provide directory for logfile, ownership of logfile, and verbosity level.
# I run this script as root, but save the log files under my user name --
# just makes it easier for me to read them and delete them as needed.

LOGDIR="/home/foobar_user_name/logs/test2/"
LOG_FILE="duplicity-`date +%Y-%m-%d_%H-%M`.txt"
LOG_FILE_OWNER="foobar_user_name:foobar_user_name"
VERBOSITY="-v3"

# EMAIL ALERT (*thanks: rmarescu*)
# Provide an email address to receive the logfile by email. If no email
# address is provided, no alert will be sent.
# You can set a custom from email address and a custom subject (both optionally)
# If no value is provided for the subject, the following value will be
# used by default: "duplicity-backup Alert ${LOG_FILE}"
# MTA used: mailx
#EMAIL="admin@example.com"
EMAIL_TO=
EMAIL_FROM=
EMAIL_SUBJECT=

# command to use to send mail
MAIL="mailx"
#MAIL="mail"
#MAIL="ssmtp"
#MAIL="sendmail"

# TROUBLESHOOTING: If you are having any problems running this script it is
# helpful to see the command output that is being generated to determine if the
# script is causing a problem or if it is an issue with duplicity (or your
# setup).  Simply  uncomment the ECHO line below and the commands will be
# printed to the logfile.  This way, you can see if the problem is with the
# script or with duplicity.
#ECHO=$(which echo)