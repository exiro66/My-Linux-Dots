-- Look and feel configuration

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 40,
        border_size = 1,
        extend_border_grab_area = 10,
        resize_on_border = true,
col = {
    active_border = {
        colors = { "rgba(a9b665ff)", "rgba(d4be98ff)" },
        angle = 45,
    },
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
        rounding = 10,
        blur = {
            brightness = 0.8,
            contrast = 2,
            noise = 0,
            vibrancy = 0.35,
            vibrancy_darkness = 0.35,
            enabled = true,
            size = 8,
            passes = 3,
            special = false,
            variant = "kawase",
        },
       shadow = {
    enabled = true,
    range = 5,
    render_power = 4,
    color = "rgba(00000088)",
},  
  },
})


