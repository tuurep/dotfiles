#!/bin/bash

# This script is meant so that Polybar shows the
# brightness percentage in neat increments from 0-100
# when the raw value is 0-255 and using direct
# percentage increments/decrements with brightnessctl s
# will result in rounding errors without floating
# point arithmetic.

# Change brightness by n (can be negative to decrease)
n=$1

# Get current brightness as percentage with -P flag
current_brightness=$(brightnessctl -P g)
new_brightness=$((current_brightness + n))

if [ $new_brightness -lt 0 ]; then
        new_brightness=0
elif [ $new_brightness -gt 100 ]; then
        new_brightness=100
fi

brightnessctl s "$new_brightness"%

# If window is fullscreen, show notification because
# Polybar is not visible
fullscreen=$(xprop -id "$(xdo id)" _NET_WM_STATE | grep _NET_WM_STATE_FULLSCREEN)

if [ -n "$fullscreen" ]; then
        notify-send -t 700 \
                    --hint=string:x-dunst-stack-tag:brightness \
                    "盛 $new_brightness"
fi
