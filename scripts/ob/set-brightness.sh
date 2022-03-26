#!/bin/bash

value=$1

# Get current brightness as percentage with -P flag
current_brightness=$(brightnessctl -P g)
new_brightness=$((current_brightness + value))

# Don't allow going to 0 because screen will be literally black
# Note: would be possible to set minimum value within brightnessctl maybe
# but hey, if it works, it works!
if [ $new_brightness -gt 0 ]
then
        brightnessctl s "$new_brightness"%
else
        brightnessctl s 1%
fi
