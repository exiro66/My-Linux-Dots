function icons --description "Cambia el color de las carpetas de Papirus-Dark desde la terminal"
    if test (count $argv) -ne 1
        echo "Uso: icons [gris | rojo | azul | verde | beige | violeta]"
        return 1
    end

    set color_elegido $argv

    # Mapeo inteligente con los nombres exactos de papirus-folders
    switch $color_elegido
        case gris
            set color_papirus grey
        case rojo
            set color_papirus carmine   # Cambiado el "red" chillón por el rojo oscuro "carmine"
        case azul
            set color_papirus blue
        case verde
            set color_papirus green
        case beige
            set color_papirus palebrown # El beige/marrón claro de Papirus
        case violeta
            set color_papirus violet
        case '*'
            # Permite meter cualquier otro color nativo en inglés si quieres (ej: black, cyan)
            set color_papirus $color_elegido
    end

    echo "Cambiando carpetas Papirus al color: $color_elegido ($color_papirus)..."
    
    # 1. Cambiar el color de los directorios a nivel de sistema
    sudo papirus-folders -C $color_papirus --theme Papirus-Dark

    # 2. Refrescar la caché de iconos de GTK
    gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

    echo "¡Listo! Carpetas actualizadas con éxito."
end
