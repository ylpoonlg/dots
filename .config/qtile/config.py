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


wmname = "Qtile" # "LG3D"
auto_fullscreen = True
focus_on_window_activation = "smart"
dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False


# Hooks
@hook.subscribe.startup_once
def autostart():
    subprocess.run([os.path.join(config_path, 'scripts/reload-xorg.sh')])
    subprocess.run([os.path.join(config_path, 'scripts/autostart.sh')])
    subprocess.run([os.path.join(config_path, 'scripts/launchbar.sh')])

    # Start Applications
    qtile.cmd_spawn(filemanager)
    qtile.cmd_spawn('clementine')


window_ids = {}
@hook.subscribe.client_managed
def resizeRules(window:base.Window):
    wid = window.wid

    try:
        if window.match(Match(wm_class="plasmawindowed")):
            qtile.cmd_spawn(
                f'qtile cmd-obj -o window {wid} -f set_position_floating -a 1300 60'
            )
            qtile.cmd_spawn(
                f'qtile cmd-obj -o window {wid} -f set_size_floating -a 400 415'
            )
    except:
        pass


@hook.subscribe.screen_change
def reload_screen_config(_):
    num_screens = int(os.popen("xrandr | grep ' connected' | wc -l").read())
    if len(screens) != num_screens:
        qtile.cmd_reload_config()
        subprocess.call([os.path.join(config_path, 'scripts/reload-xorg.sh')])
        time.sleep(0.5)
        subprocess.call([os.path.join(config_path, 'scripts/launchbar.sh')])
        time.sleep(0.5)
        subprocess.call(['nitrogen', '--restore'])
