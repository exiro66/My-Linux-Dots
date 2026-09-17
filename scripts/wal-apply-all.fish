#!/usr/bin/env fish

# Aplicar colores de pywal a GTK
cp ~/.cache/wal/colors-gtk.css ~/.config/gtk-3.0/gtk.css
cp ~/.cache/wal/colors-gtk.css ~/.config/gtk-4.0/gtk.css

# Aplicar colores de pywal a Qt
mkdir -p ~/.config/qt6ct/colors
cp ~/.cache/wal/colors-qt6ct.conf ~/.config/qt6ct/colors/pywal.conf

# Recargar GTK
gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"

# Recargar Kitty (si tiene remote control)
kitty @ --to unix:/tmp/kitty set-colors -a -c ~/.cache/wal/colors-kitty.conf 2>/dev/null

echo "Colores aplicados."
