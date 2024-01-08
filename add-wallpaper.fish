#!/usr/bin/fish
####################################################################################
# Functions which copies an image from the wallpaper folder into chosen theme folder
####################################################################################

function add-wallpaper
    set img "$argv[1]"
    set img_path "$HOME/Pictures/Wallpapers/"
    set theme_path "$HOME/.config/swww/"
    
    set -l options 
        for folder in $theme_path*
            echo $folder
            if test -d $folder
                set -a options (basename $folder)
            end
        end
        
    set selected (printf "%s\n" $options | fzf --prompt="Select an option: ")
    if test -n "$selected"
        clear
        cp $img_path$img $theme_path$selected/$img && 
        echo "Added" $img "to" $selected"-theme"
        
    else
        clear
        echo "No option selected."
    end
end
