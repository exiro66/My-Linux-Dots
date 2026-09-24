#!/bin/sh
# Recarga todo: reinicia quickshell (con el tema de iconos actual) + hyprland.
pkill -x quickshell
sleep 0.5
hyprctl reload config-only
mkdir -p /tmp/opencode
/home/exiro/.local/bin/notch-quickshell.sh >/tmp/opencode/notchshell.log 2>&1 &
echo $! > /tmp/opencode/notchshell-test.pid
