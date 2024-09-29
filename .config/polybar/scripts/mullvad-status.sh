#!/bin/bash

# Must be same as polybar config's foreground-alt
foreground_alt=#808080

status=$(mullvad status)

if [[ "$status" == "Connected"* ]]; then
        country=$(echo "$status" | cut -d " " -f3 | cut -d "-" -f1)
        printf "%s" " $country"

elif [[ "$status" == "Connecting"* ]]; then
        echo " .."
else
        echo "%{F$foreground_alt} vpn%{F-}"
fi