import argparse
from libqtile.command.client import InteractiveCommandClient

parser = argparse.ArgumentParser(description='Get workspace widgets')
parser.add_argument("--monitor", type=int, help="Current monitor")

args = parser.parse_args()

monitor = 0  # assume bar is displaying on monitor 0
if args.monitor:
    monitor = args.monitor

c = InteractiveCommandClient()

groups = {}
for name, group in c.get_groups().items():
    if name == "scratchpad":
        continue
    occupied     = len(group["windows"]) > 0
    focused      = group['screen'] is not None
    thisscreen   = group['screen'] == monitor

    groups[name] = {"occupied": occupied, "focused": focused, "thisscreen": thisscreen}

output = '(box	:class "workspaces"	:orientation "h" '
output += ':space-evenly "false" :halign "center" :valign "center" :vexpand "true"'
for name, prop in groups.items():
    command = f"scripts/qtile switch {name}"
    buttonclass = "ws_btn"

    if prop['focused']:
        buttonclass += " ws_focused"
    if prop['occupied']:
        buttonclass += " ws_occupied"
    if prop['thisscreen']:
        buttonclass += " ws_thisscreen"

    output += f'(button :onclick "{command}" :class "{buttonclass}" "")'
    # output += f'(button :onclick "{command}" :class "{buttonclass}" "{name}")'

output += ')'
print(output)
