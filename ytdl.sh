#!/bin/bash

#
## Author: n00bady
## A simple bash script that adds some cover art in music that I downloaded from youtube
## Needs youtube-dl and the ogg-cover-art.sh script, also for covers is using an mpv screenshot named with a part of the
## youtubeurl.
#

#
## TODO: Some times video title with weird fonts or | , get saved with slightly different names and the ogg-cover-art
## script fails to find them beacause of this. Try and download a video from this channel:
## https://www.youtube.com/user/ThePrimeThanatos to see the bug.
#

Red='\033[0;31m'
Yellow='\033[1;33m'
NC='\033[0m'    # No Colour

# Print the title of the youtube video that going to be downloaded
title=$(youtube-dl -e "$1")
printf "Downloading $title"

youtube-dl $1
# Check if youtube-dl was successfull in downloading and converting the youtube video
if [ $? -ne 0 ]; then
    printf "${Red}FAILED!${NC} To download the youtube video!\n"
    exit 1
fi

# Screenshots are named after a part of the youtube url, like watch?v=0ITtEEsiINM, so I cut only that part of the
# supplied url and use it as a name to find and convert that screenshot and that screenshot only
yturl="$1"
ss_name="$(echo $yturl | cut -d'/' -f4)"
convert "$HOME/Pictures/mpv/$ss_name.png" "$HOME/Downloads/youtube-dl/$title.jpg"
cd $HOME/Downloads/youtube-dl/
$HOME/Documents/random_scripts/ogg-cover-art.sh "$title.jpg" "$title.ogg"
# Check if the previous command exited with error and if yes print a warning and exit
if [ $? -ne 0 ]; then
    printf "${Yellow}WARNING!${NC} Could not add cover image in the .ogg file for some reason ¯\_(ツ)_/¯ \n"
    exit 0
fi

# Delete the screenshot and the cover image
rm "$HOME/Pictures/mpv/$ss_name.png"
rm "$HOME/Downloads/youtube-dl/$title.jpg"

