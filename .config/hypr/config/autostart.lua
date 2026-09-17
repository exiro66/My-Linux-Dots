-- Auto-start config

hl.on("hyprland.start", function ()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("dbus-update-activation-environment --systemd QS_ICON_THEME=MacTahoe")
    hl.exec_cmd("systemctl --user start tide-island.service")
    hl.exec_cmd("systemctl --user start awww-daemon.service")
    hl.exec_cmd("hyprpm reload -n")
    hl.exec_cmd("dunst")
    hl.exec_cmd("sleep 1 && dunstctl set-paused true")
    hl.exec_cmd("xhost +SI:localuser:root")
end)
