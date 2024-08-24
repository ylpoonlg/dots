#!/bin/bash

TOUCHPAD_NAME="DLL0945:00 04F3:311C Touchpad"
TOUCHSCR_NAME="ELAN2D25:00 04F3:2D25"

case $1 in
    "touchpad-toggle")
        device_state=$(xinput list-props "$TOUCHPAD_NAME" | grep "Device Enabled" | awk -F  ":" '{print $2}')
        if [[ $device_state -eq "1" ]]; then
            xinput disable "$TOUCHPAD_NAME"
        else
            xinput enable "$TOUCHPAD_NAME"
        fi
        ;;
    "touchscreen-toggle")
        device_state=$(xinput list-props "$TOUCHSCR_NAME" | grep "Device Enabled" | awk -F  ":" '{print $2}')
        if [[ $device_state -eq "1" ]]; then
            xinput disable "$TOUCHSCR_NAME"
        else
            xinput enable "$TOUCHSCR_NAME"
        fi
        ;;
esac
