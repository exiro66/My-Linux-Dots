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

# 2. Instalar TODAS tus aplicaciones automáticamente (Zen, Loupe, nautilus, etc.)
echo "==> 2. Instalando tus programas y apps del sistema..."
if test -f "$TMP_DIR/.config/fish/functions/mis_apps.txt"
    if not command -v yay >/dev/null
        sudo pacman -S --needed git base-devel --noconfirm
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay; makepkg -si --noconfirm; cd -
    end

    set apps_a_instalar (cat $TMP_DIR/.config/fish/functions/mis_apps.txt)
    yay -S --needed --noconfirm $apps_a_instalar
else
    echo "¡Advertencia! No se encontró la lista mis_apps.txt, instalando básicas..."
    yay -S --needed --noconfirm ghostty zen-browser-bin papirus-icon-theme papirus-folders sddm
end

# 3. Ejecutar el instalador oficial de Ricelin y Rishot
echo "==> 3. Descargando e instalando las herramientas oficiales de Gakuseei..."
curl -fsSL https://raw.githubusercontent.com/Gakuseei/Ricelin/main/install.sh | bash
curl -fsSL https://raw.githubusercontent.com/Gakuseei/rishot/main/install.sh | sh

# 4. Desplegar tus funciones y configuraciones personales
echo "==> 4. Inyectando comandos rápidos en tu terminal Fish y Hyprland..."
mkdir -p ~/.config/fish/functions
mkdir -p ~/.config/hypr
mkdir -p ~/SDDM
cp -r $TMP_DIR/.config/fish/functions/* ~/.config/fish/functions/
cp -r $TMP_DIR/.config/hypr/* ~/.config/hypr/
cp -r $TMP_DIR/SDDM/* ~/SDDM/

# 5. Instalar y parchear Caelestia SDDM
echo "==> 5. Configurando y parcheando la pantalla de bloqueo SDDM..."
yay -S --noconfirm caelestia-sddm-locklike-git

# Sobreescribir con tu versión personalizada
if test -d "$TMP_DIR/caelestia"
    sudo cp -r $TMP_DIR/caelestia/* /usr/share/sddm/themes/caelestia/
end

# Configurar tema por defecto
if test -f /etc/sddm.conf
    sudo sed -i 's/^Current=.*/Current=caelestia/' /etc/sddm.conf
else
    echo "[Theme]" | sudo tee /etc/sddm.conf
    echo "Current=caelestia" | sudo tee -a /etc/sddm.conf
end

sudo systemctl enable sddm

# 6. Forzar tus carpetas Papirus en color Gris Oscuro (Carmine)
echo "==> 6. Configurando iconos del sistema a Papirus con folders grises..."
sudo papirus-folders -C carmine --theme Papirus-Dark
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

# 7. Instalar fuente MartianMono desde Nerd Fonts
echo "==> 7. Instalando fuente MartianMono Nerd Font..."
mkdir -p ~/.local/share/fonts
set FONT_URL "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/MartianMono.zip"
set FONT_ZIP "/tmp/MartianMono.zip"

wget -O $FONT_ZIP $FONT_URL
unzip -o $FONT_ZIP -d ~/.local/share/fonts/
rm -f $FONT_ZIP
fc-cache -fv

# 8. Configurar Limine (timeout 0 + quiet)
echo "==> 8. Configurando Limine..."
if test -f /boot/limine.conf
    sudo sed -i 's/^timeout:.*/timeout: 0/' /boot/limine.conf
    sudo sed -i 's/^quiet:.*/quiet: yes/' /boot/limine.conf
else
    echo "limine.conf no encontrado, saltando..."
end

# 9. Configurar Plymouth
echo "==> 9. Configurando Plymouth Pedro Raccoon..."
if test -d ./pedro-raccoon
    sudo cp -r ./pedro-raccoon /usr/share/plymouth/themes/
    sudo plymouth-set-default-theme -R pedro-raccoon
    sudo mkinitcpio -P
else
    echo "Tema Plymouth no encontrado, saltando..."
end

# 10. Copiar wallpapers para Ricelin
echo "==> 10. Copiando wallpapers para Ricelin..."
mkdir -p ~/Ricelin/wallpapers
cp -r ./wallpapers/* ~/Ricelin/wallpapers/

# 11. Aplicar tema por defecto (opcional, descomenta el color que quieras)
echo "==> 11. Aplicando tema BLUE por defecto..."
sddm BLUE --no-restart 2>/dev/null || echo "Aplica manualmente con: sddm BLUE"

echo "===================================================="
echo "   ¡PROCESO TOTAL COMPLETADO CON ÉXITO!            "
echo "   Tus aplicaciones, Riceline y SDDM están listos. "
echo "   Por favor, reinicia el sistema para aplicar.     "
echo "===================================================="

