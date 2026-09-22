-- Autostart de Hyprland

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	-- NotchShell posee el bus de notificaciones: sin dunst (ver services/Notify.qml).
	hl.exec_cmd("sleep 2 && ~/.local/bin/wal-apply-all.fish")
	hl.exec_cmd("systemctl --user start awww-daemon")
	hl.exec_cmd("hyprsunset")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprpm reload")
	hl.exec_cmd("quickshell")
	hl.exec_cmd("dbus-update-activation-environment --systemd QS_ICON_THEME=MacTahoe-dark")
	hl.exec_cmd("xhost +SI:localuser:root")
end)
