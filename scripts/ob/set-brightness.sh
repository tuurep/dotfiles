#!/bin/bash

# This script is meant so that Polybar shows the
# brightness percentage in neat increments from 0-100
# when the raw value is 0-255 and using direct
# percentage increments/decrements with brightnessctl s
# will result in rounding errors without floating
# point arithmetic.

value=$1

# Get current brightness as percentage with -P flag
current_brightness=$(brightnessctl -P g)

brightnessctl s $((current_brightness + value))%
