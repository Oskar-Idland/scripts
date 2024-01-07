#!/bin/bash
##########################################
# Creates fish function in proper location
##########################################

name="kitty_reload.fish"
func_name="${name::-5}"
path="$HOME/.config/fish/functions/"
func="
function $func_name
    pkill -USR1 -f kitty
end
"
echo "$func" > $path$name
