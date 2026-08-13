function set-sddm --description "Cambia el wallpaper de SDDM Caelestia con Riceline"
    if test (count $argv) -ne 1
        echo "Uso: set-sddm /ruta/a/tu/imagen.jpg"
        return 1
    end

    set img_path $argv

    if not test -f $img_path
        echo "Error: El archivo de imagen no existe."
        return 1
    end

    echo "Aplicando nuevo wallpaper a SDDM Caelestia..."
    
    # Copiar fondo a todas las rutas de caché del tema
    sudo cp $img_path /usr/share/sddm/themes/caelestia/background.png
    sudo cp $img_path /usr/share/sddm/themes/caelestia/assets/background
    sudo cp $img_path /usr/share/sddm/themes/caelestia/assets/background.png

    # Asegurar permisos correctos
    sudo chmod 644 /usr/share/sddm/themes/caelestia/background.png
    sudo chmod 644 /usr/share/sddm/themes/caelestia/assets/background*

    echo "¡Listo! Reiniciando SDDM para aplicar los cambios..."
    sudo systemctl restart sddm
end

