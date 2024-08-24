import os

from libqtile.lazy import lazy
from libqtile.config import Key

from settings import *


# Key Bindings
mod = "mod4"
keys = [
    # Switch Windows
    Key([mod], "h",
        lazy.layout.left(),
        lazy.layout.previous().when(layout="Split"),
        lazy.layout.previous().when(layout="Tile"),
        desc="Move focus to left"),
    Key([mod], "l",
        lazy.layout.right(),
        lazy.layout.next().when(layout="Split"),
        lazy.layout.next().when(layout="Tile"),
        desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(),
        desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(),
        desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move Windows
    Key([mod, "shift"], "h",
        lazy.layout.shuffle_left(),
        lazy.layout.client_to_previous().when(layout="Split"),
        lazy.layout.client_to_previous().when(layout="Tile"),
        desc="Move window to the left"),
    Key([mod, "shift"], "l",
        lazy.layout.shuffle_right(),
        lazy.layout.client_to_next().when(layout="Split"),
        lazy.layout.client_to_next().when(layout="Tile"),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(),
        desc="Move window up"),

    # MonadTall
    Key([mod], "i", lazy.layout.grow()),
    Key([mod], "m", lazy.layout.shrink()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "o", lazy.layout.maximize()),
    Key([mod, "shift"], "space", lazy.layout.flip()),
    
    # Stack
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),

    # Layouts
    Key([mod], "Tab", lazy.next_layout(), desc="Switch to next layout"),
    Key([mod, "shift"], "Tab", lazy.prev_layout(), desc="Switch to previous layout"),
    Key([mod], "s", lazy.next_screen(), desc="Toggle between screens"),
    Key([mod], "x", lazy.spawn("Qminimize -m"), desc="Minimize window"),
    Key([mod, "shift"], "x", lazy.spawn("Qminimize -u"),
        desc="Show minimize menu"),
    
    # Qtile
    Key([mod, "control", "shift"], "r",
        lazy.reload_config(),
        lazy.spawn(screen_change),
        desc="Restart Qtile and Reload screens config"),
    Key([mod, "control"], "r",
        lazy.reload_config(),
        lazy.spawn(loadbar),
        desc="Restart Qtile"),
    Key([mod, "control"], "q",
        lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "control"], "l",
        lazy.spawn(power_menu),
        desc="Select power management options"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "f", lazy.window.toggle_floating(),
        desc="Switch back to tiling mode"),

    # Applications
    Key([mod], "p", lazy.spawn(rofi_launcher)), # Rofi
    Key([mod], "d", lazy.spawn(open_dashmenu)), # Dashboard
    Key([mod], "Return", lazy.spawn(terminal)), # Terminal
    Key([mod], "b", lazy.spawn(browser)),       # Browser
    Key([mod], "f", lazy.spawn(filemanager)),   # File Manager
    Key([mod], "t", lazy.spawn(texteditor)),    # Text Editor
    Key([mod], "e", lazy.spawn(emailclient)),   # Email Client

    # Laptop
    Key([], "XF86MonBrightnessUp",   lazy.spawn(brightness_up)),
    Key([], "XF86MonBrightnessDown", lazy.spawn(brightness_dn)),

    # Volume
    Key([], "XF86AudioRaiseVolume", lazy.spawn(volume_up)),
    Key([], "XF86AudioLowerVolume", lazy.spawn(volume_dn)),
    Key([], "XF86AudioMute",        lazy.spawn(volume_mute)),

    # Keyboard
    Key([], "Find", lazy.spawn("setxkbmap -layout us -variant dvorak-lg")),
    Key(["shift"], "Find", lazy.spawn("setxkbmap -layout us")),
    Key(["control"], "F9", lazy.spawn("setxkbmap -layout us -variant dvorak-lg")),
    Key(["control", "shift"], "F9", lazy.spawn("setxkbmap -layout us")),
    Key(["control"], "F10", lazy.spawn(touchpad_toggle)),
    Key(["control", "shift"], "F10", lazy.spawn(touchscreen_toggle)),
]
