#!/bin/bash
x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth /home/root/.vnc/passwd -rfbport 5901 -shared