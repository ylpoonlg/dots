#!/bin/bash

# trackpad
xinput set-prop "DLL0945:00 04F3:311C Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "DLL0945:00 04F3:311C Touchpad" "libinput Natural Scrolling Enabled" 1 

# wallpaper
nitrogen --restore &

# init
/usr/lib/polkit-kde-authentication-agent-1 & # polkit
gnome-keyring-daemon -r -d # keyring
#picom & # compositor
picom --experimental-backends & # compositor
fcitx & # google pinyin input
#plank & # application dock

# theme

# systray
#volumeicon &
optimus-manager-qt &
#blueman-applet &
#nm-applet --indicator &

# connections
rfkill block bluetooth
rfkill unblock bluetooth

# power management
/usr/lib/org_kde_powerdevil &
