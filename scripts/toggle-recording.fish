#!/usr/bin/env fish
# Toggle grabación de pantalla con gpu-screen-recorder

set RECORDING_DIR ~/Vídeos/Grabaciones
set PID_FILE /tmp/gsr.pid

mkdir -p $RECORDING_DIR

if test -f $PID_FILE
    # Ya está grabando → parar
    set pid (cat $PID_FILE)
    kill -SIGINT $pid 2>/dev/null
    sleep 1
    pkill -SIGTERM gpu-screen-recorder 2>/dev/null
    rm -f $PID_FILE
    notify-send "Grabación detenida" "Guardado en $RECORDING_DIR"
    echo "Grabación detenida"
else
    # No está grabando → empezar
    set timestamp (date +%Y%m%d-%H%M%S)
    set output_file "$RECORDING_DIR/grabacion-$timestamp.mp4"
    
    # Detectar el monitor enfocado
    set monitor (hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')
    
    gpu-screen-recorder -w $monitor -s 1920x1080 -f 60 -cursor yes -o $output_file &
    echo $last_pid > $PID_FILE
    notify-send "Grabación iniciada" "Grabando en $output_file"
    echo "Grabación iniciada: $output_file"
end
