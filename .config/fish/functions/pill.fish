function pill --description "Adjust pill width, height and border thickness"
    set config ~/.config/quickshell/pill/Pill.qml

    read -P "Pill width (e.g. 105): " ancho
    read -P "Pill height (e.g. 35): " alto
    read -P "Border thickness (0 for none): " grosor

    sed -i "s/readonly property real restW: .*/readonly property real restW: $ancho * s/" $config
    sed -i "s/readonly property real restH: .*/readonly property real restH: $alto * s/" $config
    sed -i "s/border.width: .*/border.width: $grosor/" $config
end
