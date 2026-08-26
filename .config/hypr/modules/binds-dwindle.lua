local mod = "SUPER"

hl.bind(mod .. " + Left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + Up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + Down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mod .. " + SHIFT + Left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + Right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + SHIFT + Up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + Down",  hl.dsp.window.move({ direction = "down" }))
