#!/usr/bin/fish

function search-folders
    for folder in *
        if test -d $folder
            set_color -ou blue ; printf "\n $folder\n" ; set_color normal
            cd $folder
            search-files $argv
            cd ..
        end 
    end
end
