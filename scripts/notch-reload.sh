#!/bin/sh
# Recarga todo (prueba NotchShell): reinicia quickshell default + hyprland.
pkill -x quickshell
sleep 0.5
hyprctl reload config-only
quickshell >/tmp/opencode/notchshell.log 2>&1 &
echo $! > /tmp/opencode/notchshell-test.pid
