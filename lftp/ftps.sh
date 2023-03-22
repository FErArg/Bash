#!/bin/bash

curl -v --disable-epsv --ftp-skip-pasv-ip --ftp-ssl -T "/home/ferarg/hora.log" ftp://user:usuario1@192.168.1.104:21