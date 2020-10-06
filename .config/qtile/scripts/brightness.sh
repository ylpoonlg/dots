#!/bin/bash

case  $1 in
    "set")
        brightnessctl set $2

        # 512 * 5% = 26
        if [[ $(brightnessctl get) -lt 26 ]]; then
            brightnessctl set 26
        fi
        ;;
esac
