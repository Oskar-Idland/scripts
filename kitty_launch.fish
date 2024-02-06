#!/usr/bin/fish
set height tput lines
set size (math $height)

kitty -o font_size=12
