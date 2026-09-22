#!/bin/sh
# Arranca quickshell con el tema de iconos que tengas en GTK (nwg-look) o
# Qt (qt6ct). Sin ellos, MacTahoe-dark para instalaciones frescas.
# Cambiar de tema pide reiniciar la shell (SUPER+R).
theme="$(sed -n 's/^gtk-icon-theme-name=//p' ~/.config/gtk-3.0/settings.ini 2>/dev/null | head -n 1)"
[ -z "$theme" ] && theme="$(sed -n 's/^icon_theme=//p' ~/.config/qt6ct/qt6ct.conf 2>/dev/null | head -n 1)"
[ -z "$theme" ] && theme="MacTahoe-dark"
export QS_ICON_THEME="$theme"
exec quickshell "$@"
