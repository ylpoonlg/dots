import argparse
from libqtile.command.client import CommandClient

parser = argparse.ArgumentParser(description='Get layout')
parser.add_argument("--monitor", type=int, help="Current monitor")

args = parser.parse_args()

monitor = 0  # assume bar is displaying on monitor 0
if args.monitor:
    monitor = args.monitor

c = CommandClient()
for name, group in c.call('groups').items():
    if name == "scratchpad":
        continue
    if group['screen'] == monitor:
        print(group['layout'])
        exit(0)

print('Layout not found')
