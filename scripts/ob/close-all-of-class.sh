#!/bin/bash

active_window=$(xdo id)
active_class=$(xdotool getwindowclassname "$active_window")

# Steam doesn't exit cleanly
if [ "$active_class" == "steam" ]; then
        steam -shutdown
else
        xdo close -dc
fi
