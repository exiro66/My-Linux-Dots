pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import "../core"

// Screen brightness via brightnessctl, mirroring the volume slider's shape:
// a 0..1 value plus set(). Polled while the sheet is open. Hides itself
// when brightnessctl (or a backlight) is absent.
QtObject {
    id: bri

    // Set true by the Command Center while it is visible.
    property bool polling: false

    property bool available: false
    // 0..1
    property real level: 0

    function set(v) {
        // Optimistic: the slider follows the finger, the daemon confirms.
        level = Config.clamp(v, 0.05, 1);
        var pct = Math.round(level * 100);
        _run(["brightnessctl", "set", pct + "%"]);
    }

    // One action at a time (see Net._run for why).
    property Process _action: Process {
        onExited: {
            bri._actionBusy = false;
            bri._settle.restart();
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
        interval: 250
        onTriggered: bri.refresh()
    }

    // ── polling ─────────────────────────────────────────────────
    function refresh() {
        if (!_probe.running)
            _probe.running = true;
    }

    property Timer _tick: Timer {
        interval: 5000
        repeat: true
        running: bri.polling
        triggeredOnStart: true
        onTriggered: bri.refresh()
    }

    property Process _probe: Process {
        command: ["sh", "-c", "brightnessctl get; brightnessctl max"]
        stdout: StdioCollector {
            onStreamFinished: {
                var lines = ("" + text).split("\n");
                var cur = parseInt(lines.length > 0 ? lines[0] : "", 10);
                var max = parseInt(lines.length > 1 ? lines[1] : "", 10);
                if (isNaN(cur) || isNaN(max) || max <= 0) {
                    bri.available = false;
                    return;
                }
                bri.available = true;
                bri.level = Config.clamp(cur / max, 0, 1);
            }
        }
        onExited: code => {
            if (code !== 0)
                bri.available = false;
        }
    }
}
