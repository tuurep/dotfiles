#!/bin/bash

# A terrible hack (?) to use in .desktop files to set custom WM_CLASS
# For applications where customizing WM_CLASS is not simple

if [[ $# -ne 3 ]]; then
        echo "Usage: launch-and-change-wm-class <application> <old_WM_CLASS> <new_WM_CLASS>"
        exit 1
fi

$1 &
xdotool search --sync --class "$2" \
        set_window --class "$3" %@
