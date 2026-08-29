#!/usr/bin/fish

echo "===================================================="
echo "    INSTALADOR MAESTRO TOTAL: APPS + RICELINE       "
echo "===================================================="

# 1. Clonar tus configuraciones personalizadas desde TU GitHub primero
echo "==> 1. Descargando tus parches y configuraciones..."
set MI_REPO "https://github.com/exiro66/My-Linux-Dots.git"
set TMP_DIR "/tmp/mis-parches"

rm -rf $TMP_DIR
git clone $MI_REPO $TMP_DIR

# 2. Instalar apps esenciales
echo "==> 2. Instalando apps esenciales..."
if not command -v yay >/dev/null
    sudo pacman -S --needed git base-devel --noconfirm
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay; makepkg -si --noconfirm; cd -
end

yay -S --needed --noconfirm zen-browser-bin loupe qbittorrent lutris wine winetricks zram-generator nautilus gnome-calculator gnome-disk-utility easyeffects audacity tela-circle-icon-theme caelestia-sddm-locklike-git

# 2.1 Borrar apps que no quiero
echo "==> 2.1 Eliminando Firefox y Alacritty..."
sudo pacman -Rns --noconfirm firefox alacritty

echo "[zram0]" | sudo tee /etc/systemd/zram-generator.conf
echo "zram-size = ram / 2" | sudo tee -a /etc/systemd/zram-generator.conf
echo "compression-algorithm = zstd" | sudo tee -a /etc/systemd/zram-generator.conf

# 3. Ejecutar el instalador oficial de Ricelin y Rishot PRIMERO
echo "==> 3. Descargando e instalando Ricelin y Rishot..."
curl -fsSL https://raw.githubusercontent.com/Gakuseei/Ricelin/main/install.sh | bash
curl -fsSL https://raw.githubusercontent.com/Gakuseei/rishot/main/install.sh | sh

# 4. Desplegar funciones y configuraciones personales DESPUÉS de Ricelin
echo "==> 4. Inyectando funciones Fish y config de Hyprland..."
mkdir -p ~/.config/fish/functions
mkdir -p ~/.config/hypr
mkdir -p ~/SDDM
cp -r $TMP_DIR/.config/fish/functions/* ~/.config/fish/functions/
cp -r $TMP_DIR/.config/hypr/* ~/.config/hypr/
cp -r $TMP_DIR/SDDM/* ~/SDDM/

# 4.1 Configurar Fastfetch
echo "==> 4.1 Configurando Fastfetch..."
mkdir -p ~/.config/fastfetch
cp $TMP_DIR/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc

# 5. Configurar Fish
echo "==> 5. Configurando Fish..."
if test -f $TMP_DIR/.config/fish/config.fish
    cp $TMP_DIR/.config/fish/config.fish ~/.config/fish/config.fish
else
    if test -f ~/.config/fish/config.fish
        sed -i 's|~/.config/fish/torii-greeting.sh|#~/.config/fish/torii-greeting.sh|' ~/.config/fish/config.fish
    end
end

# 6. Instalar fuente MartianMono
echo "==> 6. Instalando MartianMono Nerd Font..."
mkdir -p ~/.local/share/fonts
set FONT_URL "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/MartianMono.zip"
set FONT_ZIP "/tmp/MartianMono.zip"

wget -O $FONT_ZIP $FONT_URL
unzip -o $FONT_ZIP -d ~/.local/share/fonts/
rm -f $FONT_ZIP
fc-cache -fv

# 7. Configurar Plymouth Pedro Raccoon
echo "==> 8. Configurando Plymouth Pedro Raccoon..."
if test -d ./pedro-raccoon
    sudo cp -r ./pedro-raccoon /usr/share/plymouth/themes/
    sudo plymouth-set-default-theme -R pedro-raccoon
    sudo mkinitcpio -P
else
    echo "Tema Plymouth no encontrado, saltando..."
end

# 8. Copiar wallpapers para Ricelin
echo "==> 9. Copiando wallpapers para Ricelin..."
mkdir -p ~/Ricelin/wallpapers
cp -r ./wallpapers/* ~/Ricelin/wallpapers/

# 8.1 Borrar wallpapers de Ricelin
echo "==> 9.1 Eliminando wallpapers raros..."
rm -f ~/Ricelin/wallpapers/wh-d8pq7j.png
rm -f ~/Ricelin/wallpapers/wh-gp7mq3.jpg
rm -f ~/Ricelin/wallpapers/wh-z8zkmw.jpg

# 9. Instalar y parchear Caelestia SDDM
echo "==> 10. Configurando y parcheando SDDM..."
yay -S --noconfirm caelestia-sddm-locklike-git
if test -d "$TMP_DIR/caelestia"
    sudo cp -r $TMP_DIR/caelestia/* /usr/share/sddm/themes/caelestia/
end
if test -f /etc/sddm.conf
    sudo sed -i 's/^Current=.*/Current=caelestia/' /etc/sddm.conf
else
    echo "[Theme]" | sudo tee /etc/sddm.conf
    echo "Current=caelestia" | sudo tee -a /etc/sddm.conf
end
sudo systemctl enable sddm

# 10. Configurar iconos Tela-circle
echo "==> 10. Configurando iconos Tela-circle..."
gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-black-dark'

# 11. Instalar y configurar Starship
echo "==> 12. Instalando Starship..."
curl -sS https://starship.rs/install.sh | sh
mkdir -p ~/.config
cp $TMP_DIR/starship.toml ~/.config/starship.toml
echo "starship init fish | source" >> ~/.config/fish/config.fish

# 12. Configurar Ghostty
echo "==> 13. Configurando Ghostty..."
mkdir -p ~/.config/ghostty
cp $TMP_DIR/.config/ghostty/config ~/.config/ghostty/config

# 13. Aplicando tema BLACK
echo "==> 14. Aplicando tema BLACK..."
sddm black --no-restart 2>/dev/null || echo "Aplica manualmente con: sddm black"

# 13.1 Aplicando iconos negros
echo "==> 13.1 Aplicando iconos negros..."
icons negro

echo "===================================================="
echo "   ¡PROCESO TOTAL COMPLETADO CON ÉXITO!            "
echo "   Tus aplicaciones, Riceline y SDDM están listos. "
echo "   Por favor, reinicia el sistema para aplicar.     "
echo "===================================================="
