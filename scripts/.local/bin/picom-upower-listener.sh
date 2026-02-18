#!/bin/bash

BAT="/org/freedesktop/UPower/devices/battery_BAT0"

upower --monitor-detail | while read -r line; do
  if echo "$line" | grep -q "$BAT"; then
    ~/.local/bin/picom-power.sh
  fi
done

