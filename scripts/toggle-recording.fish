#!/usr/bin/env fish
# Toggle grabación de pantalla con wf-recorder

set RECORDING_DIR ~/Vídeos/Grabaciones
set PID_FILE /tmp/wf-recorder.pid

mkdir -p $RECORDING_DIR

if test -f $PID_FILE
    # Ya está grabando → parar
    echo "Deteniendo grabación..."
    
    # Matar wf-recorder con SIGINT (cierre limpio)
    pkill -SIGINT wf-recorder
    
    # Esperar a que cierre
    sleep 1
    
    # Si sigue vivo, matar con SIGTERM
    pkill -SIGTERM wf-recorder 2>/dev/null
    
    # Esperar más
    sleep 1
    
    # Si aún sigue, matar con SIGKILL
    pkill -SIGKILL wf-recorder 2>/dev/null
    
    rm -f $PID_FILE
    notify-send "Grabación detenida" "Guardado en $RECORDING_DIR"
    echo "Grabación detenida"
else
    # No está grabando → empezar
    set timestamp (date +%Y%m%d-%H%M%S)
    set output_file "$RECORDING_DIR/grabacion-$timestamp.mp4"
    
    # Grabar el monitor enfocado con aceleración por hardware
    set monitor (hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')
    wf-recorder -o $monitor -c h264_vaapi -f $output_file &
    echo $last_pid > $PID_FILE
    notify-send "Grabación iniciada" "Grabando en $output_file"
    echo "Grabación iniciada: $output_file"
end
