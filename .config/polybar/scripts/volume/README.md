# Polybar volume module with headphones icon

To make the headphones icon update instantly when devices are plugged/unplugged is quite hacky and has some additional dependencies. Here are notes on how I was able to make it work.

## 3.5mm jack headphones

Requirements for icon changing on plug/unplug event:
- [`acpid`](https://archlinux.org/packages/extra/x86_64/acpid/)
    - [Start/enable](https://wiki.archlinux.org/title/Help:Reading#Control_of_systemd_units) `acpid.service`

### `acpid` setup

`/etc/acpi/events/headphones`:

```
event=jack/headphone.*
action=sudo -u &lt;user&gt; /home/&lt;user&gt;/.config/polybar/scripts/volume/headphones-event-handler
```

## USB-C headphones

TODO

## Thanks

Looking at https://github.com/agrski/polybar-pipewire-wireplumber helped a lot in trying to make this module work.
