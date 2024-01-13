function openpdf
    if test -f $argv[1]
        open $argv[1] > /dev/null 2>&1
        return 0
    else 
        echo "No such pdf as '$argv[1]'"
    end 
end
