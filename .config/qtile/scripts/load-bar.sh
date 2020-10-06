#!/bin/bash

EWW_PATH=~/.local/bin/eww

killall $EWW_PATH
sleep 0.5
$EWW_PATH daemon &
sleep 0.5

$EWW_PATH open bar &

numscreens=$(xrandr | grep ' connected' | wc -l)
if [ $numscreens -gt 1 ]; then
    $EWW_PATH open bar2 &
fi

echo "Finished..."
