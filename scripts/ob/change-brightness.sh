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

# If brightness would go below 0, set 0% because attempting
# to set negative will not change brightness
# Going above 100 doesn't need this treatment, brightnessctl
# will set it at 100%
if [ $new_brightness -lt 0 ]; then
        brightnessctl s 0%
else
        brightnessctl s "$new_brightness"%
fi
