# Edited by ylpoonlg

import os
import subprocess
from typing import List

from libqtile import hook, qtile
from libqtile.backend import base
from libqtile.config import Match

# Import Configs
from settings import *
from style import colors
from keymaps import mod, keys
from groups import groups, group_props
from bar import screens
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
    subprocess.call([os.path.join(config_path, 'scripts/reload-xorg.sh')])
    subprocess.call([os.path.join(config_path, 'scripts/autostart.sh')])

    # Start Applications
    qtile.cmd_spawn(filemanager)
    qtile.cmd_spawn('clementine')
    qtile.cmd_spawn(browser)
    qtile.cmd_switchgroup(group_props[2]['name'])
    qtile.cmd_spawn(terminal)

@hook.subscribe.client_managed
def resizeRules(window:base.Window):
    wid = window.wid
    if window.match(Match(wm_class="plasmawindowed")):
        qtile.cmd_spawn(
            f'qtile cmd-obj -o window {wid} -f set_position_floating -a 1200 30'
        )
        qtile.cmd_spawn(
            f'qtile cmd-obj -o window {wid} -f set_size_floating -a 400 415'
        )
