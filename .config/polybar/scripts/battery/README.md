# Polybar battery module

Module update on charger connect/disconnect:

`/etc/udev/rules.d/battery.rules`:

```
SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="0", \
    RUN+="/home/username/.config/polybar/scripts/battery/main --update"
SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="1", \
    RUN+="/home/username/.config/polybar/scripts/battery/main --update"
```

To reload udev rules:

`sudo udevadm control --reload && sudo udevadm trigger`
