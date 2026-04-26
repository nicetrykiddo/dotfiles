#!/bin/bash

set -euo pipefail

PROFILE_FILE="/sys/firmware/acpi/platform_profile"
PROFILE="balanced"

if [ -r "$PROFILE_FILE" ]; then
  PROFILE="$(tr -d '\n' < "$PROFILE_FILE")"
fi

case "$PROFILE" in
  low-power)
    CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/picom_noblur.conf"
    ;;
  *)
    CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/picom.conf"
    ;;
esac

pkill -x picom 2>/dev/null || true

export DISPLAY="${DISPLAY:-:0}"
export XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}"

exec picom --config "$CONFIG" -b
