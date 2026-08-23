local mod = "SUPER"

hl.bind(mod .. " + SHIFT + Q",         hl.dsp.window.kill())
hl.bind(mod .. " + T",    hl.dsp.exec_cmd("ghostty"))
hl.bind(mod .. " + F",         hl.dsp.window.fullscreen())
hl.bind(mod .. " + E",         hl.dsp.exec_cmd("nautilus"))
hl.bind(mod .. " + SHIFT + T",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + M",         hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/minimize-toggle.sh"))
hl.bind(mod .. " + SHIFT + M", hl.dsp.workspace.toggle_special("minimized"))

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mod .. " + Left",       hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mod .. " + Right",      hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "r+1" }))

hl.bind(mod .. " + 1", hl.dsp.focus({ workspace = "r~1" }))
hl.bind(mod .. " + 2", hl.dsp.focus({ workspace = "r~2" }))
hl.bind(mod .. " + 3", hl.dsp.focus({ workspace = "r~3" }))
hl.bind(mod .. " + 4", hl.dsp.focus({ workspace = "r~4" }))
hl.bind(mod .. " + 5", hl.dsp.focus({ workspace = "r~5" }))
hl.bind(mod .. " + 6", hl.dsp.focus({ workspace = "r~6" }))
hl.bind(mod .. " + 7", hl.dsp.focus({ workspace = "r~7" }))
hl.bind(mod .. " + 8", hl.dsp.focus({ workspace = "r~8" }))
hl.bind(mod .. " + 9", hl.dsp.focus({ workspace = "r~9" }))
hl.bind(mod .. " + 0", hl.dsp.focus({ workspace = "r~10" }))

hl.bind(mod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = "r~1", follow = false }))
hl.bind(mod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = "r~2", follow = false }))
hl.bind(mod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = "r~3", follow = false }))
hl.bind(mod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = "r~4", follow = false }))
hl.bind(mod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = "r~5", follow = false }))
hl.bind(mod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = "r~6", follow = false }))
hl.bind(mod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = "r~7", follow = false }))
hl.bind(mod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = "r~8", follow = false }))
hl.bind(mod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = "r~9", follow = false }))
hl.bind(mod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "r~10", follow = false }))



hl.bind(mod .. " + A",      hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/open-surface.sh launcher"))
hl.bind(mod .. " + V",          hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/open-surface.sh clipboard"))

hl.bind(mod .. " + L",          hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/lock.sh"))

hl.bind(mod .. " + SHIFT + W",          hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/wallpaper.sh"))
hl.bind(mod .. " + W",          hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/open-surface.sh wallpaper"))
hl.bind(mod .. " + R",          hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/record.sh"))
hl.bind(mod .. " + G",          hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/open-surface.sh gameMode"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay",        hl.dsp.global("quickshell:mediaToggle"),                           { locked = true })
hl.bind("XF86AudioNext",        hl.dsp.global("quickshell:mediaNext"),                             { locked = true })
hl.bind("XF86AudioPrev",        hl.dsp.global("quickshell:mediaPrev"),                             { locked = true })
hl.bind(mod .. " + Q",                 hl.dsp.window.close())
hl.bind(mod .. " + S", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/rishot"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/rishot monitor"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd("zen-browser")) -- Zen Browser
hl.bind(mod .. " + D", hl.dsp.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark" && echo dark > ~/.cache/ricelin/notch-mode'))
hl.bind(mod .. " + C", hl.dsp.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-light" && echo light > ~/.cache/ricelin/notch-mode'))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("fish -c toggle-pill-mode"))
