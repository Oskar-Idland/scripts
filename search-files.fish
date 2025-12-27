#!/usr/bin/fish
set -g quiet_mode false
set -g grep_args

function parse_quiet_flag
    
    # Manually parse arguments to extract -q
    for arg in $argv
        if string match -qr '^-.*q.*$' -- $arg
            set quiet_mode true
            # Remove 'q' from the flag string
            set -l new_arg (string replace --all 'q' '' -- $arg)
            # Only add if there are other flags left
            if test "$new_arg" != "-"
                set -a grep_args $new_arg
            end
        else
            set -a grep_args $arg
        end
    end
end

function search-files
    parse_quiet_flag $argv
    
    for file in *
        if test -f $file
            if test $quiet_mode = true
                set -l results (grep --color=always $grep_args $file)
                if test -n "$results"
                    set_color green ; echo $file ; set_color normal
                    printf '%s\n' $results
                end
            else
                set_color green ; echo $file ; set_color normal
                grep $grep_args $file
            end
        end
    end
end

# search-files $argv
