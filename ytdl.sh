#!/bin/bash
#
## A simple bash script that adds some cover art in music that I downloaded from youtube
#  TODO: Need to find a way to match specific screenshots with the proper files.

title=$(youtube-dl -e "$1")
echo "Downloading $title"
youtube-dl $1
# Check if youtube-dl was successfull in downloading and converting the youtube video
if [ $? -ne 0 ]; then
    echo "FAILED!\n"
    exit 1
fi
# This requires that you have already took an screenshot(!only one if there are multiple .pngs in this folder it will
# convert them all!) through mpv for that video ! ! ! 
convert $HOME/Pictures/mpv/*.png $HOME/Downloads/youtube-dl/cover.jpg
cd $HOME/Downloads/youtube-dl/
$HOME/Documents/random_scripts/ogg-cover-art.sh "cover.jpg" "$title.ogg"

# This is not a good idea...
#rm $HOME/Pictures/mpv/*.png

rm $HOME/Downloads/youtube-dl/cover.jpg

