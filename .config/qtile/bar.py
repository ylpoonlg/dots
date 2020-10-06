from libqtile import bar, widget, qtile
from libqtile.config import Screen

import os

from settings import config_path
from style import colors

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
        filename = os.path.join(config_path, 'img/arch_logo.png'),
        margin = 6,
        mouse_callbacks = {
            "Button1": lambda: qtile.cmd_spawn(
                os.path.join(config_path, 'scripts/power-menu.sh')
            )
        },
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

    widget.Systray(
        foreground = colors['white'],
    ), widget_sep(),

    widget.TextBox(
        text = '',
        foreground = colors['mnk-orange'],
        fontsize = 12,
        font = icon_font,
        mouse_callbacks = {
            "Button1": lambda:
                plasmoidLaunch('org.kde.plasma.networkmanagement')
        },
    ), widget_sep(),

    widget.TextBox(
        text = '',
        foreground = colors['mnk-blue'],
        fontsize = 12,
        font = icon_font,
        mouse_callbacks = {"Button1": lambda: launchLgwid('volume')},
    ), widget_sep(),

    widget.TextBox(
        text = '',
        foreground = colors['mnk-orange'],
        fontsize = 12,
        font = icon_font,
        mouse_callbacks = {
            "Button1": lambda:
                plasmoidLaunch('org.kde.plasma.bluetooth')
        },
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

    widget.TextBox(
        text = "",
        foreground = colors['mnk-blue'], 
        fontsize = 12,
        font = icon_font,
        mouse_callbacks = {
            "Button1": lambda:
                plasmoidLaunch('org.kde.plasma.battery')
        },
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
        # top = bar.Bar(
        #     myBar0,
        #     30,
        #     background = colors['blue-2'],
        #     margin     = 5,
        #     opacity    = 0.95,
        # )
    ),
]

try:
    num_screens = int(os.popen("xrandr | grep ' connected' | wc -l").read())
    if num_screens > 1:
        screens.append(
            Screen(
                # top = bar.Bar(
                #     myBar1,
                #     30,
                #     background = colors['blue-2'],
                #     margin     = 5,
                #     opacity    = 0.95,
                # )
            ),
        )
except:
    pass


# Launch widgets
isPlasmoidShowing = False
def plasmoidLaunch(applet):
    global isPlasmoidShowing
    if isPlasmoidShowing:
        qtile.cmd_spawn('killall plasmawindowed')
        isPlasmoidShowing = False
        return
    
    qtile.cmd_spawn(f'plasmawindowed {applet}')
    isPlasmoidShowing = True


isLgwidShowing = False
def launchLgwid(mode):
    global isLgwidShowing
    if isLgwidShowing:
        qtile.cmd_spawn('killall lgwid')
        isLgwidShowing = False
        return

    qtile.cmd_spawn(os.path.expanduser(f'~/.local/bin/lgwid {mode}'))
    isLgwidShowing = True
