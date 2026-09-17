-- Look and feel configuration

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 40,
        border_size = 0,
        extend_border_grab_area = 10,
        resize_on_border = true,
        col = {
            active_border = { colors = { "rgba(a9b665ff)", "rgba(d4be98ff)" }, angle = 45 },
            inactive_border = "rgba(00000000)",
        },
    },
    group = {
        col = {
            border_active = "rgba(a9b665ff)",
            border_inactive = "rgba(665c54ff)",
            border_locked_active = "rgba(d4be98ff)",
            border_locked_inactive = "rgba(665c54ff)",
        },
        groupbar = {
            col = {
                active = "rgba(a9b665ff)",
                inactive = "rgba(665c54ff)",
                locked_active = "rgba(d4be98ff)",
                locked_inactive = "rgba(665c54ff)",
            },
        },
    },
    decoration = {
        dim_special = 0.3,
        rounding = 30,
        rounding_power = 3,
        blur = {
            enabled = true,
            size = 6,
            passes = 3,
            brightness = 0.9,
            contrast = 2.0,
            noise = 0.03,
            vibrancy = 0.5,
            vibrancy_darkness = 0.5,
            special = false,
        },
        shadow = {
            enabled = true,
            range = 15,
            render_power = 4,
            color = "rgba(000000aa)",
        },
    },
})

hl.config({
    plugin = {
        hyprglass = {
            enabled = true,
            default_preset = "glass",
            glass_opacity = 0.75,
            blur_strength = 1.6,
            refraction_strength = 0.10,
            chromatic_aberration = 0.020,
            fresnel_strength = 0.6,
            specular_strength = 0.4,
            brightness = 1.05,
            contrast = 1.0,
            saturation = 1.15,
            vibrancy = 0.5,
            vibrancy_darkness = 0.5,

layers = {
    enabled = false,
    namespaces = "quickshell",
},

        },
    },
})
