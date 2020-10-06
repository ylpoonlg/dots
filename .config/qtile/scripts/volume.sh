#!/bin/bash

sink=$(pactl get-default-sink)

case $1 in
    "set")
        pactl set-sink-volume $sink $2
        ;;
    "mute")
        pactl set-sink-mute $sink $2
        ;;
esac
