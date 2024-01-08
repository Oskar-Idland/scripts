#!/usr/bin/fish
####################################################################################
# Functions which copies an image from the wallpaper folder into chosen theme folder
####################################################################################

function add-wallpaper
    set img "$argv[1]"
    set img_path "$HOME/Pictures/Wallpapers/"
    
    set options "Catppuccin-Mocha" \
                "Graphite-Mono" \
                "Tokyo-Night" \
                "Rose-Pine" \
                "Gruvbox-Retro" \
                "Material-Sakura" \
                "Decay-Green" \
                "Cyberpunk-Edge" \
                "Frosted-Glass" \
                "Catppuccin-Latte"
    set selected (printf "%s\n" $options | fzf --prompt="Select an option: ")
    if test -n "$selected"
        clear
        cp $img_path$img $HOME/.config/swww/$selected/$img && 
        echo "Added" $img "to" $selected"-theme"
        
    else
        clear
        echo "No option selected."
    end
end
