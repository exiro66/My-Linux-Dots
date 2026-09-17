#!/usr/bin/env fish

# Colores de pywal → GTK
cp ~/.cache/wal/colors-gtk.css ~/.config/gtk-3.0/gtk.css 2>/dev/null
cp ~/.cache/wal/colors-gtk.css ~/.config/gtk-4.0/gtk.css 2>/dev/null

# Colores de pywal → Qt
mkdir -p ~/.config/qt6ct/colors
cp ~/.cache/wal/colors-qt6ct.conf ~/.config/qt6ct/colors/pywal.conf 2>/dev/null

# Recargar GTK
gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"

# Colores de pywal → Kitty
kitty @ --to unix:/tmp/kitty set-colors -a -c ~/.cache/wal/colors-kitty.conf 2>/dev/null

# Colores de pywal → Borde de Hyprland (un solo color)
set color4 (sed -n '5p' ~/.cache/wal/colors | string replace '#' '')
hyprctl eval "hl.config({ general = { col = { active_border = { colors = { 'rgba($color4"ff")' }, angle = 45 } } } })"

echo "Colores aplicados."
