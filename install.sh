#!/bin/sh
rm -rf ~/.config/nvim && ln -s $PWD/nvim ~/.config/nvim
rm -rf ~/.config/hypr && ln -s $PWD/hypr ~/.config/hypr
touch ~/.config/hypr/local.conf
rm -rf ~/.config/rofi && ln -s $PWD/rofi ~/.config/rofi
rm -rf ~/.config/ghostty && ln -s $PWD/ghostty ~/.config/ghostty

mkdir -p ~/.config/fish
rm -rf ~/.config/fish/config.fish && ln -s $PWD/fish/config.fish ~/.config/fish/config.fish
rm -rf ~/.config/fish/themes && ln -s $PWD/fish/themes ~/.config/fish/themes

rm -rf ~/.config/waybar && ln -s $PWD/waybar ~/.config/waybar
rm -rf ~/.config/dunst && ln -s $PWD/dunst ~/.config/dunst
rm -rf ~/.config/yazi && ln -s $PWD/yazi ~/.config/yazi

mkdir -p ~/.local/bin
mkdir -p ~/.config/systemd/user.control
rm -rf ~/.local/bin/low-battery-notify.py && ln -s $PWD/low-battery-notify/low-battery-notify.py ~/.local/bin/low-battery-notify.py
rm -rf ~/.config/systemd/user.control/low-battery-notify.service && ln -s $PWD/low-battery-notify/low-battery-notify.service ~/.config/systemd/user.control/low-battery-notify.service
rm -rf ~/.config/systemd/user.control/low-battery-notify.timer && ln -s $PWD/low-battery-notify/low-battery-notify.timer ~/.config/systemd/user.control/low-battery-notify.timer
systemctl --user enable --now low-battery-notify.timer
