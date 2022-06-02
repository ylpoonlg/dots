#!/bin/bash

options=""
options="${options}Cancel\n"
options="${options}Sleep\n"
options="${options}Hibernate\n"
options="${options}Lock\n"
options="${options}Shutdown\n"
options="${options}Restart"

choice=$(echo -e $options | rofi -dmenu -p "Power")

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
