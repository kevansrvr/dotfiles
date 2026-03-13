#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using your config.ini
# We use "example" because that is the name of the [bar/example] section in your config
polybar example -c ~/.config/polybar/config.ini &
