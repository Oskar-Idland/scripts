#########################
# Reloads waybar config
#########################

function reload-waybar
    killall -SIGUSR2 waybar
end
