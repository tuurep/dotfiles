#!/bin/bash

sink=0
interval=$1

# Pavucontrol graphical slider caps at 153 (%)
# Cap at 150 here (a nice round number)
upper_limit=150

current_volume=$(pactl get-sink-volume $sink | grep -Po '\d+(?=%)' | head -1)

if [ $((current_volume + interval)) -le $upper_limit ]; then
        pactl -- set-sink-volume $sink +"$interval"%
else
        pactl -- set-sink-volume $sink $upper_limit%
fi
