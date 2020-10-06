import os
from libqtile.config import Screen

# Screens
screens = [
    Screen(),
]

try:
    num_screens = int(os.popen("xrandr | grep ' connected' | wc -l").read())
    if num_screens > 1:
        screens.append(
            Screen(),
        )
except:
    pass
