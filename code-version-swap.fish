#!/usr/bin/fish
function code-version-swap
    set lnk (readlink /usr/bin/code)
    set p     /usr/bin/code
    set p_old /usr/bin/code_old
    set p_new /usr/bin/code_new

    if [ "$lnk" = "$p_old" ]
        sudo ln -sf $p_new $p

    else if [ "$lnk" = "code_new" ]
        sudo ln -sf $p_old $p
    
    else
        sudo ln -sf $p_old $p
    end 

    echo "code  $(readlink $p)"
    echo (code -v)
end
