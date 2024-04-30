#!/bin/bash

# $1 is the input file
# $2 is the name you want to give to the output
# $3 the fps you want the output to have

if [ $# < 3 ]; then
    echo "Too few arguments!"
else
    ffmpeg -i "$1" -vf palettegen "palette.png" &&
    sleep 1
    ffmpeg -i "$1" -i "palette.png" -lavfi "paletteuse,fps=$3" "$2" &&
    echo "Completed!"
fi
