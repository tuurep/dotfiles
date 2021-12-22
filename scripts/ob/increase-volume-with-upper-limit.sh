#!/bin/bash

sink=0
interval=$1

# Graphical volume sliders cap at 153%, follow suite here
upper_limit=153

current_volume=$(pactl get-sink-volume $sink | grep -Po '\d+(?=%)' | head -1)

if [ $((current_volume + interval)) -le $upper_limit ]
then
        pactl -- set-sink-volume $sink +"$interval"%
else
        pactl -- set-sink-volume $sink $upper_limit%
fi
