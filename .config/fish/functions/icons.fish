function icons --description "Cambiar color de Tela-circle"
    if test (count $argv) -ne 1
        echo "Uso: icons [black | blue | brown | green | grey | orange | pink | purple | red | yellow]"
        return 1
    end

    set color $argv[1]

    switch $color
        case black blue brown green grey orange pink purple red yellow
            gsettings set org.gnome.desktop.interface icon-theme "Tela-circle-$color-dark"
        case '*'
            echo "Color no válido"
            return 1
    end
end
