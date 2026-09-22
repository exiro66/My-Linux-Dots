#!/usr/bin/env fish
# Instalador de My-Linux-Dots (Arch / CachyOS + Hyprland).
# Uso: fish install.fish   (ejecutar dentro de Hyprland)
# Hace copia de seguridad de tu ~/.config antes de tocar nada.

set DOTS (realpath (dirname (status filename)))
set BACKUP ~/.config-backup-(date +%Y%m%d-%H%M%S)

function paso
    echo -e "\n==> $argv\n"
end

command -q pacman; or begin
    echo "Esto solo funciona en Arch Linux / CachyOS."
    exit 1
end

# --- yay ---
if not command -q yay
    paso "Instalando yay"
    sudo pacman -S --needed --noconfirm git base-devel
    and git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    and bash -c "cd /tmp/yay-bin && makepkg -si --noconfirm"
    or begin
        echo "No se pudo instalar yay. Instálalo y repite."
        exit 1
    end
end

# --- paquetes oficiales ---
paso "Paquetes oficiales"
set pkgs hyprland quickshell kitty fish starship python-pywal jq curl bash \
    networkmanager pipewire pipewire-pulse wireplumber bluez bluez-utils \
    power-profiles-daemon upower brightnessctl gpu-screen-recorder playerctl \
    wl-clipboard kdialog ttf-jetbrains-mono-nerd inter-font hyprlock hypridle \
    hyprsunset nautilus firefox mpv sddm qt6ct nwg-look awww loupe easyeffects \
    gnome-disk-utility gnome-calculator vscodium qbittorrent lutris wine winetricks
yay -S --needed --noconfirm $pkgs
or begin
    echo "Falló la instalación de paquetes."
    exit 1
end

# --- paquetes AUR (uno a uno, ninguno es crítico) ---
paso "Paquetes AUR"
for p in zen-browser hyprmod otf-apple-sf-pro mactahoe-icon-theme-git bibata-cursor-theme
    yay -S --needed --noconfirm $p; or echo "Aviso: no se instaló $p, sigo."
end

# --- rishot (capturas con anotación) ---
paso "Rishot"
yay -S --needed --noconfirm quickshell qt6-declarative qt6-svg qt6-5compat qt6-wayland wl-clipboard imagemagick cliphist curl kdialog libnotify
and curl -fsSL https://raw.githubusercontent.com/Gakuseei/rishot/main/install.sh | sh
or echo "Aviso: rishot no se instaló, sigo."

# --- copia de seguridad + configs ---
paso "Copiando configs (respaldo en $BACKUP)"
mkdir -p $BACKUP
for d in hypr kitty quickshell starship.toml
    if test -e ~/.config/$d
        mv ~/.config/$d $BACKUP/
    end
end
mkdir -p ~/.config ~/.local/bin
cp -r $DOTS/hypr $DOTS/kitty $DOTS/quickshell ~/.config/
cp $DOTS/colors/starship.toml ~/.config/
cp $DOTS/scripts/* ~/.local/bin/
chmod +x ~/.local/bin/*

# --- wallpapers y packs SDDM ---
paso "Wallpapers"
set pics (xdg-user-dir PICTURES 2>/dev/null; or echo ~/Imágenes)
mkdir -p "$pics/Wallpapers" ~/SDDM ~/Vídeos/Grabaciones
cp -n $DOTS/Wallpapers/* "$pics/Wallpapers/" 2>/dev/null
cp -rn $DOTS/sddm/wallpapers/* ~/SDDM/ 2>/dev/null
true

# --- servicios del sistema ---
paso "Servicios"
sudo systemctl enable --now bluetooth 2>/dev/null
sudo systemctl enable --now power-profiles-daemon 2>/dev/null
sudo systemctl mask dunst.service 2>/dev/null
true

# --- SDDM (tema caelestia) ---
paso "SDDM"
if test -d $DOTS/sddm/themes/caelestia
    sudo mkdir -p /usr/share/sddm/themes /etc/sddm.conf.d
    sudo cp -r $DOTS/sddm/themes/caelestia /usr/share/sddm/themes/
    sudo cp $DOTS/sddm/etc-sddm/sddm.conf /etc/sddm.conf 2>/dev/null
    sudo cp -r $DOTS/sddm/etc-sddm/sddm.conf.d/* /etc/sddm.conf.d/ 2>/dev/null
    true
end

# --- plugins Hyprland (overview hyprexpo + hyprglass, lo mejor es mejor-esfuerzo) ---
paso "Plugins hyprpm (puede tardar)"
hyprpm add https://github.com/sandwichfarm/hyprexpo-plus 2>/dev/null
hyprpm enable hyprexpo 2>/dev/null
hyprpm add https://github.com/hyprnux/hyprglass 2>/dev/null
hyprpm enable hyprglass 2>/dev/null
true

# --- primer tema pywal ---
paso "Tema inicial"
set first "$pics/Wallpapers/ae86.png"
test -f "$first"; or set first (ls "$pics"/Wallpapers/* 2>/dev/null | head -n 1)
if test -n "$first"
    wal -n -i "$first" 2>/dev/null
    ~/.local/bin/wal-apply-all.fish 2>/dev/null
end

echo -e "\nListo. Cierra sesión y entra en Hyprland."
echo "Atajos: SUPER+A apps · SUPER+C centro · SUPER+W fondos · SUPER+R recargar · SUPER+G grabar"
