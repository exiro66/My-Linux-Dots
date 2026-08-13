function sddm --description "Gestor maestro de temas, colores, wallpapers y avatares para SDDM Caelestia"
    if test (count $argv) -ne 1
        echo "Uso: sddm [beige | black | blue | green | purple | red]"
        return 1
    end

    # Convertir el argumento de texto a MAYÚSCULAS para que coincida con tus carpetas
    set color_input (string upper $argv[1])
    set base_dir "/home/mohamed/SDDM/$color_input"
    set wall_src "$base_dir/A.jpg"
    set avatar_src "$base_dir/B.jpg"

    # Validar que la carpeta y las imágenes existan
    if not test -f $wall_src; or not test -f $avatar_src
        echo "Error: No se encontraron los archivos necesarios en $base_dir/"
        echo "Asegúrate de tener la carpeta /home/mohamed/SDDM/$color_input con 'A.jpg' y 'B.jpg'"
        return 1
    end

    echo "Configurando entorno SDDM en modo: $color_input..."

    # 1. Copiar Wallpaper (A.jpg) a todas las rutas de caché del tema
    sudo cp $wall_src /usr/share/sddm/themes/caelestia/background.png
    sudo cp $wall_src /usr/share/sddm/themes/caelestia/assets/background
    sudo cp $wall_src /usr/share/sddm/themes/caelestia/assets/background.png

    # 2. Copiar Foto de Perfil / Avatar (B.jpg)
    sudo cp $avatar_src /usr/share/sddm/themes/caelestia/assets/avatar.jpg
    sudo cp $avatar_src /usr/share/sddm/faces/mohamed.face.icon

    # 3. Corregir permisos globales para que SDDM pueda leerlos
    sudo chmod 644 /usr/share/sddm/themes/caelestia/background.png
    sudo chmod 644 /usr/share/sddm/themes/caelestia/assets/background*
    sudo chmod 644 /usr/share/sddm/themes/caelestia/assets/avatar.jpg
    sudo chmod 644 /usr/share/sddm/faces/mohamed.face.icon

    # 4. Inyectar la paleta de colores hexadecimales al theme.conf según el color
    switch $color_input
        case BEIGE
            echo "Aplicando paleta Beige Cálida..."
            sudo sed -i 's/^background=.*/background=#12110e/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#1c1a16/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#292620/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#f5f0e6/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#c2bba8/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#d4af37/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case BLACK
            echo "Aplicando paleta Monocromática (Blanco y Negro)..."
            sudo sed -i 's/^background=.*/background=#000000/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#0a0a0a/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#121212/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#ffffff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#aaaaaa/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#ffffff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case BLUE
            echo "Aplicando paleta Azul Gojo / Ciano..."
            sudo sed -i 's/^background=.*/background=#020813/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#081226/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#0f1f3d/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#e0f0ff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#7da2d6/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#3399ff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case GREEN
            echo "Aplicando paleta Verde Menta Oscuro..."
            sudo sed -i 's/^background=.*/background=#020f08/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#081f12/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#12331f/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#e2ffe9/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#82ba95/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#39ff14/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case PURPLE
            echo "Aplicando paleta Violeta Neon / Void..."
            sudo sed -i 's/^background=.*/background=#090212/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#150826/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#25123d/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#f5e6ff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#ab82ba/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#b026ff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case RED
            echo "Aplicando paleta Carmesí Sangre..."
            sudo sed -i 's/^background=.*/background=#0a0202/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#120505/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#1c0a0a/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#ffcccc/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#aa6666/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#ff3333/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf
    end

    echo "¡Estructura cambiada con éxito! Reiniciando la pantalla de bloqueo..."
    sudo systemctl restart sddm
end
