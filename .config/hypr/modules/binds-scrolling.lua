local mod = "SUPER"

hl.bind(mod .. " + Left",  hl.dsp.layout("focus l"))
hl.bind(mod .. " + Right", hl.dsp.layout("focus r"))
hl.bind(mod .. " + Up",    hl.dsp.layout("focus u"))
hl.bind(mod .. " + Down",  hl.dsp.layout("focus d"))

hl.bind(mod .. " + SHIFT + Left",  hl.dsp.layout("swapcol l"))
hl.bind(mod .. " + SHIFT + Right", hl.dsp.layout("swapcol r"))
hl.bind(mod .. " + SHIFT + Up",    hl.dsp.layout("consume_or_expel next"))
hl.bind(mod .. " + SHIFT + Down",  hl.dsp.layout("consume_or_expel prev"))

