#!/usr/bin/fish

function restore-links
    set conf_dir "~/.config"
    set script_dir "~/repos/scripts"
    set dots_dir "~/repos/dotfiles"

    # Fish
    ## Config
    set_color green ; echo "Fish Config" ; set_color normal
    echo "Creating symlink: $conf_dir/config.fish -> ~$dots_dir/config.fish"
    rm ~/.config/fish/config.fish
    ln -s $dots_dir/config.fish $conf_dir/fish/config.fish

    ## Functions
    set_color green ; echo "Fish Functions" ; set_color normal
    for file in $script_dir/*.fish
        set name (string split "/" $file)[-1]
        echo "Creating symlink: ~/.config/fish/functions/$name -> $file"
        ln -s $file $conf_dir/fish/functions/$name

    # Kitty
    set_color green ; echo "Kitty Config" set_color normal ;
    echo "Creating symlink: $conf_dir/kitty/kitty.conf -> $dots_dir/kitty.conf"
    rm $conf_dir/kitty/kitty.conf
    ln -s $dots_dir/kitty.conf $conf_dir/kitty/kitty.conf

    # Neofetch
    set_color green ; echo "Neofetch Config" set_color normal ;
    echo "Creating symlink: $conf_dir/neofetch/config.conf -> $dots_dir/neofetch_config.conf"
    ln -s $dots_dir/neofetch_config.conf $conf_dir/neofetch/config.conf     
end
