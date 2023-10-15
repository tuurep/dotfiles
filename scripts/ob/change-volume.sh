#!/bin/bash

# Change volume by n:
#       - can be negative to decrease
#       - or 0 to set volume at 0
n=$1

sink=0

# Pavucontrol graphical slider caps at 153 (%)
# Cap at 150 here (a nice round number)
upper_limit=150

current_volume=$(pactl get-sink-volume $sink | grep -Po '\d+(?=%)' | head -1)

new_volume=$((current_volume + n))

if [ "$1" == "0" ] || [ "$new_volume" -lt 0 ]; then
        new_volume=0
fi

if [ $new_volume -le $upper_limit ]; then
        pactl -- set-sink-volume $sink $new_volume%
else
        pactl -- set-sink-volume $sink $upper_limit%
        new_volume="$upper_limit"
fi

# If window is fullscreen, show notification because
# Polybar is not visible
fullscreen=$(xprop -id "$(xdo id)" _NET_WM_STATE | grep _NET_WM_STATE_FULLSCREEN)

if [ -n "$fullscreen" ]; then
        notify-send -t 700 \
                    --hint=string:x-dunst-stack-tag:volume \
                    "墳  $new_volume"
fi
