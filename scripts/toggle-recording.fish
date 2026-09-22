#!/usr/bin/env fish
# Toggle grabación con gpu-screen-recorder (cierre robusto)
# SUPER+G: si graba, para. Si no, pregunta pantalla + audio y graba.

set RECORDING_DIR ~/Vídeos/Grabaciones
set LOCK_FILE /tmp/gsr-recording.lock

mkdir -p $RECORDING_DIR

# Detectar si ya hay una grabación corriendo
set running (pgrep -f gpu-screen-recorder)

if test -n "$running"
    # === PARAR GRABACIÓN ===
    echo "Deteniendo grabación..."

    # 1. SIGINT para cierre limpio (guarda el vídeo)
    pkill -SIGINT -f gpu-screen-recorder
    sleep 1.5

    # 2. Si sigue vivo, SIGTERM
    if pgrep -f gpu-screen-recorder > /dev/null
        pkill -SIGTERM -f gpu-screen-recorder
        sleep 1
    end

    # 3. Último recurso: SIGKILL
    if pgrep -f gpu-screen-recorder > /dev/null
        pkill -SIGKILL -f gpu-screen-recorder
    end

    # 4. Matar ffmpeg huérfano
    pkill -SIGKILL -f ffmpeg 2>/dev/null

    rm -f $LOCK_FILE
    notify-send "Grabación detenida" "Guardado en $RECORDING_DIR"
    echo "Grabación detenida"
else
    # === ELEGIR PANTALLA (preselecciona la del cursor) ===
    set focused (hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')
    set st_edp off
    test "$focused" = "eDP-1"; and set st_edp on
    set st_hdmi off
    test "$focused" = "HDMI-A-1"; and set st_hdmi on

    set screen (kdialog --title "Grabar pantalla" --radiolist "¿Qué pantalla grabo?" \
        eDP-1 "Portátil (eDP-1)" $st_edp \
        HDMI-A-1 "Externa (HDMI-A-1)" $st_hdmi \
        ambas "Ambas pantallas" off)
    or return 0
    test -z "$screen"; and return 0

    # === ELEGIR AUDIO ===
    set audio (kdialog --title "Grabar pantalla" --checklist "¿Qué audio grabo?" \
        sistema "Sonido del sistema" on \
        microfono "Micrófono" off)
    or return 0

    set use_system 0
    set use_mic 0
    string match -q "*sistema*" -- "$audio"; and set use_system 1
    string match -q "*microfono*" -- "$audio"; and set use_mic 1

    set sink (pactl get-default-sink 2>/dev/null)
    set source (pactl get-default-source 2>/dev/null)
    set audio_flags
    if test $use_system -eq 1 -a -n "$sink"
        set -a audio_flags -a "$sink.monitor"
    end
    if test $use_mic -eq 1 -a -n "$source"
        set -a audio_flags -a "$source"
    end

    # === OBJETIVO ===
    set timestamp (date +%Y%m%d-%H%M%S)
    if test "$screen" = "ambas"
        set target -w region -region 3840x1080+0+0 -s 3840x1080
        set tag "ambas"
    else
        set target -w $screen -s 1920x1080
        set tag $screen
    end
    set output_file "$RECORDING_DIR/grabacion-$timestamp-$tag.mp4"

    gpu-screen-recorder $target -f 60 $audio_flags -cursor yes -o $output_file &
    echo $last_pid > $LOCK_FILE

    set desc "$tag"
    test $use_system -eq 1; and set desc "$desc + sistema"
    test $use_mic -eq 1; and set desc "$desc + micro"
    test $use_system -eq 0 -a $use_mic -eq 0; and set desc "$tag (sin audio)"
    notify-send "Grabación iniciada" "$desc"
    echo "Grabación iniciada: $output_file [$desc]"
end
