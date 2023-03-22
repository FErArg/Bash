#!/bin/bash

db="$1"
db1="/var/lib/mysql/$db"
echo "BaseDatos a Reparar $db1"
echo ""

service mysql stop
myisamchk -r -v -f $db1/*
service mysql start
