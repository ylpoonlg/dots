#!/bin/bash

EWW=/home/long/.local/bin/eww

killall ${EWW}
sleep 0.5
${EWW} daemon &
sleep 0.5

${EWW} open bar &

numscreens=$(xrandr | grep ' connected' | wc -l)
if [ $numscreens -gt 1 ]; then
    ${EWW} open bar2 &
fi

echo "Finished..."
