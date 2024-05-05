#!/usr/bin/fish
function code-version-swap
    set lnk (readlink /usr/bin/code)

    if [ "$lnk" = "code_old" ]
        sudo ln -sf code_new code
    end

    if [ "$lnk" = "code_new" ]
        sudo ln -sf code_old code
    end

    echo code  (readlink code)
    echo (code -v)
end
