#!/bin/bash

active_window=$(xdo id)
active_class=$(xdotool getwindowclassname "$active_window")

# Steam will leave only the main client window open
if [ "$active_class" == "steam" ]; then
        for w in $(xdo id -dN "$active_class"); do
                w_title=$(xdotool getwindowname "$w")
                if [ "$w_title" != "Steam" ]; then
                        xdo close "$w"
                fi
        done
        exit 0
fi

# For any other application, close all windows except active
for w in $(xdo id -dN "$active_class"); do
        if [ "$w" != "$active_window" ]; then
                xdo close "$w"
        fi
done
