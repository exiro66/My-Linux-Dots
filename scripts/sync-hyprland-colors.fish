#!/usr/bin/env fish
# Leer colores del tema de Kitty generado por Noctalia
set CONF $HOME/.config/kitty/themes/noctalia.conf

set ACCENT (grep "^active_border_color" $CONF | awk '{print $2}')
set FOREGROUND (grep "^foreground" $CONF | awk '{print $2}')

# Eliminar el '#'
set ACCENT (string replace '#' '' $ACCENT)
set FOREGROUND (string replace '#' '' $FOREGROUND)

# Aplicar a Hyprland
hyprctl dispatch "hl.config({ general = { col = { active_border = { colors = { 'rgba($ACCENT"ff")', 'rgba($FOREGROUND"ff")' }, angle = 45 }, inactive_border = 'rgba(00000000)' } } })"
