function upd
    # Color definitions
    set main_color  "brcyan"
    set date_color  "brmagenta"
    set link_color  "blue"    
    set error_color "red"

    # News Header
    set_color $main_color ; echo "News:" ; set_color normal

    # Assigning as mulitilne string ensures newlines come along
    # Redirecting erros to handle it myself
    set news """$(pacnews -s desc 2>&1)"""
    
    # Common error from pacnews if called too often
    set error "Error: InvalidStartTag" 
    if test "$news" = "$error"
        set_color $error_color
        printf "Pacnews could not fetch news\n" 
        printf "Check connection, try again in few seconds or see link: "
        set_color $link_color
        echo -e "https://archlinux.org/news/"
        printf "\n\n"
        set_color normal

    else  
        # Filter news
        echo "$news" | grep  '^Title' -A 3 | tail -9 | 
        while read -l title; read -l posted; read -l link; read -l text; read -l sepv;
            echo "$title"
            
            set posted_list (string split " " $posted)
            printf "$posted_list[1..2] "
            set_color -o $date_color 
            printf "$posted_list[3..5] " # Extract and color date
            set_color normal 
            echo "$posted_list[6..-1]"
            
            set link_list (string split " " $link)
            printf "$link_list[1] "
            set_color $link_color 
            printf "$link_list[2]\n" # Extract and color link 
            set_color normal 

            echo (string trim $text)
            printf "\n"
        end
    end
    
    # Pacman updates
    set_color $main_color ; printf "PACMAN:\n" ; set_color normal
    checkupdates 

    # AUR updates
    set_color $main_color ; printf "\nAUR:\n" ; set_color normal
    yay -Qua
end
