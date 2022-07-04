#!/usr/bin/env python
import os
import re
import subprocess

env = os.environ.copy()
env['LC_ALL'] = 'C'

result = subprocess.run(['pactl', 'get-sink-mute', '@DEFAULT_SINK@'], capture_output=True, text=True, env=env)
output = result.stdout
muted = output.strip() == "Mute: yes"

if muted:
    print("<fn=2></fn>")
    exit(0)

result = subprocess.run(['pactl', 'get-sink-volume', '@DEFAULT_SINK@'], capture_output=True, text=True, env=env)
output = result.stdout
volume = int(re.findall(r"\d+%", output)[0][:-1])

icon = ""
if volume >= 50:
    icon = ""
elif volume > 0:
    icon = ""
else:
    icon = ""
print(f"<fn=2>{icon}</fn> {volume}%")
