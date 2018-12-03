#!/bin/sh

slopoutput=$(slop -f "%x %y %w %h")
X=$(echo $slopoutput | awk '{print $1}')
Y=$(echo $slopoutput | awk '{print $2}')
W=$(($(echo $slopoutput | awk '{print $3}')/8))
H=$(($(echo $slopoutput | awk '{print $4}')/16))
# urxvt -g ${W}x${H}+${X}+${Y}
xfce4-terminal --geometry ${W}x${H}+${X}+${Y}