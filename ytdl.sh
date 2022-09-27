#!/bin/bash

#
## Author: n00bady
## A simple bash script that adds some cover art in music that I downloaded from youtube
## Needs yt-dlp and the ogg-cover-art.sh script.
## For cover art it downloads seperatelly the youtube thumbnail and then adds in the the 
## .ogg file with the help of the ogg-cover-art.sh script.
#

#
## TODO: Some times video title with weird fonts or | , get saved with slightly different 
## names and the ogg-cover-art script fails to find them beacause of this. Try and 
## download a video from this channel: https://www.youtube.com/user/ThePrimeThanatos to see the bug.
#

Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[1;33m'
NC='\033[0m'    # Reset Color

# Print the title of the youtube video that's going to be downloaded
title=$(yt-dlp --skip-download --get-title "$1")
printf "${Green}Downloading${NC} $title${Geen}...${NC}\n"

# Download the video and it's thumbnail(thumbnails get converting to jpg)
yt-dlp --write-thumbnail --convert-thumbnails jpg $1
# Check if yt-dlp was successfull in downloading and converting the youtube video
if [ $? -ne 0 ]; then
    printf "${Red}FAILED!${NC} To download the youtube video!\n"
    exit 1
fi

# Add the thumbnail that we downloaded as a cover art with the help of ogg-cover-art.sh script
printf "${Green}Adding cover art...${NC}\n"
cd $HOME/Downloads/youtube-dl/
$HOME/Documents/random_scripts/ogg-cover-art.sh "$title.jpg" "$title.ogg"
# Check if it was successfull, if not then exit without deleting the thumbnail
if [ $? -ne 0 ]; then
  printf "${Yellow}WARNING!${NC} Could not add cover image in the .ogg file for some reason ¯\_(ツ)_/¯ \n"
  printf "The downloaded thumbnail will be preserved in $HOME/Downloads/youtube-dl/$title.jpg\n"
  printf "${Yellow}Exiting...${NC}\n"
  exit 0
fi

# Delete the thumbnail after successfully adding it as a cover art
printf "Deleting the thumbnail, it's not needed anymore...\n"
rm "$HOME/Downloads/youtube-dl/$title.jpg"

### old code
# Screenshots are named after a part of the youtube url, like watch?v=0ITtEEsiINM, so I cut only that part of the
# supplied url and use it as a name to find and convert that screenshot and that screenshot only
# yturl="$1"
# ss_name="$(echo $yturl | cut -d'/' -f4)"
# convert "$HOME/Pictures/mpv/$ss_name.png" "$HOME/Downloads/youtube-dl/$title.jpg"
# cd $HOME/Downloads/youtube-dl/
# $HOME/Documents/random_scripts/ogg-cover-art.sh "$title.jpg" "$title.ogg"
# # Check if the previous command exited with error and if yes print a warning and exit
# if [ $? -ne 0 ]; then
#     printf "${Yellow}WARNING!${NC} Could not add cover image in the .ogg file for some reason ¯\_(ツ)_/¯ \n"
#     exit 0
# fi
#
# # Delete the screenshot and the cover image
# rm "$HOME/Pictures/mpv/$ss_name.png"
# rm "$HOME/Downloads/youtube-dl/$title.jpg"

