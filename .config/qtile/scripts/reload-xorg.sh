#!/bin/bash

if xrandr | grep -q "eDP-1-1";  then
    intDP="eDP-1-1"
    extDP="DP-1-2-2"
else
    intDP="eDP1"
    extDP="DP2"
fi

xrandr --output $intDP --auto
xrandr --output $extDP --auto

sleep 1

if xrandr | grep -q "$extDP connected"; then
    # External Display Connected
    xrandr --output $extDP --mode 1920x1080 --primary --left-of $intDP
    xrandr --output $intDP --mode 1920x1200 --scale 1x1
else
    xrandr --output $intDP --primary --mode 1920x1200 --scale 1x1
    export XCURSOR_SIZE=24
fi

xset s off
sleep 1
