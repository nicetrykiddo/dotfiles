#!/bin/bash

set -euo pipefail

session_line="$(loginctl list-sessions --no-legend 2>/dev/null | awk '$3 != "" { print; exit }')"
[ -n "$session_line" ] || exit 0

session_id="$(awk '{print $1}' <<< "$session_line")"
session_user="$(awk '{print $3}' <<< "$session_line")"
[ -n "$session_id" ] || exit 0
[ -n "$session_user" ] || exit 0

session_type="$(loginctl show-session "$session_id" -p Type --value 2>/dev/null || true)"
[ "$session_type" = "x11" ] || exit 0

uid="$(id -u "$session_user")"
home="$(getent passwd "$session_user" | cut -d: -f6)"
[ -n "$home" ] || exit 0

exec runuser -u "$session_user" -- env \
  HOME="$home" \
  XDG_RUNTIME_DIR="/run/user/$uid" \
  DISPLAY=":0" \
  XAUTHORITY="$home/.Xauthority" \
  "$home/.local/bin/picom-power.sh"
