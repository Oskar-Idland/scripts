#!/usr/bin/fish

function restore-links
    set conf_dir "$HOME/.config"
    set script_dir "$HOME/repos/scripts"
    set dots_dir "$HOME/repos/dotfiles"

    # Fish
    ## Config
    set_color green ; echo "Fish Config" ; set_color normal
    echo "Creating symlink: $conf_dir/fish/config.fish -> $dots_dir/config.fish"
    #rm $conf_dir/fish/config.fish
    ln -fs $dots_dir/config.fish $conf_dir/fish/config.fish

    ## Functions
    set_color green ; echo "Fish Functions" ; set_color normal
    for file in $script_dir/*.fish
        set name (string split "/" $file)[-1]
        echo "Creating symlink: ~/.config/fish/functions/$name -> $file"
        ln -fs $file $conf_dir/fish/functions/$name
    end

    # Kitty
    set_color green ; echo "Kitty Config" ; set_color normal
    echo "Creating symlink: $conf_dir/kitty/kitty.conf -> $dots_dir/kitty.conf"
    #rm $conf_dir/kitty/kitty.conf
    ln -fs $dots_dir/kitty.conf $conf_dir/kitty/kitty.conf

    # Neofetch
    set_color green ; echo "Neofetch Config" ; set_color normal
    echo "Creating symlink: $conf_dir/neofetch/config.conf -> $dots_dir/neofetch_config.conf"
    #rm $conf_dir/neofetch/config.conf
    ln -fs $dots_dir/neofetch_config.conf $conf_dir/neofetch/config.conf     

    # Waybar
    set_color green ; echo "Waybar Config" ; set_color normal
    ## Clock
    echo "Creating symlink: $conf_dir/waybar/modules/clock.jsonc -> $dots_dir/waybar_clock.jsonc"
    #rm $conf_dir/waybar/modules/clock.jsonc
    ln -fs $dots_dir/waybar_clock.jsonc $conf_dir/waybar/modules/clock.jsonc
end
