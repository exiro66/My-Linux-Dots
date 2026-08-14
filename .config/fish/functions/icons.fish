function icons --description "Cambia el color de las carpetas de Papirus-Dark desde la terminal"
    if test (count $argv) -ne 1
        echo "Uso: icons [gris | rojo | rojo-oscuro | azul | verde | beige | violeta | negro | blanco | amarillo | naranja | rosa | cian | magenta | indigo | marron]"
        return 1
    end

    set color_elegido $argv

    # Mapeo inteligente con los nombres exactos de papirus-folders
    switch $color_elegido
        case gris
            set color_papirus grey
        case rojo
            set color_papirus red
        case rojo-oscuro
            set color_papirus carmine
        case azul
            set color_papirus blue
        case verde
            set color_papirus green
        case beige
            set color_papirus palebrown
        case violeta
            set color_papirus violet
        case negro
            set color_papirus black
        case blanco
            set color_papirus white
        case amarillo
            set color_papirus yellow
        case naranja
            set color_papirus orange
        case rosa
            set color_papirus pink
        case cian
            set color_papirus cyan
        case magenta
            set color_papirus magenta
        case indigo
            set color_papirus indigo
        case marron
            set color_papirus brown
        case '*'
            echo "Error: Color no reconocido: $color_elegido"
            return 1
    end

    echo "Cambiando carpetas Papirus al color: $color_elegido ($color_papirus)..."

    # 1. Cambiar el color de los directorios a nivel de sistema
    sudo papirus-folders -C $color_papirus --theme Papirus-Dark

    # 2. Refrescar la caché de iconos de GTK
    gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

    echo "¡Listo! Carpetas actualizadas con éxito."
end
