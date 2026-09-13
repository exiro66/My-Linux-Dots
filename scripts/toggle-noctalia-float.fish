#!/usr/bin/env fish

# Detectar estado actual
if grep -q "margin_edge = 10" ~/.config/noctalia/config.toml
    set value 0
else
    set value 10
end

# BARRA - cambiar margin_edge
if test $value -eq 0
    sed -i "s/margin_edge = 10/margin_edge = 0/" ~/.config/noctalia/config.toml
else
    sed -i "s/margin_edge = 0/margin_edge = 10/" ~/.config/noctalia/config.toml
end

# DOCK - cambiar SOLO dentro de [dock]
awk -v val=$value '
    /^\[dock\]/ { in_dock=1; print; next }
    /^\[/ && !/^\[dock\]/ { in_dock=0 }
    in_dock && /^margin_edge = / { sub(/=.*/, "= " val); print; next }
    in_dock && /^margin_ends = / { sub(/=.*/, "= " val); print; next }
    { print }
' ~/.local/state/noctalia/settings.toml > /tmp/settings.toml.new

mv /tmp/settings.toml.new ~/.local/state/noctalia/settings.toml

noctalia msg config-reload
