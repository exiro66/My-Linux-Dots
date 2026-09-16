#!/usr/bin/env fish
while true
    inotifywait -e modify ~/.config/kitty/themes/noctalia.conf
    fish ~/.local/bin/sync-hyprland-colors.fish
end
