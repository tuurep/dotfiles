#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

polybar bar1 2>&1 & disown
