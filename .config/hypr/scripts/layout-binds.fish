#!/usr/bin/fish
set action $argv[1]
set dir $argv[2]

set layout (hyprctl getoption general:layout -j | jq -r '.str')

switch "$action-$dir"
    case "focus-left"
        if test "$layout" = "scrolling"
            hyprctl dispatch movefocus "l"
        else
            hyprctl dispatch movefocus "l"
        end
    case "focus-right"
        if test "$layout" = "scrolling"
            hyprctl dispatch movefocus "r"
        else
            hyprctl dispatch movefocus "r"
        end
    case "focus-up"
        if test "$layout" = "scrolling"
            hyprctl dispatch movefocus "u"
        else
            hyprctl dispatch movefocus "u"
        end
    case "focus-down"
        if test "$layout" = "scrolling"
            hyprctl dispatch movefocus "d"
        else
            hyprctl dispatch movefocus "d"
        end
    case "move-left"
        if test "$layout" = "scrolling"
            hyprctl dispatch movewindow "l"
        else
            hyprctl dispatch movewindow "l"
        end
    case "move-right"
        if test "$layout" = "scrolling"
            hyprctl dispatch movewindow "r"
        else
            hyprctl dispatch movewindow "r"
        end
    case "move-up"
        if test "$layout" = "scrolling"
            hyprctl dispatch movewindow "u"
        else
            hyprctl dispatch movewindow "u"
        end
    case "move-down"
        if test "$layout" = "scrolling"
            hyprctl dispatch movewindow "d"
        else
            hyprctl dispatch movewindow "d"
        end
end
