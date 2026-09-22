-- Variables de entorno

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Tema Qt (apps Qt)
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- Firefox/Zen en Wayland nativo
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- Electron apps en Wayland
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- XDG
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")


hl.env("RISHOT_SAVEDIR", os.getenv("HOME") .. "/Imágenes/Screenshots")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QS_ICON_THEME", "MacTahoe-dark")
