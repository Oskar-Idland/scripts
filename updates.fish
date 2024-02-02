function updates    

    set_color green
    echo "News:"
    set_color normal

    # Get and filter news
    pacnews -s desc | grep -i '^Title' -A 3 | tail -9 | while read -l title; read -l posted; read -l link; read -l text; read -l sepv;
        echo (string trim $title)
        set splitted (string split " " $posted)
        printf "$splitted[1..2] "
        set_color green
        printf "$splitted[3..5] "
        set_color normal
        echo "$splitted[6..-1]"
        echo (string trim $link)
        echo (string trim $text)
        printf "\n"

    end
    
    # Output Updates
    set_color green
    printf "Packages:\n"
    set_color normal
    checkupdates 

    set_color green
    printf "\nAUR:"
    yay -Qua
    
end
