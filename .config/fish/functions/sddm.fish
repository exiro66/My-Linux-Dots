function sddm --description "Gestor maestro de temas, colores, wallpapers y avatares para SDDM Caelestia"
    if test (count $argv) -lt 1; or test (count $argv) -gt 2
        echo "Uso: sddm [beige | black | blue | green | purple | red | orange | pink | white | yellow...etc] [--no-restart]"
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
        case BLACK
            echo "Applying black..."
            sudo sed -i 's/^background=.*/background=#000000/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#0a0a0a/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#1a1a1a/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#ffffff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#b3b3b3/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textLight=.*/textLight=#ffffff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#ffffff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^secondary=.*/secondary=#cccccc/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onSecondary=.*/onSecondary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surface=.*/surface=#0a0a0a/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onSurface=.*/onSurface=#ffffff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^error=.*/error=#ff5555/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onError=.*/onError=#000000/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^outline=.*/outline=#333333/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^shadow=.*/shadow=#000000/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^hover=.*/hover=#ffffff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^success=.*/success=#cccccc/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^warning=.*/warning=#b3b3b3/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^inverseOnSurface=.*/inverseOnSurface=#ffffff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i '543s/#e2e2e2/#ffffff/' /usr/share/sddm/themes/caelestia/Main.qml
            sudo sed -i 's/#a8a8a8/#ffffff/g' /usr/share/sddm/themes/caelestia/components/PasswordInput.qml

        case WHITE
            echo "Applying white..."

            sudo sed -i 's/^background=.*/background=#ffffff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#f5f5f5/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#e0e0e0/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#000000/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#000000/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textLight=.*/textLight=#333333/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#ffffff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^secondary=.*/secondary=#333333/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onSecondary=.*/onSecondary=#ffffff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surface=.*/surface=#f5f5f5/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onSurface=.*/onSurface=#000000/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^error=.*/error=#cc3333/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onError=.*/onError=#ffffff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^outline=.*/outline=#cccccc/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^shadow=.*/shadow=#000000/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^hover=.*/hover=#000000/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^success=.*/success=#333333/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^warning=.*/warning=#666666/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^inverseOnSurface=.*/inverseOnSurface=#000000/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i '543s/#e2e2e2/#000000/' /usr/share/sddm/themes/caelestia/Main.qml
            sudo sed -i 's/#a8a8a8/#000000/g' /usr/share/sddm/themes/caelestia/components/PasswordInput.qml

        case BEIGE
            echo "Applying beige..."
            sudo sed -i 's/^background=.*/background=#12110e/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#1c1a16/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#292620/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#f5f0e6/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#c2bba8/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#d4af37/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case BLUE
            echo "Applying blue..."
            sudo sed -i 's/^background=.*/background=#020813/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#081226/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#0f1f3d/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#e0f0ff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#7da2d6/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#3399ff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case GREEN
            echo "Applying green..."
            sudo sed -i 's/^background=.*/background=#020f08/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#081f12/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#12331f/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#e2ffe9/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#82ba95/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#39ff14/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case PURPLE
            echo "Applying purple..."
            sudo sed -i 's/^background=.*/background=#090212/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#150826/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#25123d/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#f5e6ff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#ab82ba/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#b026ff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case RED
            echo "Applying red..."
            sudo sed -i 's/^background=.*/background=#0a0202/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#120505/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#1c0a0a/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#ffcccc/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#aa6666/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#ff3333/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case ORANGE
            echo "Applying orange..."
            sudo sed -i 's/^background=.*/background=#0f0601/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#1a0c03/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#2b1406/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#ffe0cc/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#ba8e74/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#ff6600/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case PINK
            echo "Applying pink..."
            sudo sed -i 's/^background=.*/background=#0f020a/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#1f0514/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#330d24/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#ffe6f5/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#ba7aa1/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#ff007f/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case YELLOW
            echo "Applying yellow..."
            sudo sed -i 's/^background=.*/background=#0d0d02/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#1a1a05/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#2b2b0a/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#ffffe6/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#baba7a/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#ccff00/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#000000/' /usr/share/sddm/themes/caelestia/theme.conf

        case GRUVBOX
            echo "Applying gruvbox material..."
            sudo sed -i 's/^background=.*/background=#32302f/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#3c3836/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#504945/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#ddc7a1/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#a89984/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#a9b665/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#32302f/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^secondary=.*/secondary=#e78a4e/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onSecondary=.*/onSecondary=#32302f/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^tertiary=.*/tertiary=#89b482/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onTertiary=.*/onTertiary=#32302f/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^inverseOnSurface=.*/inverseOnSurface=#ddc7a1/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surface=.*/surface=#32302f/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surfaceVariant=.*/surfaceVariant=#3c3836/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surfaceContainerLow=.*/surfaceContainerLow=#282828/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surfaceContainer=.*/surfaceContainer=#32302f/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surfaceContainerHigh=.*/surfaceContainerHigh=#3c3836/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^outline=.*/outline=#504945/' /usr/share/sddm/themes/caelestia/theme.conf

        case LAVENDER
            echo "Applying lavender..."
            sudo sed -i 's/^background=.*/background=#181926/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#1e2030/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#24273a/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#cad3f5/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#a5adcb/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#b7bdf8/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#1e2030/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^secondary=.*/secondary=#8aadf4/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onSecondary=.*/onSecondary=#1e2030/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^tertiary=.*/tertiary=#f5bde6/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onTertiary=.*/onTertiary=#1e2030/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^inverseOnSurface=.*/inverseOnSurface=#cad3f5/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surface=.*/surface=#24273a/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surfaceVariant=.*/surfaceVariant=#363a4f/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surfaceContainerLow=.*/surfaceContainerLow=#181926/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surfaceContainer=.*/surfaceContainer=#1e2030/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surfaceContainerHigh=.*/surfaceContainerHigh=#24273a/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^outline=.*/outline=#494d64/' /usr/share/sddm/themes/caelestia/theme.conf

        case HEXA
            echo "Applying Hexa34C..."
            sudo sed -i 's/^background=.*/background=#101510/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#101510/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#414941/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#dfe4dc/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#c1c9be/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#9ad4a1/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#003916/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^secondary=.*/secondary=#b7ccb6/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onSecondary=.*/onSecondary=#233425/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^tertiary=.*/tertiary=#a1ced8/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onTertiary=.*/onTertiary=#00363e/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^inverseOnSurface=.*/inverseOnSurface=#dfe4dc/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surface=.*/surface=#101510/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surfaceVariant=.*/surfaceVariant=#101510/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surfaceContainerLow=.*/surfaceContainerLow=#101510/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surfaceContainer=.*/surfaceContainer=#101510/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surfaceContainerHigh=.*/surfaceContainerHigh=#414941/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^outline=.*/outline=#8b9389/' /usr/share/sddm/themes/caelestia/theme.conf

        case STARS
            echo "Applying stars..."
            sudo sed -i 's/^background=.*/background=#0A1126/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^mainCard=.*/mainCard=#0F1B40/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^subComponents=.*/subComponents=#152850/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^text=.*/text=#e0e6f5/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^textDark=.*/textDark=#99B6F2/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^primary=.*/primary=#99B6F2/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onPrimary=.*/onPrimary=#0A1126/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^secondary=.*/secondary=#5581D9/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onSecondary=.*/onSecondary=#ffffff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^tertiary=.*/tertiary=#4E6BA6/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^onTertiary=.*/onTertiary=#ffffff/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^inverseOnSurface=.*/inverseOnSurface=#e0e6f5/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surface=.*/surface=#0A1126/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surfaceVariant=.*/surfaceVariant=#0F1B40/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surfaceContainerLow=.*/surfaceContainerLow=#0A1126/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surfaceContainer=.*/surfaceContainer=#0F1B40/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^surfaceContainerHigh=.*/surfaceContainerHigh=#152850/' /usr/share/sddm/themes/caelestia/theme.conf
            sudo sed -i 's/^outline=.*/outline=#2a4a7a/' /usr/share/sddm/themes/caelestia/theme.conf

        case '*'
            echo "Error: Color no reconocido: $color_input"
            return 1
    end

    echo "Tema $color_input aplicado correctamente."

    if test "$argv[2]" = --no-restart
        echo "Cambios aplicados sin reiniciar SDDM."
    else
        echo "Reiniciando la pantalla de bloqueo..."
        sudo systemctl restart sddm
    end
end
