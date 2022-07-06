#!/usr/bin/env python
import sys
import os
import re
import subprocess
import dataclasses


@dataclasses.dataclass
class BatCheckResult:
    status: str
    charge: int
    left: str

    def format(self) -> str:
        icon = ""
        if self.status == "Charging":
            icon = ""
        elif self.charge >= 80:
            icon = ""
        elif self.charge >= 60:
            icon = ""
        elif self.charge >= 40:
            icon = ""
        elif self.charge >= 20:
            icon = ""
        else:
            icon = ""
        return f"<fn=2>{icon}</fn> {self.charge}%, {self.left}"

    def alert_on_low(self):
        if self.status == 'Discharging' and self.charge <= 10:
            subprocess.run(['dunstify', '-u', 'critical', 'Низкий уровень батареи, подсоедините зарядку'])


def check_bat() -> BatCheckResult:
    env = os.environ.copy()
    env['LC_ALL'] = 'C'
    result = subprocess.run(['acpi', '-b'], capture_output=True, text=True, env=env)
    output = result.stdout.strip()

    matches = re.fullmatch(r"Battery \d+: (?P<status>Discharging|Charging), (?P<charge>\d+)%, (?P<left>\d\d:\d\d):\d\d .+", output)
    if matches is None:
        raise IOError('Failed to get battery status')
    values = matches.groupdict()
    status = values.get("status")
    charge = int(values.get("charge"))
    left = values.get("left")
    return BatCheckResult(status=status, charge=charge, left=left)


HELP_TEXT = '''Usage: battery.py <mode>

Possible modes:
format - pretty-prints current battery status
alert - alerts if battery level is low'''


def main():
    if len(sys.argv) != 2:
        print(HELP_TEXT)
        exit(1)
    mode = sys.argv[1]
    if mode == 'format':
        print(check_bat().format())
    elif mode == 'alert':
        check_bat().alert_on_low()
    else:
        print(HELP_TEXT)
        exit(1)


if __name__ == '__main__':
    main()
