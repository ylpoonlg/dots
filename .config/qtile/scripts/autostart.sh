#!/bin/bash

# keyboard
setxkbmap -option caps:escape

# trackpad
xinput set-prop "DLL0945:00 04F3:311C Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "DLL0945:00 04F3:311C Touchpad" "libinput Natural Scrolling Enabled" 1 
# wallpaper
nitrogen --restore &

# init
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & # polkit
gnome-keyring-daemon -r -d # keyring
picom --experimental-backends & # compositor
fcitx & # google pinyin input
dunst & # notification

# mount onedrive
~/mount_onedrive.sh

# systray
prime-offload
optimus-manager-qt &

# connections
# rfkill block bluetooth  # reset bluetooth
# rfkill unblock bluetooth

# power management
powerkit &

# Lock Screen
light-locker --lock-on-suspend --lock-on-lid &
xset s 0 0
xset s off -dpms
