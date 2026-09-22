pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import "../core"

// Tiling layout (dwindle | master | scrolling | monocle) — the same four
// the keybinds cycle through. Reading is a plain hyprctl call; writing goes
// through `hyprctl eval` because this Hyprland speaks the Lua grammar and
// plain dispatchers parse-error there.
QtObject {
    id: lay

    // Set true by the Command Center while it is visible.
    property bool polling: false

    readonly property var layouts: [
        { name: "Dwindle", value: "dwindle" },
        { name: "Master", value: "master" },
        { name: "Scrollable", value: "scrolling" },
        { name: "Monocle", value: "monocle" }
    ]
    property string current: ""

    readonly property string currentLabel: {
        for (var i = 0; i < layouts.length; i++)
            if (layouts[i].value === lay.current)
                return layouts[i].name;
        return lay.current.length ? lay.current.charAt(0).toUpperCase() + lay.current.slice(1) : "";
    }

    function set(value) {
        // Optimistic: paint at once, the poll confirms right after.
        current = value;
        _run(["hyprctl", "eval", "hl.config({ general = { layout = \"" + value + "\" } })"]);
    }

    // One action at a time (see Net._run for why).
    property Process _action: Process {
        onExited: {
            lay._actionBusy = false;
            lay._settle.restart();
        }
    }
    property bool _actionBusy: false

    function _run(cmd) {
        if (_actionBusy)
            return;
        _actionBusy = true;
        _action.command = cmd;
        _action.running = true;
        _settle.restart();
    }
    property Timer _settle: Timer {
        interval: 800
        onTriggered: lay.refresh()
    }

    // ── polling ─────────────────────────────────────────────────
    function refresh() {
        if (!_probe.running)
            _probe.running = true;
    }

    property Timer _tick: Timer {
        interval: 5000
        repeat: true
        running: lay.polling
        triggeredOnStart: true
        onTriggered: lay.refresh()
    }

    property Process _probe: Process {
        command: ["hyprctl", "getoption", "general:layout", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    var doc = JSON.parse("" + text);
                    if (doc && doc.str)
                        lay.current = doc.str;
                } catch (e) {}
            }
        }
    }
}
