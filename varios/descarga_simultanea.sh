#! /bin/bash
# fuerza multiples downloads

for i in {1..10}; do
  wget http://dominio.org:8888/0/repo/20151008-com.uc.browser.hd.apk -O $i-Archivo &
done