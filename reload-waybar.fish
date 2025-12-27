##################
# Reloads waybar #
##################

function reload-waybar
    pkill waybar & hyprctl dispatch exec waybar
end
