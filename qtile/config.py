# Edited by ylpoonlg

from libqtile import bar, layout, widget, hook, qtile
from libqtile.backend import base
from libqtile.command.client import CommandClient
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

import os, subprocess
import asyncio, time
import pickle
import psutil
from pathlib import Path
from typing import List  # noqa: F401


# Applications
terminal = "kitty" # guess_terminal()
browser = "vivaldi-stable"
filemanager = "pcmanfm-qt"


# Key Bindings
mod = "mod4"
keys = [
    # Switch Windows
    Key([mod], "h", lazy.layout.left(), lazy.layout.previous().when(layout = "Stack"), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), lazy.layout.next().when(layout = "Stack"), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # Move Windows
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), lazy.layout.client_to_previous().when(layout = "Stack"), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), lazy.layout.client_to_next().when(layout = "Stack"), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # MonadTall
    Key([mod], "i", lazy.layout.grow()),
    Key([mod], "m", lazy.layout.shrink()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "o", lazy.layout.maximize()),
    Key([mod, "shift"], "space", lazy.layout.flip()),
    
    # Stack
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

    # Layouts
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "s", lazy.next_screen(), desc="Toggle between screens"),
    Key([mod], "x", lazy.spawn("Qminimize -m"), desc="Minimize window"),
    Key([mod, "shift"], "x", lazy.spawn("Qminimize -u"), desc="Show minimize menu"),
    
    # Qtile
    Key([mod, "control", "shift"], "r",
        lazy.spawn("/home/long/.config/qtile/reload-xorg.sh"),
        lazy.restart(),
        desc="Restart Qtile and Reload Xorg config"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod, "control"], "l",
    #     lazy.spawn("systemctl suspend"),
    #     lazy.spawn("slock"),
    #     desc="Sleep and Lock"),
    Key([mod, "control"], "l",
        lazy.spawn(os.path.expanduser('~/.config/qtile/power-menu.sh')),
        desc="Select power management options",
    ),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "f", lazy.window.toggle_floating(), desc="Switch back to tiling mode"),

    # Applications
    Key([mod], "p", lazy.spawn("rofi -show combi -display-combi Applications"), desc="Application launcher"), # Rofi
    Key([mod], "Return", lazy.spawn(terminal)), # Terminal
    Key([mod], "b", lazy.spawn(browser)), # Browser
    Key([mod], "f", lazy.spawn(filemanager)), # File Manager
    Key([mod], "t", lazy.spawn("subl")), # Text Editor

    # Laptop
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +5%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-")),

    # Volume
    Key([], "XF86AudioRaiseVolume", lazy.spawn("set-vol +5%")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("set-vol -5%")),
]


# Colors
colors = {
    'white': '#F8F8F0', # white
    'gray-0': '#AAADAF', # light gray
    'gray-1': '#595959', # darker light gray
    'gray-2': '#424242', # medium gray
    'gray-3': '#242420', # darker medium gray
    'mnk-gray': '#272822', # monokai gray
    'mnk-pink': '#F92672', # monokai pink
    'mnk-orange': '#FD971F', # monokai orange
    'mnk-yellow': '#E6DB74', # monokai yellow
    'mnk-green': '#A6E22E', # monokai green
    'mnk-blue': '#66D9EF', # monokai blue
    'mnk-purple': '#AE81FF', # monokai purple
    'blue-0': '#3B96F7', # light blue
    'blue-1': '#217CDD', # darker light blue
    'blue-2': '#2C2F38', # bluish gray
    'blue-3': '#22252E', # darker bluish gray
}


# Groups
group_props = [
    {   "name": '',
        "switch-key": '1',
        "matches": [],
    }, {"name": '',
        "switch-key": '2',
        "matches": [],
    }, {"name": '',
        "switch-key": '3',
        "matches": [],
    }, {"name": '',
        "switch-key": '4',
        "matches": [Match(wm_class=["pcmanfm-qt"])],
    }, {"name": '',
        "switch-key": '5',
        "matches": [],
    }, {"name": '',
        "switch-key": '6',
        "matches": [],
    }, {"name": '',
        "switch-key": '7',
        "matches": [],
    }, {"name": '',
        "switch-key": '8',
        "matches": [Match(wm_class=["signal"]), Match(wm_class=["discord"])],
    }, {"name": '',
        "switch-key": '9',
        "matches": [],
    }, {"name": '',
        "switch-key": '0',
        "matches": [Match(wm_class=["clementine"])],
    }
]

groups = [Group(group_props[i]['name'], matches=group_props[i]['matches']) for i in range(len(group_props))]
for i in range(len(group_props)):
    name = groups[i].name
    keys.extend([
        # Switch to group
        Key([mod], group_props[i]['switch-key'], lazy.group[ name ].toscreen(toggle=True)),
        # Send window to group
        Key([mod, "shift"], group_props[i]['switch-key'], lazy.window.togroup(name, switch_group=True)),
    ])


# Layouts
layouts = [
    layout.MonadTall(
        name='MonadTall',
        border_focus = colors['mnk-orange'],
        border_normal = colors['mnk-gray'],
        border_width = 3,
        margin = 6,
        ratio = 0.55,
    ),
    layout.Max(name='Max'),
    #layout.Columns(
    #    name='Columns',
    #    border_focus = colors['mnk-orange'],
    #    border_normal = colors['mnk-gray'],
    #    border_width = 4,
    #    margin = 5,
    #),
    layout.Stack(
        name="Stack",
        border_focus = colors['mnk-orange'],
        border_normal = colors['mnk-gray'],
        border_width = 3,
        margin = 6,
        num_stacks = 2,
    ),
]


# Bars
def widget_sep(padding=6):
    return widget.Sep(
        linewidth=0,
        padding=padding,)

def formatWindowName(name):
    if (len(name) < 60):
        spaces = ' ' * ((60-len(name)) // 2)
        return spaces + name + spaces
    else:
        return name

icon_font = "Font Awesome 6 Free"
myBar0 = [
    widget_sep(), widget.Image(
        filename = '~/Pictures/sys/arch_logo.png',
        margin = 6,
    ),

    widget.GroupBox(
        #background = colors['mnk-gray'],
        active = colors['mnk-blue'],
        inactive = colors['gray-0'],
        block_highlight_text_color = colors['mnk-orange'],
        foreground = colors['white'],
        borderwidth = 2,
        this_current_screen_border = colors['white'],
        other_screen_border = colors['gray-1'],
        this_screen_border = colors['gray-0'],
        other_current_screen_border = colors['gray-2'],
        padding_x = 5,
        padding_y = 5,
        fontsize = 16,
        font = icon_font,
        disable_dray = True,
    ),

    widget_sep(), widget.TextBox(
        text = '',
        foreground = colors['gray-0'],
        fontsize = 12,
        font = icon_font,
    ), widget.CurrentLayout(
        foreground = colors['gray-0'],
    ), widget_sep(),

    widget_sep(), widget.WidgetBox(
        foreground = colors['gray-0'],
        widgets=[
            widget_sep(),
            widget.TaskList(
                foreground = colors['gray-0'],
                border = colors['blue-3'],
                highlight_method = 'block',
                margin = 2,
                padding = 6,
                icon_size = 14, # 0
                max_title_width = 256,
                title_width_method = 'uniform',
                txt_floating = '🗗 ',
                txt_maximized = '🗖 ',
                txt_minimized = '🗕 ',
                fontsize = 12,
                font = icon_font,
            ),
        ],
        text_closed = '',
        text_open = '',
        fontsize = 10,
        font = icon_font,
    ), widget_sep(), widget.WindowName(
        foreground = colors['gray-1'],
        max_chars = 60
    ),
    widget.Spacer(),

    widget.WidgetBox(
        foreground = colors['gray-0'],
        widgets = [
            widget_sep(),widget.TextBox(
                "",
                mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn("systemctl suspend")},
                fontsize = 12,
                font = icon_font,
            ),widget_sep(),
            widget.TextBox(
                "",
                mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn("systemctl hibernate")},
                fontsize = 12,
                font = icon_font,
            ),widget_sep(),
            widget.TextBox(
                "",
                mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn("shutdown now")},
                fontsize = 12,
                font = icon_font,
            ),widget_sep(),
            widget.TextBox(
                "",
                mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn("reboot")},
                fontsize = 12,
                font = icon_font,
            ),widget_sep(),
        ],
        text_closed = '',
        text_open = '',
        fontsize = 12,
        font = icon_font,
    ), widget_sep(),

    widget.Systray(
        foreground = colors['white'],
    ), widget_sep(),

    widget.TextBox(
        text = '',
        foreground = colors['mnk-orange'],
        fontsize = 12,
        font = icon_font,
        mouse_callbacks = {"Button1": lambda: plasmoidLaunch('org.kde.plasma.networkmanagement')},
    ), widget_sep(),

    widget.TextBox(
        text = '',
        foreground = colors['mnk-blue'],
        fontsize = 12,
        font = icon_font,
        mouse_callbacks = {"Button1": lambda: plasmoidLaunch('org.kde.plasma.volume')},
    ), widget_sep(),

    widget.TextBox(
        text = '',
        foreground = colors['mnk-orange'],
        fontsize = 12,
        font = icon_font,
        mouse_callbacks = {"Button1": lambda: plasmoidLaunch('org.kde.plasma.bluetooth')},
    ), widget_sep(),

    widget.TextBox(
        text = '',
        foreground = colors['mnk-blue'],
        fontsize = 12,
        font = icon_font,
    ), widget.Memory(
        foreground = colors['mnk-blue'],
        format = ' {MemUsed: .0f} MB',
    ), widget_sep(),

    widget.TextBox(
        text = '',
        foreground = colors['mnk-orange'],
        fontsize = 12,
        font = icon_font,
    ), widget.CPU(
        foreground = colors['mnk-orange'],
        format = ' {load_percent}%',
    ), widget_sep(),

    # widget.BatteryIcon(
    #     theme_path = '/home/long/.config/qtile/icons',
    #     update_interval = 10
    # ),
    widget.TextBox(
        text = "",
        foreground = colors['mnk-blue'], 
        fontsize = 12,
        font = icon_font,
        mouse_callbacks = {"Button1": lambda: plasmoidLaunch('org.kde.plasma.battery')},
    ), widget.Battery(
        foreground = colors['mnk-blue'], 
        format = '{percent:2.0%}',
        update_interval = 10,
    ), widget_sep(),


    widget.TextBox(
        text = 'HKT',
        foreground = colors['mnk-orange'],
    ), widget.Clock(
        foreground = colors['mnk-orange'],
        timezone = 'Asia/Hong_Kong',
        format = '%H:%M',
        update_interval = 1.0,
    ), widget_sep(),

    widget.TextBox(
        text = '',
        foreground = colors['mnk-blue'],
        fontsize = 12,
        font = icon_font,
    ), widget.Clock(
        foreground = colors['mnk-blue'],
        format = '%a %Y-%m-%d %H:%M:%S',
        update_interval = 1.0,
    ), widget_sep(),
]

myBar1 = [
    widget_sep(),
    widget.GroupBox(
        #background = colors['mnk-gray'],
        active = colors['mnk-blue'],
        inactive = colors['gray-0'],
        block_highlight_text_color = colors['mnk-orange'],
        foreground = colors['white'],
        borderwidth = 2,
        this_current_screen_border = colors['white'],
        other_screen_border = colors['gray-1'],
        this_screen_border = colors['gray-0'],
        other_current_screen_border = colors['gray-2'],
        padding_x = 5,
        padding_y = 5,
        fontsize = 16,
        font = icon_font,
        disable_dray = True,
    ),

    widget_sep(), widget.TextBox(
        text = '',
        foreground = colors['gray-0'],
        fontsize = 12,
        font = icon_font,
    ), widget.CurrentLayout(
        foreground = colors['gray-0'],
    ), widget_sep(),

    widget_sep(), widget.WidgetBox(
        foreground = colors['gray-0'],
        widgets=[
            widget_sep(),
            widget.TaskList(
                foreground = colors['gray-0'],
                border = colors['blue-3'],
                highlight_method = 'block',
                margin = 2,
                padding = 6,
                icon_size = 14, # 0
                max_title_width = 256,
                title_width_method = 'uniform',
                txt_floating = '🗗 ',
                txt_maximized = '🗖 ',
                txt_minimized = '🗕 ',
                fontsize = 12,
                font = icon_font,
            ),
        ],
        text_closed = '',
        text_open = '',
        fontsize = 10,
        font = icon_font,
    ), widget_sep(), widget.WindowName(
        foreground = colors['gray-1'],
        max_chars = 60
    ),
    widget.Spacer(),

    widget.TextBox(
        text = 'HKT',
        foreground = colors['mnk-orange'],
    ), widget.Clock(
        foreground=colors['mnk-orange'],
        # background=colors['bg1'],
        timezone='Asia/Hong_Kong',
        format='%H:%M',
        update_interval=1.0,
    ), widget_sep(),

    widget.TextBox(
        text = '',
        foreground = colors['mnk-blue'],
        fontsize = 12,
        font = icon_font,
    ), widget.Clock(
        foreground=colors['mnk-blue'],
        # background=colors['bg1'],
        format='%a %Y-%m-%d %H:%M:%S',
        update_interval=1.0,
    ), widget_sep(),
]


# Screens
screens = [
    Screen(
        top = bar.Bar(
            myBar0,
            30,
            background = colors['blue-2'],
            opacity = 0.95,
        )
    ),
]

isMultiScreen = os.popen("xrandr | grep 'DP2 connected'") != ""
if isMultiScreen:
    screens.append(
        Screen(
            top = bar.Bar(
                myBar1,
                30,
                background = colors['blue-2'],
                opacity = 0.95,
            )
        ),
    )


# Floating Layout
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

floating_layout = layout.Floating(
    border_focus = colors['mnk-orange'],
    border_normal = colors['mnk-gray'],
    border_width = 3,
    float_rules=[
        # Use "xprop | grep WM_CLASS" to get the class names
        *layout.Floating.default_float_rules,
        Match(wm_class='confirm'),
        Match(wm_class='dialog'),
        Match(wm_class='download'),
        Match(wm_class='error'),
        Match(wm_class='file_progress'),
        Match(wm_class='splash'),
        Match(wm_class='notification'),
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
        Match(wm_class='nm-connection-editor'), # NM Applet
        Match(wm_class='plank'),
        Match(wm_class='plasmawindowed'),
    ],
)

isPlasmoidShowing = False
def plasmoidLaunch(applet):
    global isPlasmoidShowing
    if isPlasmoidShowing:
        qtile.cmd_spawn('killall plasmawindowed')
        isPlasmoidShowing = False
        return
    
    qtile.cmd_spawn(f'plasmawindowed {applet}')
    isPlasmoidShowing = True


# Configuration Variables
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
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/reload-xorg.sh'])
    subprocess.call([home + '/.config/qtile/autostart.sh'])

@hook.subscribe.client_managed
def resizeRules(window:base.Window):
    wid = window.wid
    if window.match(Match(wm_class="plasmawindowed")):
        qtile.cmd_spawn(f'qtile cmd-obj -o window {wid} -f set_position_floating -a 1200 30')
        qtile.cmd_spawn(f'qtile cmd-obj -o window {wid} -f set_size_floating -a 400 415')
