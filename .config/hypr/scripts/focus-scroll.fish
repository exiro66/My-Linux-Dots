#!/usr/bin/fish
set dir $argv[1]
set current_monitor (hyprctl activeworkspace -j | jq -r '.monitor')

switch $dir
    case left
        hyprctl dispatch movefocus "l"
    case right
        hyprctl dispatch movefocus "r"
    case up
        hyprctl dispatch movefocus "u"
    case down
        hyprctl dispatch movefocus "d"
end

set new_monitor (hyprctl activeworkspace -j | jq -r '.monitor')

if test "$new_monitor" != "$current_monitor"
    hyprctl dispatch focusmonitor "$current_monitor"
end
