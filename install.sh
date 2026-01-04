#!/usr/bin/env bash

create_link () {
	from=$1
	to=$2
	rm -rf $to && ln -s $from $to
}

create_link $PWD/hypr ~/.config/hypr
touch ~/.config/hypr/local.conf

create_link $PWD/rofi ~/.config/rofi

create_link $PWD/ghostty ~/.config/ghostty

mkdir -p ~/.config/fish
create_link $PWD/fish/config.fish ~/.config/fish/config.fish
create_link $PWD/fish/themes ~/.config/fish/themes

create_link $PWD/waybar ~/.config/waybar
if [ ! -e ~/.config/waybar/local.json ]; then
  echo "{}" > ~/.config/waybar/local.json
fi

create_link $PWD/dunst ~/.config/dunst

mkdir -p ~/.local/scripts
create_link $PWD/low-battery-notify/low-battery-notify.py ~/.local/scripts/low-battery-notify.py
mkdir -p ~/.config/systemd/user.control
create_link $PWD/low-battery-notify/low-battery-notify.service ~/.config/systemd/user.control/low-battery-notify.service
create_link $PWD/low-battery-notify/low-battery-notify.timer ~/.config/systemd/user.control/low-battery-notify.timer
systemctl --user enable --now low-battery-notify.timer
