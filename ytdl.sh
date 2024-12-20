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
DIR="$HOME/Downloads/youtube-dl"
oggart="$HOME/Documents/gits/random_scripts/ogg-cover-art.sh"

if [[ -d "$DIR" ]]
then
  printf "${Green}%s exists.${NC}\n" "$DIR"
else
  printf "${Green}Creating %s ...${NC}\n" "$DIR"
  mkdir "$DIR"
fi

# Print the title of the youtube video that's going to be downloaded
title=$(yt-dlp --skip-download --get-title "$1")
printf "${Green}Downloading${NC} %s${Green}...${NC}\n" "$title"
# some unicode charachters are replaced e.g. Big Solidus is replaced with a regular slash
# while in -o flag when you use %(title) it come correctly as big solidus
# this behavious makes me wanna kill little puppies!

# Download the video and it's thumbnail(thumbnails get converting to jpg)
# yt-dlp --write-thumbnail --convert-thumbnails jpg $1
# Check if yt-dlp was successfull in downloading and converting the youtube video
if ! yt-dlp --write-thumbnail --convert-thumbnails jpg --extract-audio --audio-format vorbis --audio-quality 0 -o "$DIR/%(title)s.%(ext)s" "$1" ; then 
	printf "${Red}Failed!${NC} To download the youtube video!\n"
	exit 1
fi

# Add the thumbnail that we downloaded as a cover art with the help of ogg-cover-art.sh script
printf "${Green}Adding cover art...${NC}\n"
cd "$DIR/" || exit
# $oggart "$title.jpg" "$title.ogg"
# Check if it was successfull, if not then exit without deleting the thumbnail
# This will not work in some cases because as previously mentioned --get-title doesn't return all unicode chars intact
if ! "$oggart" "${title}.jpg" "${title}.ogg"; then
  printf "${Yellow}WARNING!${NC} Could not add cover image in the .ogg file for some reason ¯\_(ツ)_/¯ \n"
  printf "The downloaded thumbnail will be preserved in %s/%s.jpg\n" "$DIR" "$title"
  printf "${Yellow}Exiting...${NC}\n"
  exit 0  
fi

# Delete the thumbnail after successfully adding it as a cover art
printf "Deleting the thumbnail, it's not needed anymore...\n"
rm "$DIR/$title.jpg"

