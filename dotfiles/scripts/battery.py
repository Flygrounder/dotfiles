#!/usr/bin/env python
import os
import re
import subprocess


def format_bat(icon: str, charge: str, left: str) -> str:
    return f"<fn=2>{icon}</fn> {charge}%, {left}"


env = os.environ.copy()
env['LC_ALL'] = 'C'
result = subprocess.run(['acpi', '-b'], capture_output=True, text=True, env=env)
output = result.stdout.strip()

matches = re.fullmatch(r"Battery \d+: (?P<status>Discharging|Charging), (?P<charge>\d+)%, (?P<left>\d\d:\d\d):\d\d .+", output)
values = matches.groupdict()
status = values.get("status")
charge = int(values.get("charge"))
left = values.get("left")

icon = ""
if status == "Charging":
    icon = ""
elif charge >= 80:
    icon = ""
elif charge >= 60:
    icon = ""
elif charge >= 40:
    icon = ""
elif charge >= 20:
    icon = ""
else:
    icon = ""

print(format_bat(icon, charge, left))
