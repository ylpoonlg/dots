from libqtile import layout
from libqtile.config import Click, Drag, Match
from libqtile.lazy import lazy

from keymaps import mod
from style import colors

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
    layout.Stack(
        name="Stack",
        border_focus = colors['mnk-orange'],
        border_normal = colors['mnk-gray'],
        border_width = 3,
        margin = 6,
        num_stacks = 2,
    ),
]


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
        Match(wm_class='lgwid-win'),
    ],
)
