#!/usr/bin/fish
####################################################################################
# Functions which copies an image from the wallpaper folder into chosen theme folder
####################################################################################

function add-wallpaper
    # set img "$argv[1]"
    set img_path "$HOME/Pictures/Wallpapers/"
    set theme_path "$HOME/.config/hyde/themes/"

    # Creating list of images to choose from
    set -l img_options
    for image in $img_path*.png $img_path*.jpg $img_path*.gif
        set -a img_options (basename  $image)
    end

    # Displaying list of images to choose from
    set img (printf "%s\n" $img_options | fzf  --height=25% --layout=reverse --border --prompt="Select image: ")
    if test -n "$img"
    else
        clear
        echo "No image selected."
        return
    end
    
    # Creating list of themes to choose from
    set -l theme_options 
    for folder in $theme_path*
        if test -d $folder
            set -a theme_options (basename $folder)
        end
    end

    # Displaying list of images to choose from
    set selected (printf "%s\n" $theme_options | fzf --height=25% --layout=reverse --border  --prompt="Select an option: ")
    if test -n "$selected"
        clear
        cp $img_path$img $theme_path$selected/wallpapers/$img && 
        echo "Added" $img "to" $selected"-theme"
        return
        
    else
        clear
        echo "No option selected."
        return
    end
end

