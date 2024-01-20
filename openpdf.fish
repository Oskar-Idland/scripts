function openpdf
    if test -f $argv[1]
        nohup zathura $argv[1] > /dev/null 2>&1 &
        disown
        exit
    else 
        echo "No such pdf as '$argv[1]'"
    end 
end
