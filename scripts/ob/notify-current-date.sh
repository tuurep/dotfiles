#!/bin/bash

notify-send -t 3000 \
            -c hack_font \
            "$(date +%-d.%-m.)" "$(date +%A)"
