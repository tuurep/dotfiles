#!/bin/bash

active_protonvpn_con=$(nmcli --colors no -f name con show --active | grep "ProtonVPN")

if [[ -n "$active_protonvpn_con" ]]; then
        # Server name lowercased
        echo "$active_protonvpn_con" | cut -d " " -f2 | tr "[:upper:]" "[:lower:]"
else
        # Module goes away when VPN isn't on
        echo ""
fi
