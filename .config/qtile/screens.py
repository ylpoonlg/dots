import os
from libqtile.config import Screen

def reload_screens():
    screens = []

    num_screens = int(os.popen("xrandr | grep ' connected' | wc -l").read())
    for i in range( num_screens ):
        screens.append(
            Screen(),
        )
    
    return screens

# Screens
screens = reload_screens()
