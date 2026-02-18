#!/bin/bash

BAT="/org/freedesktop/UPower/devices/battery_BAT1"

STATE=$(upower -i "$BAT" | grep "state" | awk '{print $2}')

pkill picom

if [ "$STATE" = "discharging" ]; then
  # Power mode → blur OFF
  picom --config ~/.config/picom/picom-noblur.conf &
else
  # Charging / fully-charged → blur ON
  picom --config ~/.config/picom/picom-blur.conf &
fi

