#!/bin/sh
rm -rf ~/.config/nvim && ln -s $PWD/nvim ~/.config/nvim
rm -rf ~/.config/hypr && ln -s $PWD/hypr ~/.config/hypr
rm -rf ~/.config/rofi && ln -s $PWD/rofi ~/.config/rofi
rm -rf ~/.config/ghostty && ln -s $PWD/ghostty ~/.config/ghostty

mkdir -p ~/.config/fish
rm -rf ~/.config/fish/config.fish && ln -s $PWD/fish/config.fish ~/.config/fish/config.fish
rm -rf ~/.config/fish/themes && ln -s $PWD/fish/themes ~/.config/fish/themes

rm -rf ~/.config/waybar && ln -s $PWD/waybar ~/.config/waybar
rm -rf ~/.config/dunst && ln -s $PWD/dunst ~/.config/dunst
rm -rf ~/.config/yazi && ln -s $PWD/yazi ~/.config/yazi
