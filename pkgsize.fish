#!/usr/bin/env fish

function pkgsize
    # Parse args, and check for positive, non-zero integer and valid filename
    argparse 'n/num=!_validate_int --min 1' \
             'f/file=!string match -rqi "^[a-å].*" "$_flag_value" || print_error' -- $argv
    or return 1

    # If the flags are set, assign them to variables, else assign default values
    if set -q _flag_f
        set location $_flag_f
    else
        set location (mktemp)
    end
    
    if set -q _flag_n
        set num $_flag_n
    else
        set num 10
    end
    
    # Only add relevant number of lines
    set tmp (mktemp)
    pkgsizes.py > $tmp 2> /dev/null 
    head -n(math $num +1) $tmp > $location
    
    # Print the table
    cat $location | tail -n +2 | nl | column -t -N "#,Name,Installed_Size,Depends_On,Full_Size,Used_By,Shared_Size,Relative_Size" -R "1,3,4,5,6,7,8" -H '8' -W "2"
end

function print_error
    echo "pgksize: Value '$_flag_value' for flag 'f' must begin with a letter a-å" >&2
    return 1
end

# Tests

#pkgsize -n 2 -f testname
#pkgsize --num 5
#pkgsize --file testname2
#pkgsize -f 20
#pkgsize -n testname3