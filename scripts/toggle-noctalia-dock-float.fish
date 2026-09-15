#!/usr/bin/env fish

if grep -q "margin_edge = 10" ~/.local/state/noctalia/settings.toml
    set value 0
else
    set value 10
end

awk -v val=$value '
    /^\[dock\]/ { in_dock=1; print; next }
    /^\[/ && !/^\[dock\]/ { in_dock=0 }
    in_dock && /^margin_edge = / { sub(/=.*/, "= " val); print; next }
    in_dock && /^margin_ends = / { sub(/=.*/, "= " val); print; next }
    { print }
' ~/.local/state/noctalia/settings.toml > /tmp/settings.toml.new

mv /tmp/settings.toml.new ~/.local/state/noctalia/settings.toml

noctalia msg config-reload
