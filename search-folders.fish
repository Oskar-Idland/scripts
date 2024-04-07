#!/usr/bin/fish

function search-folders
    for folder in *
        if test -d $folder
            set_color -ou blue ; echo " $folder" ; set_color normal
            cd $folder
            search-files $argv[1]
            cd ..
        end 
    end
end
