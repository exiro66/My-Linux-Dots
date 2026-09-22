-- ============================================================
-- BINDS.LUA - Hyprland + NotchShell
-- ============================================================

local mod = "SUPER"

-- Apps
local terminal = "kitty"
local fileManager = "nautilus"
local browser = "zen-browser"

-- NotchShell IPC base (solo expone notch open/toggle/close y launcher apps/walls)
local qs = "qs ipc call"

-- ============================================================
-- VENTANAS
-- ============================================================

hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.kill())
hl.bind(mod .. " + SHIFT + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ state = 0 }))

-- Drag & resize con mouse
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ============================================================
-- NAVEGACIÓN ENTRE VENTANAS
-- ============================================================

hl.bind(mod .. " + Left", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + Right", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + Up", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + Down", hl.dsp.focus({ direction = "d" }))

hl.bind(mod .. " + mouse_up", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ direction = "r" }))

-- ============================================================
-- WORKSPACES
-- ============================================================

for i = 1, 10 do
	local key = i % 10
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = "r~" .. i }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = "r~" .. i, follow = false }))
end

-- ============================================================
-- APLICACIONES
-- ============================================================

hl.bind(mod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager))
-- Capturas con Ksnip (elige carpeta al guardar)
hl.bind(mod .. " + S", hl.dsp.exec_cmd("ksnip"))

-- ============================================================
-- TECLAS MULTIMEDIA (físicas)
-- ============================================================

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- ============================================================
-- NOTCHSHELL (notch + launchers)
-- launcher->apps, wallpaper->walls, centro->notch toggle.
-- Las páginas Audio, Bluetooth, Calendar, Network, Power, Notifications
-- y MediaCard viven dentro del Command Center.
-- ============================================================

-- Launcher apps
hl.bind(mod .. " + A", hl.dsp.exec_cmd(qs .. " launcher apps"))

-- Command Center toggle = lo que hacía SUPER+D (abre/cierra el centro)
hl.bind(mod .. " + C", hl.dsp.exec_cmd(qs .. " notch toggle"))

-- Recarga todo: quickshell + hyprland (script ~/.local/bin/notch-reload.sh)
hl.bind(mod .. " + ALT + R", hl.dsp.exec_cmd("sh /home/exiro/.local/bin/notch-reload.sh"))

-- Wallpaper picker
hl.bind(mod .. " + W", hl.dsp.exec_cmd(qs .. " launcher walls"))

-- Sin atajo directo (están dentro del Command Center con SUPER+C):
-- M player, N notificaciones, P power
-- hl.bind(mod .. " + O", ...) -- file shelf
-- hl.bind(mod .. " + SHIFT + R", ...) -- timer
-- hl.bind(mod .. " + SHIFT + W", ...) -- widgets
-- hl.bind(mod .. " + SHIFT + D", ...) -- dock
-- hl.bind(mod .. " + SHIFT + C", ...) -- weather
-- hl.bind(mod .. " + SHIFT + N", ...) -- calendario directo
-- hl.bind(mod .. " + U", ...) -- clipboard

-- Overview (todos los workspaces)
hl.bind("SUPER + Tab", function()
	hl.plugin.hyprexpo.expo("toggle")
end)

-- Bloqueo
hl.bind(mod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Cambio de workspace
hl.bind(mod .. " + SHIFT + Left", hl.dsp.exec_cmd("hyprctl dispatch workspace -1"))
hl.bind(mod .. " + SHIFT + Right", hl.dsp.exec_cmd("hyprctl dispatch workspace +1"))

-- ============================================================
-- HYPRLAND (layouts)
-- ============================================================

hl.bind(mod .. " + Space", function()
	local layouts = { "dwindle", "master", "scrolling", "monocle" }
	local current = hl.get_config("general:layout")
	for i, layout in ipairs(layouts) do
		if layout == current then
			hl.config({ general = { layout = layouts[i % #layouts + 1] } })
			break
		end
	end
end)
