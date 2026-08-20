#!/usr/bin/env fish

##################
# Reloads waybar #
##################

function rl-waybar
    pkill waybar & hyprctl dispatch exec waybar
end
