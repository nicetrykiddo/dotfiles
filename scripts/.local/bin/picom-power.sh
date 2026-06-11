#!/bin/bash

set -euo pipefail

CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/laptop-power.conf"
[ -r "$CONFIG_FILE" ] && . "$CONFIG_FILE"

PICOM_FULL_CONFIG="${PICOM_FULL_CONFIG:-${XDG_CONFIG_HOME:-$HOME/.config}/picom.conf}"
PICOM_LIGHT_CONFIG="${PICOM_LIGHT_CONFIG:-${XDG_CONFIG_HOME:-$HOME/.config}/picom_noblur.conf}"
PICOM_AC_CONFIG="${PICOM_AC_CONFIG:-$PICOM_FULL_CONFIG}"
PICOM_BATTERY_CONFIG="${PICOM_BATTERY_CONFIG:-$PICOM_LIGHT_CONFIG}"

on_ac_power() {
	local supply

	for supply in /sys/class/power_supply/*; do
		[ -r "$supply/type" ] || continue
		[ "$(tr -d '\n' <"$supply/type")" = "Mains" ] || continue
		[ -r "$supply/online" ] || continue
		[ "$(tr -d '\n' <"$supply/online")" = "1" ] && return 0
	done

	return 1
}

if ! on_ac_power; then
	CONFIG="$PICOM_BATTERY_CONFIG"
else
	CONFIG="$PICOM_AC_CONFIG"
fi

[ -r "$CONFIG" ] || CONFIG="$PICOM_LIGHT_CONFIG"

pkill -x picom 2>/dev/null || true

export DISPLAY="${DISPLAY:-:0}"
export XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}"

exec picom --config "$CONFIG" -b
