function ahorro --description "Modo Ahorro de Energía Máximo"
    echo "Modo AHORRO activado. Bajando revoluciones..."
    sudo powerprofilesctl set power-saver
end
