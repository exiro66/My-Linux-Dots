-- Default curves and animations

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
hl.curve("overshoot",      { type = "bezier", points = { {0.5, 0.9},   {0.1, 1.1}   } })
hl.curve("smooth",         { type = "bezier", points = { {0.22, 0.9},  {0.25, 1}    } })
hl.curve("gentle",         { type = "bezier", points = { {0.4, 0.1},   {0.2, 1}     } })

hl.curve("easy",           { type = "spring", mass = 1, stiffness = 300, dampening = 25 })
hl.curve("rubber",         { type = "spring", mass = 1, stiffness = 150, dampening = 12 })

hl.animation({ leaf = "global",              enabled = true, speed = 4.5, bezier = "smooth" })
hl.animation({ leaf = "windows",             enabled = true, speed = 4.5, spring = "easy", style = "slide" })
hl.animation({ leaf = "workspaces",          enabled = true, speed = 5.5, bezier = "gentle", style = "slide" })
hl.animation({ leaf = "specialWorkspaceIn",  enabled = true, speed = 5.0, bezier = "smooth", style = "slide top" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 5.0, bezier = "gentle", style = "slide bottom" })
