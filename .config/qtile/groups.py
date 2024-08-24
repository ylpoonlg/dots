import os

from libqtile.config import Group, Key, Match
from libqtile.lazy import lazy

from keymaps import mod, keys

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
        "layout": 'Split',
    }, {"name": '',
        "switch-key": '5',
        "matches": [],
    }, {"name": '',
        "switch-key": '6',
        "matches": [],
    }, {"name": '',
        "switch-key": '7',
        "matches": [Match(wm_class=["systemsettings"])],
    }, {"name": '',
        "switch-key": '8',
        "matches": [
            Match(wm_class=["signal"]),
            Match(wm_class=["discord"]),
            Match(wm_class=["thunderbird"]),
        ],
    }, {"name": '',
        "switch-key": '9',
        "matches": [],
    }, {"name": '',
        "switch-key": '0',
        "matches": [Match(wm_class=["clementine"])],
    }
]

groups = [
    Group(
        group_props[i]['name'],
        matches=group_props[i]['matches'],
        layout=group_props[i].get('layout', None)
    )
    for i in range(len(group_props))
]
for i in range(len(group_props)):
    name = groups[i].name
    keys.extend([
        # Switch to group
        Key([mod], group_props[i]['switch-key'], lazy.group[ name ].toscreen(toggle=True)),
        # Send window to group
        Key([mod, "shift"], group_props[i]['switch-key'], lazy.window.togroup(name, switch_group=True)),
    ])


extra_group = 0
@lazy.function
def addGroup(qtile):
    global extra_group
    if extra_group <= 9:
        qtile.cmd_addgroup(str(extra_group))
        extra_group += 1

@lazy.function
def delGroup(qtile):
    global extra_group
    if extra_group > 0:
        extra_group -= 1
        qtile.cmd_delgroup(str(extra_group))

keys.extend([
    Key([mod, "shift"], "equal", addGroup, desc="New Group"),
    Key([mod, "shift"], "minus", delGroup, desc="Delete Group"),
    Key([mod], "equal", lazy.screen.next_group(), desc="Next Group"),
    Key([mod], "minus", lazy.screen.prev_group(), desc="Previous Group"),
])
