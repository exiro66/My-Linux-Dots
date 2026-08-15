function icons --description "Cambia el color de las carpetas de Papirus-Dark desde la terminal"
    if test (count $argv) -ne 1
        echo "Uso: icons [grey | red | carmine | blue | green | palebrown | violet | black | white | yellow | orange | pink | cyan | magenta | indigo | brown]"
        return 1
    end

    set color_elegido $argv

    switch $color_elegido
        case grey red carmine blue green palebrown violet black white yellow orange pink cyan magenta indigo brown
            set color_papirus $color_elegido
        case '*'
            echo "Error: Color no reconocido: $color_elegido"
            return 1
    end

    echo "Cambiando carpetas Papirus al color: $color_papirus..."

    sudo papirus-folders -C $color_papirus --theme Papirus-Dark

    gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

    echo "¡Listo! Carpetas actualizadas con éxito."
end
