#!/bin/bash

cd $(dirname "$0")

# qtile cmd-obj -o cmd -f reload_config
# qtile cmd-obj -o cmd -f restart

/usr/local/bin/setup-screens.sh
sleep 1
./load-bar.sh
