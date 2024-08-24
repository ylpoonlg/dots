import os

# Path
config_path = os.path.expanduser('~/.config/qtile/')

# Applications
terminal    = 'kitty --single-instance' # guess_terminal()
browser     = 'firefox'
emailclient = 'thunderbird'
filemanager = 'pcmanfm-qt'
texteditor  = 'subl'
musicplayer = 'clementine'

open_dashmenu = os.path.expanduser('~/.config/eww/scripts/pop menu')
rofi_launcher = os.path.expanduser('~/.config/rofi/scripts/launcher-1')

# Scripts
autostart     = os.path.join(config_path, 'scripts/autostart.sh')
loadbar       = os.path.join(config_path, 'scripts/load-bar.sh')
screen_change = os.path.join(config_path, 'scripts/screen-change.sh')
setup_screens = '/usr/local/bin/setup-screens.sh'

volume_up     = os.path.join(config_path, 'scripts/volume.sh set +5%')
volume_dn     = os.path.join(config_path, 'scripts/volume.sh set -5%')
volume_mute   = os.path.join(config_path, 'scripts/volume.sh mute toggle')
brightness_up = os.path.join(config_path, 'scripts/brightness.sh set +5%')
brightness_dn = os.path.join(config_path, 'scripts/brightness.sh set 5%-')

touchpad_toggle = os.path.join(config_path, 'scripts/inputs.sh touchpad-toggle')
touchscreen_toggle = os.path.join(config_path, 'scripts/inputs.sh touchscreen-toggle')

power_menu    = os.path.join(config_path, 'scripts/power-menu.sh')
