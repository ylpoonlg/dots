#!/bin/bash

EWW=/home/long/.local/bin/eww

sink=$(pactl get-default-sink)

show_eww_popup () {
    ${EWW} open volume_change
    (sleep 3 ; ${EWW} close volume_change) &
}

case $1 in
    "set")
        pactl set-sink-volume $sink $2
        show_eww_popup
        ;;
    "mute")
        pactl set-sink-mute $sink $2
        show_eww_popup
        ;;
esac
