#!/usr/bin/fish

function search-files
    for file in *
        if test -f $file
            set_color green ; echo  $file ; set_color normal
            grep $argv $file
        end
    end
end
