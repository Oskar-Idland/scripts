function cco
    echo $argv[1]
    echo $argv[2]
    colordiff -y -Z -W 70 --suppress-common-lines (eval $argv[1] | psub) (eval $argv[2] | psub)
end
