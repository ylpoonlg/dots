#!/bin/bash

imgdir=~/Pictures/wallpapers/active/
randimg=$(ls $imgdir | shuf -n 1)

export DISPLAY=:0
export XAUTHORITY=~/.Xauthority
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

nitrogen --head=0 --set-zoom-fill $imgdir$randimg --save
nitrogen --head=1 --set-zoom-fill $imgdir$randimg --save
nitrogen --head=2 --set-zoom-fill $imgdir$randimg --save
nitrogen --head=3 --set-zoom-fill $imgdir$randimg --save

~/.config/eww/scripts/tray
