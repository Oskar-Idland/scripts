#!/usr/bin/fish

# Set the base directory to the current working directory
function gitcheck
    set base_directory (pwd)

    # Function to print colored text
    function echo_color
        switch $argv[1]
            case "green"
                echo -e (set_color green)$argv[2](set_color normal)
            case "yellow"
                echo -e (set_color yellow)$argv[2](set_color normal)
            case "red"
                echo -e (set_color red)$argv[2](set_color normal)
            case "*"
                echo $argv[2]
        end
    end

    # Function to translate Git status symbols
    function translate_git_status
        switch $argv[1]
            case "M"
                echo "Modified"
            case "A"
                echo "Added"
            case "D"
                echo "Deleted"
            case "R"
                echo "Renamed"
            case "??"
                echo "Untracked"
            case ""
                echo "No changes"
            case "*"
                echo "Unknown"
        end
    end

    # Function to check Git status
    function check_git_status
        set folder $argv[1]
        set relative_path (realpath --relative-to=$base_directory $folder)
        echo_color "white" "Git status for $relative_path:"
        cd $folder
        set git_status (git status --porcelain)
        set git_status_list (string split '\n' $git_status)
        set no_changes true
        set max_filename_length 0

        for file in $git_status_list
            set file_name (echo $file | awk '{$1=""; print $0}')
            if test -n "$file_name"
                set no_changes false
                set filename_length (string length $file_name)
                if test $filename_length -gt $max_filename_length
                    set max_filename_length $filename_length
                end
            end
        end

        if $no_changes
            echo_color "white" "No changes."
        else
            for file in $git_status_list
                set status_symbol (echo $file | awk '{print $1}')
                set translated_status (translate_git_status $status_symbol)
                set file_name (echo $file | awk '{$1=""; print $0}')
                if test -n "$file_name"
                    switch $status_symbol
                        case "A"
                            echo_color "green" (printf "%-12s %-s\n" "$translated_status:" "$file_name")
                        case "M" "R"
                            echo_color "yellow" (printf "%-12s %-s\n" "$translated_status:" "$file_name")
                        case "D" "??"
                            echo_color "red" (printf "%-12s %-s\n" "$translated_status:" "$file_name")
                        case "*"
                            echo_color "red" (printf "%-12s %-s\n" "$translated_status:" "$file_name")
                    end
                end
            end
        end

        cd $base_directory
        echo_color "*" "==============================="
    end


    # Check for repositories at one level deep
    for folder_level_1 in $base_directory/*
        if test -d $folder_level_1
            # Check if the directory contains a .git file
            if test -e $folder_level_1/.git
                check_git_status $folder_level_1
            end

            for folder_repo_1 in $folder_level_1/*
                if test -d $folder_repo_1
                    # Check if the directory contains a .git file
                    if test -e $folder_repo_1/.git
                        check_git_status $folder_repo_1
                    end
                end
            end
        end
    end
end
