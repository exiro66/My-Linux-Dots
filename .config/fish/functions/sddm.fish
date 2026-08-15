function sddm --description "Gestor maestro de temas, colores, wallpapers y avatares para SDDM Caelestia"
    if test (count $argv) -lt 1; or test (count $argv) -gt 2
        echo "Uso: sddm [beige | black | blue | green | purple | red | orange | pink | white | yellow] [--no-restart]"
        return 1
    end

    set color_input (string upper $argv[1])
    set base_dir "$HOME/SDDM/$color_input"
    set wall_src "$base_dir/A.jpg"
    set avatar_src "$base_dir/B.jpg"

    if not test -f $wall_src; or not test -f $avatar_src
        echo "Error: No se encontraron los archivos necesarios en $base_dir/"
        echo "Asegúrate de tener la carpeta $base_dir con 'A.jpg' y 'B.jpg'"
        return 1
    end

    echo "Configurando entorno SDDM en modo: $color_input..."

    sudo cp $wall_src /usr/share/sddm/themes/caelestia/background.png
    sudo cp $wall_src /usr/share/sddm/themes/caelestia/assets/background
    sudo cp $wall_src /usr/share/sddm/themes/caelestia/assets/background.png

    sudo cp $avatar_src /usr/share/sddm/themes/caelestia/assets/avatar.jpg
    sudo cp $avatar_src /usr/share/sddm/faces/$USER.face.icon

    sudo chmod 644 /usr/share/sddm/themes/caelestia/background.png
    sudo chmod 644 /usr/share/sddm/themes/caelestia/assets/background*
    sudo chmod 644 /usr/share/sddm/themes/caelestia/assets/avatar.jpg
    sudo chmod 644 /usr/share/sddm/faces/$USER.face.icon

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

        case ORANGE
            echo "Aplicando paleta Naranja Ámbar / Cyberpunk..."
            sudo sed -i 's/^background=.*/background=#0f0601/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#1a0c03/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#2b1406/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#ffe0cc/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#ba8e74/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#ff6600/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case WHITE
            echo "Aplicando paleta Blanco Tiza / Minimalista..."
            sudo sed -i 's/^background=.*/background=#050505/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#0f0f0f/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#1a1a1a/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#fbfbfb/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#999999/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#e5e5e5/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case PINK
            echo "Aplicando paleta Rosa Fucsia / Neon-Noir..."
            sudo sed -i 's/^background=.*/background=#0f020a/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#1f0514/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#330d24/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#ffe6f5/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#ba7aa1/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#ff007f/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case YELLOW
            echo "Aplicando paleta Amarillo Eléctrico / Cyberpunk..."
            sudo sed -i 's/^background=.*/background=#0d0d02/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#1a1a05/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#2b2b0a/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#ffffe6/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#baba7a/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#ccff00/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case '*'
            echo "Error: Color no reconocido: $color_input"
            return 1
    end

    echo "Tema $color_input aplicado correctamente."

    if test "$argv[2]" = "--no-restart"
        echo "Cambios aplicados sin reiniciar SDDM."
    else
        echo "Reiniciando la pantalla de bloqueo..."
        sudo systemctl restart sddm
    end
end
