#!/bin/bash

options=""
options="${options}Sleep\n"
options="${options}Hibernate\n"
options="${options}ScreenOff\n"
options="${options}Lock\n"
options="${options}Shutdown\n"
options="${options}Restart"

if [ -z $1 ]; then
choice=$(echo -e $options | rofi -dmenu -p "Power" -theme $HOME/.config/rofi/power-menu/power.rasi)
else
    choice=$1
fi

echo "Choice: $choice"

case $choice in
    "Sleep")
        systemctl suspend
        slock
    ;;
    "Hibernate")
        systemctl hibernate
        slock
    ;;
    "ScreenOff")
        sleep 1
        xset dpms force off
    ;;
    "Lock")
        slock
    ;;
    "Shutdown")
        shutdown now
    ;;
    "Restart")
        reboot
    ;;
    *)
        echo "Invalid Choice"
    ;;
esac
