#!/bin/bash

options=""
options="${options}Sleep\n"
options="${options}Hibernate\n"
options="${options}Shutdown\n"
options="${options}Restart\n"
options="${options}Lock\n"
options="${options}Logout\n"
options="${options}ScreenOff"

if [ -z $1 ]; then
choice=$(echo -e $options | rofi -dmenu -p "Power" -theme $HOME/.config/rofi/power-menu/power.rasi)
else
    choice=$1
fi

echo "Choice: $choice"

case $choice in
    "Sleep")
        systemctl suspend
    ;;
    "Hibernate")
        systemctl hibernate
    ;;
    "ScreenOff")
        sleep 1
        xset dpms force off
    ;;
    "Lock")
        light-locker-command -l
    ;;
    "Logout")
        qtile cmd-obj -o cmd -f shutdown
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
