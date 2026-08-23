function bar --description "Adjust expanded bar size"
    set config ~/.config/quickshell/pill/Pill.qml

    read -P "Bar width (min 500): " ancho
    read -P "Bar height (min 40): " alto

    if test "$ancho" -lt 500
        set ancho 500
    end

    if test "$alto" -lt 40
        set alto 40
    end

    sed -i "s/readonly property real hoverW: .*/readonly property real hoverW: $ancho * s/" $config
    sed -i "s/readonly property real hoverH: .*/readonly property real hoverH: $alto * s/" $config
end
