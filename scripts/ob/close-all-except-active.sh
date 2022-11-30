#!/bin/bash

active_window=$(xdotool getactivewindow)
desktop=$(xdotool get_desktop)

for w in $(xdotool search --all --desktop $desktop --name ".*"); do
        if [ $w -ne $active_window ] ; then
                xdotool windowquit "$w"
        fi
done
