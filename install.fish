#!/usr/bin/fish

echo "===================================================="
echo "    INSTALADOR MAESTRO TOTAL: APPS + RICELINE       "
echo "===================================================="

# 1. Clonar tus configuraciones personalizadas desde TU GitHub primero
echo "==> 1. Descargando tus parches y tu lista de aplicaciones..."
set MI_REPO "https://github.com/exiro66/My-Linux-Dots.git"
set TMP_DIR "/tmp/mis-parches"

rm -rf $TMP_DIR
git clone $MI_REPO $TMP_DIR

# 2. Instalar TODAS tus aplicaciones automáticamente (Zen, Loupe, Dragon, etc.)
echo "==> 2. Instalando tus programas y apps del sistema..."
if test -f "$TMP_DIR/.config/fish/functions/mis_apps.txt"
    if not command -v yay >/dev/null
        sudo pacman -S --needed git base-devel --noconfirm
        git clone https://archlinux.org /tmp/yay
        cd /tmp/yay; makepkg -si --noconfirm; cd -
    end
    
    set apps_a_instalar (cat $TMP_DIR/.config/fish/functions/mis_apps.txt)
    yay -S --needed --noconfirm $apps_a_instalar
else
    echo "¡Advertencia! No se encontró la lista mis_apps.txt, instalando básicas..."
    yay -S --needed --noconfirm ghostty zen-browser-bin papirus-icon-theme papirus-folders sddm
end

# 3. Ejecutar el instalador oficial de Riceline
echo "==> 3. Descargando e instalando la suite oficial de RICELINE..."
curl -fsSL https://githubusercontent.com | bash

# 4. Desplegar tus funciones y configuraciones personales
echo "==> 4. Inyectando comandos rápidos en tu terminal Fish y Hyprland..."
mkdir -p ~/.config/fish/functions
mkdir -p ~/.config/hypr
cp -r $TMP_DIR/.config/fish/functions/* ~/.config/fish/functions/
cp -r $TMP_DIR/.config/hypr/* ~/.config/hypr/
cp -r $TMP_DIR/SDDM ~/

# 5. Desplegar tu pantalla de login Caelestia Parcheada
echo "==> 5. Configurando y parcheando la pantalla de bloqueo SDDM..."
sudo cp -r $TMP_DIR/caelestia /usr/share/sddm/themes/
sudo sed -i 's/^Current=.*/Current=caelestia/' /etc/sddm.conf
sudo systemctl enable sddm

# 6. Forzar tus carpetas Papirus en color Gris Oscuro (Carmine)
echo "==> 6. Configurando iconos del sistema a Papirus con folders grises..."
sudo papirus-folders -C carmine --theme Papirus-Dark
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

echo "===================================================="
echo "   ¡PROCESO TOTAL COMPLETADO CON ÉXITO!            "
echo "   Tus aplicaciones, Riceline y SDDM están listos. "
echo "   Por favor, reinicia el sistema para aplicar.     "
echo "===================================================="
