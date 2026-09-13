#!/usr/bin/env fish

if grep -q "margin_edge = 0" ~/.config/noctalia/config.toml
    # BARRA - Activar flotante (400 es el valor que ya tenías)
    sed -i "s/margin_edge = 0/margin_edge = 10/" ~/.config/noctalia/config.toml
    sed -i "s/margin_ends = 0/margin_ends = 400/" ~/.config/noctalia/config.toml
    # DOCK - Activar flotante
    sed -i "s/margin_edge = 0/margin_edge = 10/" ~/.local/state/noctalia/settings.toml
    sed -i "s/margin_ends = 0/margin_ends = 10/" ~/.local/state/noctalia/settings.toml
else
    # BARRA - Volver a normal
    sed -i "s/margin_edge = 10/margin_edge = 0/" ~/.config/noctalia/config.toml
    sed -i "s/margin_ends = 400/margin_ends = 0/" ~/.config/noctalia/config.toml
    # DOCK - Volver a normal
    sed -i "s/margin_edge = 10/margin_edge = 0/" ~/.local/state/noctalia/settings.toml
    sed -i "s/margin_ends = 10/margin_ends = 0/" ~/.local/state/noctalia/settings.toml
end

noctalia msg config-reload
