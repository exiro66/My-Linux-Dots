function pill --description "Ajustar ancho, alto y grosor del borde de la pill"
    set config ~/.config/quickshell/pill/Pill.qml

    read -P "Ancho de la pill (ej: 128): " ancho
    read -P "Alto de la pill (ej: 36): " alto
    read -P "Grosor del borde (0 para sin borde): " grosor

    sed -i "s/readonly property real restW: .*/readonly property real restW: $ancho * s/" $config
    sed -i "s/readonly property real restH: .*/readonly property real restH: $alto * s/" $config
    sed -i "s/border.width: .*/border.width: $grosor/" $config

end
