function toggle-panel --description "Alternar panel de workspaces"
    if pgrep -f "quickshell.*panel" > /dev/null
        pkill -f "quickshell.*panel"
    else
        quickshell -p ~/.config/quickshell/panel/workspaces.qml &
    end
end
