#!bin/bash
function choose_from_menu() {
	img="$1"
	echo $img
    local prompt="$2" outvar="$3"
    shift
    shift
    local options=(
    "Catppuccin-Mocha" 
    "Graphite-Mono"    
    "Tokyo-Night"  
    "Rose-Pine"
    "Gruvbox-Retro"       
    "Material-Sakura"  
    "Decay-Green"       
    "Cyberpunk-Edge"    
    "Frosted-Glass"   
    "Catppuccin-Latte"  
    )
    local  cur=0 count=${#options[@]} index=0
    local esc=$(echo -en "\e") # cache ESC as test doesn't allow esc codes
    printf "$prompt\n"
    while true
    do
        # list all options (option list is zero-based)
        index=0
        for o in "${options[@]}"
        do     	
            if [ "$index" == "$cur" ]
            then echo -e " >\e[7m$o\e[0m" # mark & highlight the current option
            else echo "  $o"
            fi
            index=$(( $index + 1 ))
        done
        read -s -n3 key # wait for user to key in arrows or ENTER
        if [[ $key == $esc[A ]] # up arrow
        then cur=$(( $cur - 1 ))
            [ "$cur" -lt 0 ] && cur=0
        elif [[ $key == $esc[B ]] # down arrow
        then cur=$(( $cur + 1 ))
            [ "$cur" -ge $count ] && cur=$(( $count - 1 ))
        elif [[ $key == "" ]] # nothing, i.e the read delimiter - ENTER
        then break
        fi
        echo -en "\e[${count}A" # go up to the beginning to re-render
    done
    # export the selection to the requested output variable
	cp "$HOME/Pictures/Wallpapers/$img" "$HOME/.config/swww/${options[$cur]}/$img"
    #printf -v $outvar "$HOME/.config/swww/${options[$cur]}"
}


choose_from_menu $1 "Choose Theme to put $1:" selected_choice
echo "$selected_choice"
