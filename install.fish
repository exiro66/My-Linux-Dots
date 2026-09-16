#!/usr/bin/fish

set REPO_DIR (pwd)

echo "==> Instalando My-Linux-Dots..."

# yay
if not command -v yay >/dev/null
    sudo pacman -S --needed git base-devel --noconfirm
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay; makepkg -si --noconfirm; cd -
end

# Dependencias
sudo pacman -S --needed --noconfirm \
    hyprland hyprland-guiutils xdg-desktop-portal-hyprland \
    kitty fish nautilus zen-browser \
    plymouth sddm qt5ct qt6ct nwg-look \
    btop cava mpv micro satty \
    playerctl brightnessctl wireplumber \
    ttf-jetbrains-mono-nerd

# Noctalia
if not command -v noctalia >/dev/null
    yay -S --noconfirm noctalia-git
end

# Backup
set BACKUP ~/.config-backup-(date +%Y%m%d-%H%M%S)
mkdir -p $BACKUP

# Copiar configs
test -d ~/.config/hypr; and mv ~/.config/hypr $BACKUP/
cp -r $REPO_DIR/.config/hypr ~/.config/

test -d ~/.config/noctalia; and mv ~/.config/noctalia $BACKUP/
cp -r $REPO_DIR/.config/noctalia ~/.config/
mkdir -p ~/.local/state/noctalia
cp $REPO_DIR/noctalia-state/settings.toml ~/.local/state/noctalia/

cp -r $REPO_DIR/.config/fish/* ~/.config/fish/

for dir in gtk-3.0 gtk-4.0 qt5ct qt6ct btop cava mpv nwg-look micro satty
    test -d $REPO_DIR/.config/$dir; and cp -r $REPO_DIR/.config/$dir ~/.config/
end
cp $REPO_DIR/.config/kdeglobals ~/.config/ 2>/dev/null
cp $REPO_DIR/.config/mimeapps.list ~/.config/ 2>/dev/null

mkdir -p ~/.config/kitty
cp $REPO_DIR/kitty/kitty.conf ~/.config/kitty/

mkdir -p ~/.local/bin
cp $REPO_DIR/scripts/* ~/.local/bin/
chmod +x ~/.local/bin/*

test -d $REPO_DIR/.icons/Bibata-Modern-Ice; and cp -r $REPO_DIR/.icons/Bibata-Modern-Ice ~/.local/share/icons/

mkdir -p ~/Imágenes/Wallpapers
cp $REPO_DIR/wallpapers/* ~/Imágenes/Wallpapers/

# SDDM
sudo mkdir -p /usr/share/sddm/themes
sudo cp -r $REPO_DIR/sddm/caelestia /usr/share/sddm/themes/
sudo chmod -R 755 /usr/share/sddm/themes/caelestia
sudo mkdir -p /etc/sddm.conf.d
printf "[Theme]\nCurrent=caelestia\n" | sudo tee /etc/sddm.conf.d/caelestia.conf

mkdir -p ~/SDDM
for color in BEIGE BLACK BLUE GREEN GRUVBOX HEXA LAVENDER ORANGE PINK PURPLE RED STARS WHITE YELLOW
    test -d $REPO_DIR/sddm/$color; and cp -r $REPO_DIR/sddm/$color ~/SDDM/
end

# Plymouth
sudo cp -r $REPO_DIR/plymouth/pedro-raccoon /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R pedro-raccoon

sudo systemctl enable sddm

# Iconos personalizados
mkdir -p ~/.local/share/icons
cp $REPO_DIR/icons/noctalia-custom.png ~/.local/share/icons/
cp $REPO_DIR/icons/zen-custom.png ~/.local/share/icons/

# .desktop personalizados
mkdir -p ~/.local/share/applications
cp $REPO_DIR/applications/dev.noctalia.Noctalia.desktop ~/.local/share/applications/
cp $REPO_DIR/applications/zen.desktop ~/.local/share/applications/
update-desktop-database ~/.local/share/applications/

echo "==> Listo. Reinicia el sistema."
