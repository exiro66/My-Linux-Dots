#!/usr/bin/env fish
# Reaplicar parche de Tide Island (notch automático)

set PATCH_FILE ~/My-Linux-Dots/tide-island-patches/DynamicIslandWindow.qml
set TARGET /usr/share/tide-island/DynamicIslandWindow.qml

if not test -f $PATCH_FILE
    echo "❌ No se encuentra el parche en: $PATCH_FILE"
    exit 1
end

echo "==> Aplicando parche a Tide Island..."
sudo cp $PATCH_FILE $TARGET
systemctl --user restart tide-island
echo "✅ Parche aplicado. Tide Island reiniciado."
