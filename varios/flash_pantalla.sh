#!/bin/bash

while true; do echo -e "\e[?5h\e[38;5;1m A L E R T $(date)"; sleep 0.1; printf \\e[?5l; read -s -n1 -t1 && printf \\e[?5l && break; done```