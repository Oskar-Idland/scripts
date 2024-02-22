#!/usr/bin/env fish
function print-colors
    # List of fish color variables
    set -l color_variables fish_color_autosuggestion fish_color_command fish_color_comment fish_color_cwd fish_color_cwd_root fish_color_end fish_color_error fish_color_escape fish_color_history_current fish_color_host fish_color_host_remote fish_color_match fish_color_normal fish_color_operator fish_color_param fish_color_quote fish_color_redirection fish_color_search_match fish_color_selection fish_color_status fish_color_user fish_color_user_root fish_pager_color_completion fish_pager_color_description fish_pager_color_prefix fish_pager_color_progress

    # Print each variable in its respective color
    for var in $color_variables
        if set -q $var
            echo -n (set_color $$var) $var (set_color normal)
            echo
        else
            echo " $var not set"
        end
    end
end
