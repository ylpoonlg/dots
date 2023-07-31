# Edited by ylpoonlg

import os
import subprocess
import time
from typing import List

from libqtile import hook, qtile
from libqtile.backend import base
from libqtile.config import Match

# Import Configs
from settings import *
from style import colors
from keymaps import mod, keys
from groups import groups, group_props
from screens import screens
from layouts import floating_layout, layouts, mouse


wmname = "LG3D"
auto_fullscreen = True
focus_on_window_activation = "smart"
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False


# Hooks
@hook.subscribe.startup_once
def autostart():
    subprocess.run([os.path.join(config_path, 'scripts/autostart.sh')])
    subprocess.run([os.path.join(config_path, 'scripts/load-bar.sh')])

    # Start Applications
    qtile.cmd_spawn(filemanager)
    qtile.cmd_spawn(musicplayer)

@hook.subscribe.screen_change
def reload_screen_config(_):
    num_screens = int(os.popen("xrandr | grep ' connected' | wc -l").read())
    if len(screens) != num_screens:
        qtile.cmd_reload_config()
        subprocess.call(['/usr/local/bin/setup-screens.sh'])
        time.sleep(0.5)
        subprocess.call([os.path.join(config_path, 'scripts/load-bar.sh')])
        time.sleep(0.5)
        subprocess.call(['nitrogen', '--restore'])
