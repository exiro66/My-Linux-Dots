local mod = "SUPER"

local terminal = "kitty"
local fileManager = "nautilus"
local browser = "zen-browser"

hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.kill())
hl.bind(mod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + SHIFT + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ state = 0 }))

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mod .. " + Left", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + Right", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + Up", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + Down", hl.dsp.focus({ direction = "d" }))

hl.bind(mod .. " + mouse_up", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ direction = "r" }))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = "r~" .. i }))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = "r~" .. i, follow = false }))
end

hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + S", hl.dsp.exec_cmd("~/.local/bin/rishot"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd("~/.local/bin/rishot monitor"))


hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind(mod .. " + A", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(mod .. " + C", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))

hl.bind(mod .. " + W", hl.dsp.exec_cmd("noctalia msg panel-toggle wallpaper"))

hl.bind(mod .. " + Space", function()
    local layouts = {"dwindle", "master", "scrolling", "monocle"}
    local current = hl.get_config("general:layout")
    for i, layout in ipairs(layouts) do
        if layout == current then
            hl.config({ general = { layout = layouts[i % #layouts + 1] } })
            break
        end
    end
end)

hl.bind(mod .. " + D", hl.dsp.exec_cmd("noctalia msg dock-toggle"))
hl.bind(mod .. " + Y", hl.dsp.exec_cmd("~/Applications/Glassy\\ Music-4.0.0.AppImage"))

hl.bind(mod .. " + SHIFT + W", hl.dsp.exec_cmd("noctalia msg desktop-widgets-toggle"))


hl.bind(mod .. " + N", hl.dsp.exec_cmd("~/.local/bin/toggle-noctalia-bar-float.fish"))
hl.bind(mod .. " + SHIFT + N", hl.dsp.exec_cmd("~/.local/bin/toggle-noctalia-dock-float.fish"))
