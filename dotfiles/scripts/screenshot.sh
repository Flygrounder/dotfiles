#!/bin/sh
DIR="$HOME/Images"
mkdir -p "$DIR"
NAME="$(date +'Screenshot_%Y-%m-%d_%H:%M:%S:%N.png')"
FULL="$DIR/$NAME"
scrot -F "$FULL"
xclip -sel clip -t image/png "$FULL"
dunstify "Скриншот сохранён в файл $FULL"
