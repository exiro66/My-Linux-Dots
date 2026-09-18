#!/usr/bin/fish
# My-Linux-Dots - Installer for CachyOS

set REPO_DIR (pwd)

echo "==> Installing My-Linux-Dots..."

# yay
if not command -v yay >/dev/null
    sudo pacman -S --needed git base-devel --noconfirm
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay; makepkg -si --noconfirm; cd -
end

# Base dependencies
echo "==> Installing base dependencies..."
sudo pacman -S --needed --noconfirm \
    hyprland hyprland-guiutils xdg-desktop-portal-hyprland \
    hyprpm polkit \
    kitty fish nautilus zen-browser \
    plymouth sddm qt5ct qt6ct nwg-look \
    playerctl brightnessctl wireplumber \
    jq \
    ttf-jetbrains-mono-nerd

# Applications
echo "==> Installing applications..."
sudo pacman -S --needed --noconfirm \
    vscodium qbittorrent lutris wine winetricks \
    mpv loupe easyeffects \
    gnome-disk-utility gnome-calculator

# hyprmod (AUR)
echo "==> Installing hyprmod..."
yay -S --noconfirm hyprmod

# Tide Island
echo "==> Installing Tide Island..."
yay -S --noconfirm tide-island

# Fonts (SF Pro)
echo "==> Installing SF Pro fonts..."
yay -S --noconfirm otf-apple-sf-pro

# Icon theme (MacTahoe)
echo "==> Installing MacTahoe icons..."
yay -S --noconfirm mactahoe-icon-theme-git

# Cursor theme (Bibata)
echo "==> Installing Bibata cursor..."
yay -S --noconfirm bibata-cursor-theme

# Wallpaper, notifications, colors
echo "==> Installing awww, dunst, hyprsunset, pywal and hyprlock..."
sudo pacman -S --needed --noconfirm awww dunst hyprsunset python-pywal hyprlock

# Screen recording
echo "==> Installing gpu-screen-recorder..."
sudo pacman -S --needed --noconfirm gpu-screen-recorder

# Rishot (screenshot + annotation)
echo "==> Installing Rishot..."
sudo pacman -S --needed --noconfirm \
    quickshell qt6-declarative qt6-svg qt6-5compat qt6-wayland \
    wl-clipboard imagemagick cliphist curl kdialog libnotify
curl -fsSL https://raw.githubusercontent.com/Gakuseei/rishot/main/install.sh | sh

# Battery
echo "==> Installing TLP..."
sudo pacman -S --needed --noconfirm tlp tlp-rdw
sudo systemctl enable --now tlp

# Backup
set BACKUP ~/.config-backup-(date +%Y%m%d-%H%M%S)
mkdir -p $BACKUP
echo "==> Backup in: $BACKUP"

# Hyprland configs
test -d ~/.config/hypr; and mv ~/.config/hypr $BACKUP/
cp -r $REPO_DIR/.config/hypr ~/.config/

# Fish configs
cp -r $REPO_DIR/.config/fish/* ~/.config/fish/

# GTK / Qt configs
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

# pywal templates
mkdir -p ~/.config/wal/templates
cp $REPO_DIR/wal-templates/* ~/.config/wal/templates/

# Tide Island config
mkdir -p ~/.config/tide-island
cp $REPO_DIR/tide-island/userconfig.json ~/.config/tide-island/

# Tide Island patch (auto notch)
sudo cp $REPO_DIR/tide-island-patches/DynamicIslandWindow.qml /usr/share/tide-island/DynamicIslandWindow.qml

# Wallpapers
mkdir -p ~/Imágenes/Wallpapers
cp $REPO_DIR/wallpapers/* ~/Imágenes/Wallpapers/

# Custom icons
mkdir -p ~/.local/share/icons
cp $REPO_DIR/icons/zen-custom.png ~/.local/share/icons/ 2>/dev/null

# Custom .desktop files
mkdir -p ~/.local/share/applications
cp $REPO_DIR/applications/zen.desktop ~/.local/share/applications/ 2>/dev/null
update-desktop-database ~/.local/share/applications/

# SDDM + Caelestia theme
echo "==> Installing SDDM..."
sudo pacman -S --needed --noconfirm sddm
sudo pacman -S --needed --noconfirm \
    qt5-base qt5-declarative qt5-quickcontrols2 \
    qt5-graphicaleffects qt5-svg qt5-multimedia

echo "==> Installing Caelestia SDDM theme..."
yay -S --noconfirm caelestia-sddm-locklike-git

echo "==> Applying Caelestia customizations..."
sudo cp -r $REPO_DIR/sddm/caelestia/* /usr/share/sddm/themes/caelestia/
sudo chmod -R 755 /usr/share/sddm/themes/caelestia

sudo mkdir -p /etc/sddm.conf.d
printf "[Theme]\nCurrent=caelestia\n" | sudo tee /etc/sddm.conf.d/caelestia.conf

mkdir -p ~/SDDM
for color in BEIGE BLACK BLUE GREEN GRUVBOX HEXA LAVENDER ORANGE PINK PURPLE RED SKY STARS WHITE YELLOW
    test -d $REPO_DIR/sddm/$color; and cp -r $REPO_DIR/sddm/$color ~/SDDM/
end

# Plymouth
echo "==> Installing Plymouth..."
sudo cp -r $REPO_DIR/plymouth/pedro-raccoon /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R pedro-raccoon

# Enable SDDM
sudo systemctl enable sddm

# User services (awww and tide-island)
echo "==> Setting up user services..."
mkdir -p ~/.config/systemd/user
cp $REPO_DIR/systemd-user/awww-daemon.service ~/.config/systemd/user/ 2>/dev/null
systemctl --user daemon-reload
systemctl --user enable --now awww-daemon.service
systemctl --user enable --now tide-island.service

# HyprGlass (Liquid Glass effect)
echo "==> Installing HyprGlass..."
hyprpm update
yes | hyprpm add https://github.com/hyprnux/hyprglass
hyprpm enable hyprglass
hyprpm reload -n

# Initialize pywal with first wallpaper
echo "==> Initializing pywal..."
set first_wall (ls ~/Imágenes/Wallpapers/* | head -1)
wal -i $first_wall -n
~/.local/bin/wal-apply-all.fish

# Apply default themes
echo "==> Applying default themes..."

# SDDM Black theme
sddm black --no-restart

# MacTahoe Grey Dark icons
gsettings set org.gnome.desktop.interface icon-theme "MacTahoe-grey-dark"

# Bibata Modern Ice cursor
gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice"

echo ""
echo "===================================================="
echo "   INSTALLATION COMPLETE"
echo "   Backup: $BACKUP"
echo "   Reboot to apply all changes."
echo "===================================================="
