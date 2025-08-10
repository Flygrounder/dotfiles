#!/usr/bin/env python3
import subprocess
import re

output = subprocess.check_output(["acpi", "-b"]).decode()
m = re.match(r'.*Discharging, (\d+)%', output)
if m is None:
    exit()
charge = int(m.group(1))
if charge <= 20:
    subprocess.run(["dunstify", "-u", "critical", f"Низкий уровень заряда: {charge}%"])
