#!/usr/bin/fish
set name "add-wallpaper.fish"
set path "$HOME/.config/fish/functions/"
set func (string join \n '
#!/usr/bin/fish
####################################################################################
# Functions which copies an image from the wallpaper folder into chosen theme folder
####################################################################################

function add-wallpaper
    # set img "$argv[1]"
    set img_path "$HOME/Pictures/Wallpapers/"
    set theme_path "$HOME/.config/swww/"

    # Creating list of images to choose from
    set -l img_options
    for image in $img_path*.png $img_path*.jpg
        set -a img_options (basename  $image)
    end

    # Displaying list of images to choose from
    set img (printf "%s\n" $img_options | fzf --prompt="Select image: ")
    if test -n "$img"
        clear
    else
        clear
        echo "No image selected."
        exit 1
    end
    
    # Creating list of themes to choose from
    set -l theme_options 
    for folder in $theme_path*
        if test -d $folder
            set -a theme_options (basename $folder)
        end
    end

    # Displaying list of images to choose from
    set selected (printf "%s\n" $theme_options | fzf --prompt="Select an option: ")
    if test -n "$selected"
        clear
        cp $img_path$img $theme_path$selected/$img && 
        echo "Added" $img "to" $selected"-theme"
        
    else
        clear
        echo "No option selected."
    end
end
')
printf "%s\n" $func > $path$name
