#!/usr/bin/fish

function search-folders
    # First apply on all files in the current folder
    set_color -ou blue ; printf "\n ./\n" ; set_color normal
    search-files $argv
    for folder in *
        if test -d $folder
            # Recursively search for files in the folder. If found, executes the search-files function
            set_color -ou blue ; printf "\n $folder\n" ; set_color normal
            cd $folder
            search-files $argv
            cd ..
        end 
    end
end
