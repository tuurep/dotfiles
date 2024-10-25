#!/bin/bash

# Must be same as polybar config's foreground-alt
foreground_alt=#808080

mullvad status listen | while read -r line; do
        country=$(mullvad relay get | sed -n "2p" | awk '{print $3}')

        case $line in
                "Connecting"|"Disconnecting")
                        echo " ..";;
                "Connected")
                        echo " $country";;
                "Disconnected")
                        echo "%{F$foreground_alt} vpn%{F-}";;
        esac
done
