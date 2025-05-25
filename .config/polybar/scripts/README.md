# Polybar custom modules and scripts

Extra setup needed for the `battery` module (which is adapted from [`battery-combined-udev`](https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/battery-combined-udev)).

To have the module updated on charger plug/unplug, add this udev rule:

`/etc/udev/rules.d/battery.rules`

```
SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="0", \
    RUN+="/home/username/.config/polybar/scripts/battery --update"
SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="1", \
    RUN+="/home/username/.config/polybar/scripts/battery --update"
```
