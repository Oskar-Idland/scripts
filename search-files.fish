#!/usr/bin/fish

function search-files
    set pattern $argv[1]
    for file in *
        if test -f $file
            set_color green ; echo  $file ; set_color normal
            grep $pattern $file
        end
    end
end
