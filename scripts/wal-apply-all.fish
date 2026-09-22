#!/usr/bin/env fish

# GTK (rápido, mantener en foreground)
cp ~/.cache/wal/colors-gtk.css ~/.config/gtk-3.0/gtk.css 2>/dev/null
cp ~/.cache/wal/colors-gtk.css ~/.config/gtk-4.0/gtk.css 2>/dev/null
gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"

# Qt (rápido)
mkdir -p ~/.config/qt6ct/colors
cp ~/.cache/wal/colors-qt6ct.conf ~/.config/qt6ct/colors/pywal.conf 2>/dev/null

# Kitty (background, no bloquea)
kitty @ --to unix:/tmp/kitty set-colors -a -c ~/.cache/wal/colors-kitty.conf 2>/dev/null &

# Hyprland (background, no bloquea)
set color1 (sed -n '2p' ~/.cache/wal/colors | string replace '#' '')
set color4 (sed -n '5p' ~/.cache/wal/colors | string replace '#' '')
hyprctl eval "hl.config({ general = { col = { active_border = { colors = { 'rgba($color1"ff")', 'rgba($color4"ff")' }, angle = 45 } } } })"

echo "Colores aplicados."
