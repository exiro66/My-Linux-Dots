#!/usr/bin/fish
# My-Linux-Dots - Instalador para CachyOS

set REPO_DIR (pwd)

echo "==> Instalando My-Linux-Dots..."

# yay
if not command -v yay >/dev/null
    sudo pacman -S --needed git base-devel --noconfirm
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay; makepkg -si --noconfirm; cd -
end

# Dependencias base
echo "==> Instalando dependencias base..."
sudo pacman -S --needed --noconfirm \
    hyprland hyprland-guiutils xdg-desktop-portal-hyprland \
    hyprpm \
    kitty fish nautilus zen-browser \
    plymouth sddm qt5ct qt6ct nwg-look \
    playerctl brightnessctl wireplumber \
    ttf-jetbrains-mono-nerd

# Tide Island (shell principal)
echo "==> Instalando Tide Island..."
yay -S --noconfirm tide-island

# Fuentes de Apple (SF Pro)
echo "==> Instalando fuentes SF Pro..."
yay -S --noconfirm otf-apple-sf-pro

# Wallpaper, notificaciones y colores
echo "==> Instalando awww, dunst, hyprsunset y pywal..."
sudo pacman -S --needed --noconfirm awww dunst hyprsunset python-pywal

# Batería
echo "==> Instalando TLP..."
sudo pacman -S --needed --noconfirm tlp tlp-rdw
sudo systemctl enable --now tlp

# Backup de configs existentes
set BACKUP ~/.config-backup-(date +%Y%m%d-%H%M%S)
mkdir -p $BACKUP
echo "==> Backup en: $BACKUP"

# Copiar configs de Hyprland
test -d ~/.config/hypr; and mv ~/.config/hypr $BACKUP/
cp -r $REPO_DIR/.config/hypr ~/.config/

# Copiar configs de Fish
cp -r $REPO_DIR/.config/fish/* ~/.config/fish/

# Copiar otras configs
for dir in gtk-3.0 gtk-4.0 qt5ct qt6ct nwg-look
    test -d $REPO_DIR/.config/$dir; and cp -r $REPO_DIR/.config/$dir ~/.config/
end

# Kitty
mkdir -p ~/.config/kitty
cp $REPO_DIR/kitty/kitty.conf ~/.config/kitty/

# Scripts
mkdir -p ~/.local/bin
cp $REPO_DIR/scripts/* ~/.local/bin/
chmod +x ~/.local/bin/*

# Templates de pywal
mkdir -p ~/.config/wal/templates
cp $REPO_DIR/wal-templates/* ~/.config/wal/templates/

# Tide Island config
mkdir -p ~/.config/tide-island
cp $REPO_DIR/tide-island/userconfig.json ~/.config/tide-island/

# Wallpapers
mkdir -p ~/Imágenes/Wallpapers
cp $REPO_DIR/wallpapers/* ~/Imágenes/Wallpapers/

# Iconos personalizados
mkdir -p ~/.local/share/icons
cp $REPO_DIR/icons/zen-custom.png ~/.local/share/icons/ 2>/dev/null

# .desktop personalizados
mkdir -p ~/.local/share/applications
cp $REPO_DIR/applications/zen.desktop ~/.local/share/applications/ 2>/dev/null
update-desktop-database ~/.local/share/applications/

# SDDM
echo "==> Instalando SDDM..."
sudo mkdir -p /usr/share/sddm/themes
sudo cp -r $REPO_DIR/sddm/caelestia /usr/share/sddm/themes/
sudo chmod -R 755 /usr/share/sddm/themes/caelestia
sudo mkdir -p /etc/sddm.conf.d
printf "[Theme]\nCurrent=caelestia\n" | sudo tee /etc/sddm.conf.d/caelestia.conf

mkdir -p ~/SDDM
for color in BEIGE BLACK BLUE GREEN GRUVBOX HEXA LAVENDER ORANGE PINK PURPLE RED SKY STARS WHITE YELLOW
    test -d $REPO_DIR/sddm/$color; and cp -r $REPO_DIR/sddm/$color ~/SDDM/
end

# Plymouth
echo "==> Instalando Plymouth..."
sudo cp -r $REPO_DIR/plymouth/pedro-raccoon /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R pedro-raccoon

# Habilitar SDDM
sudo systemctl enable sddm

# Servicios de usuario (awww y tide-island)
echo "==> Configurando servicios de usuario..."
mkdir -p ~/.config/systemd/user
cp $REPO_DIR/systemd-user/awww-daemon.service ~/.config/systemd/user/ 2>/dev/null
systemctl --user daemon-reload
systemctl --user enable --now awww-daemon.service
systemctl --user enable --now tide-island.service

# HyprGlass (efecto Liquid Glass)
echo "==> Instalando HyprGlass..."
hyprpm update
yes | hyprpm add https://github.com/hyprnux/hyprglass
hyprpm enable hyprglass
hyprpm reload -n

# Inicializar pywal con el primer wallpaper
echo "==> Inicializando pywal..."
set first_wall (ls ~/Imágenes/Wallpapers/* | head -1)
wal -i $first_wall -n
~/.local/bin/wal-apply-all.fish

echo ""
echo "===================================================="
echo "   ✅ INSTALACIÓN COMPLETADA"
echo "   Backup: $BACKUP"
echo "   Reinicia el sistema para aplicar los cambios."
echo "===================================================="
