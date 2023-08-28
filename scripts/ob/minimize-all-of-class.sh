#!/bin/bash

active_window=$(xdo id)
active_class=$(xdotool getwindowclassname "$active_window")

for w in $(xdo id -dN "$active_class"); do
        xdotool windowminimize "$w"
done
