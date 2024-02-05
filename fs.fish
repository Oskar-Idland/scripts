#!/usr/bin/fish

### Folder Status  ###

# Gets the status of all git repos 1 and 2 levels depp
function fs
    set base_directory (pwd) # Begin searching from where the command was called
    set depht 3              # How many levels deep to search for repos
    
    loop_and_check $base_directory $depht 
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


# Function to loop over folders and check Git status
function loop_and_check
    set current_folder $argv[1]
    set depth $argv[2]
    for folder in $current_folder/*
        if test -d $folder -a -e $folder/.git
            check_git_status $folder
        end
    end

    if test $depth -gt 1
        for folder_level_1 in $current_folder/*
            if test -d $folder_level_1
                loop_and_check $folder_level_1 (math $depth - 1)
            end
        end
    end
end


# Function to check Git status
function check_git_status
    set folder $argv[1]
    set relative_path_untrimmed (realpath --relative-to=$base_directory $folder)
    set relative_path (string replace -a "/home/$USER" "~" $relative_path_untrimmed)
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
    echo_color "*" "==========="
end


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
