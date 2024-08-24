from libqtile import layout
from libqtile.config import Click, Drag, Match
from libqtile.lazy import lazy

from keymaps import mod
from style import colors

# Layouts
borders_params = {
    "border_focus": colors['orange'],
    "border_normal": colors['gray-75'],
    "border_width": 2,
}
layouts = [
    layout.MonadTall(
        name='Master',
        ratio=0.55,
        margin=6,
        **borders_params,
    ),
    layout.Max(
        name='Max',
        margin=[0, 6, 6, 6],
    ),
    layout.Stack(
        name='Split',
        num_stacks=2,
        margin=[0, 6, 6, 6],
        **borders_params,
    ),
    # layout.RatioTile(
    #     name='Tile',
    #     fancy=True,
    #     margin=[0, 6, 6, 6],
    #     **borders_params,
    # ),
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
    **borders_params,
    float_rules=[
        # Use "xprop | grep WM_CLASS" to get the class names
        *layout.Floating.default_float_rules,
        Match(wm_class='confirm'),
        Match(wm_class='conky'),
        Match(wm_class='dialog'),
        Match(wm_class='download'),
        Match(wm_class='error'),
        Match(wm_class='file_progress'),
        Match(wm_class='splash'),
        Match(wm_class='notification'),
        Match(wm_class='confirmreset'),
        Match(wm_class='makebranch'),
        Match(wm_class='maketag'),
        Match(wm_class='ssh-askpass'),
        Match(title='branchdialog'),
        Match(title='pinentry'),
        Match(wm_class='nm-connection-editor'),
        Match(wm_class='plank'),
        Match(wm_class='plasmawindowed'),
    ],
)
