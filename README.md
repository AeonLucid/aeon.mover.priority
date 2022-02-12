# Unraid Plugin - aeon.mover.priority

Small utility plugin for Unraid v6. This allows you to configure a CPU and IO priority for the mover process, to hopefully give other process higher priority to the array. 

Internally this uses [ionice](https://linux.die.net/man/1/ionice) and [nice](https://linux.die.net/man/1/nice) commands.

## Installation

You can install the plugin using this URL.

```
https://raw.githubusercontent.com/AeonLucid/aeon.mover.priority/master/plugins/aeon.mover.priority.plg
```

## Credits

Thanks to [hugenbd/ca.mover.tuning](https://github.com/hugenbd/ca.mover.tuning) created by Andrew Zawadzki and hugenbd.

This project is a fork and stripped down version, for those that don't need all the extra features.
