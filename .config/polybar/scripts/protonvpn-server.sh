#!/bin/bash

# Get connected ProtonVPN server name with lowercased country id

nmcli --colors no -f name con show --active \
        | grep "ProtonVPN" \
        | cut -d " " -f2 \
        | tr "[:upper:]" "[:lower:]"
