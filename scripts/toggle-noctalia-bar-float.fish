#!/usr/bin/env fish

if grep -q "margin_edge = 10" ~/.config/noctalia/config.toml
    sed -i "s/margin_edge = 10/margin_edge = 0/" ~/.config/noctalia/config.toml
else
    sed -i "s/margin_edge = 0/margin_edge = 10/" ~/.config/noctalia/config.toml
end

noctalia msg config-reload
