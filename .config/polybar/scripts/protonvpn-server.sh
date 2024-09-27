#!/bin/bash

# Must be same as polybar config's foreground-alt
foreground_alt=#808080

if pgrep -x openvpn > /dev/null; then
        # Get connected ProtonVPN server name with lowercased country id

        server=$(nmcli --colors no -f name con show --active \
                        | grep "ProtonVPN" \
                        | cut -d " " -f2 \
                        | tr "[:upper:]" "[:lower:]")

        echo " $server"
else
        echo "%{F$foreground_alt} vpn%{F-}"
fi
