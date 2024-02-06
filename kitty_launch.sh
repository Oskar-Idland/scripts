#!/bin/bash

# Calculate the width and height of the terminal window
width=$(tput cols)
height=$(tput lines)

# Check if width is larger than height
if [ $width -gt $height ]; then
    font_size=$((height / 10))
else
    font_size=$((width / 10))
fi


# Launch Kitty with the calculated font size
kitty -o font_size=$font_size
