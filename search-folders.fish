#!/usr/bin/fish

function search-folders
    # First apply on all files in the current folder
    set -l has_results (search-files $argv)
    if test -n "$has_results"
        set_color -ou blue ; printf "\n ./\n" ; set_color normal
        printf '%s\n' $has_results
    end
    
    for folder in *
        if test -d $folder
            cd $folder
            set -l has_results (search-files $argv)
            if test -n "$has_results"
                set_color -ou blue ; printf "\n $folder\n" ; set_color normal
                # printf '%s\n' $has_results
            end
            cd ..
        end 
    end
end
