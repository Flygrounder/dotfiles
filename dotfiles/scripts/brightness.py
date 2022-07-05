#!/usr/bin/env python
import os
import re
import subprocess

env = os.environ.copy()
env['LC_ALL'] = 'C'
result = subprocess.run(['light'], capture_output=True, text=True, env=env)
output = result.stdout.strip()

brightness = int(float(output))

icon = ""
if brightness >= 80:
    icon = ""
elif brightness >= 60:
    icon = ""
elif brightness >= 40:
    icon = ""
elif brightness >= 20:
    icon = ""
else:
    icon = ""

print(f"<fn=2>{icon}</fn> {brightness}%")
