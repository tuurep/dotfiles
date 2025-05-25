# Polybar volume module with headphones icon

Notes on extra setup required for running a script on jack plug/unplug event.

## 3.5mm jack headphones

Requirements for icon changing on plug/unplug event:
- [`acpid`](https://archlinux.org/packages/extra/x86_64/acpid/)
    - [Start/enable](https://wiki.archlinux.org/title/Help:Reading#Control_of_systemd_units) `acpid.service`

### `acpid` setup

`/etc/acpi/events/headphones`:

```
event=jack/headphone.*
action=sudo -u username /home/username/.config/polybar/scripts/volume/acpi-handler
```

## Thanks

Looking at https://github.com/agrski/polybar-pipewire-wireplumber helped a lot in trying to make this module work.
