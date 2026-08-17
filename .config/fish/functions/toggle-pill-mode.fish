function toggle-pill-mode --description "Alterna entre modo notch y dynamic island"
    set mode_file ~/.cache/ricelin/pill-mode

    if test -f $mode_file
        set mode (cat $mode_file)
    else
        set mode "notch"
    end

    if test "$mode" = "notch"
        set new_mode "dynamic"
    else
        set new_mode "notch"
    end

    echo $new_mode > $mode_file
    ~/.config/hypr/scripts/ricelin restart pill
end
