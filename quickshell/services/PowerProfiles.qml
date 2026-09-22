pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import "../core"

// Power profiles (power-profiles-daemon) plus battery level. Polled rather
// than pushed, like Net: the Command Center only needs a refresh while it
// is actually open (see `polling`).
//
// The tile hides itself when power-profiles-daemon is absent.
QtObject {
    id: pp

    // Set true by the Command Center while it is visible.
    property bool polling: false

    property bool available: false
    // performance | balanced | power-saver
    property string profile: ""
    property int percent: -1
    property string state: ""

    readonly property var profiles: ["balanced", "performance", "power-saver"]

    function labelOf(p) {
        if (p === "power-saver")
            return "Power saver";
        return p.charAt(0).toUpperCase() + p.slice(1);
    }
    function iconOf(p) {
        if (p === "performance")
            return Icons.rocket;
        if (p === "power-saver")
            return Icons.leaf;
        return Icons.balance;
    }

    // What the tile shows underneath "Battery".
    readonly property string summary: {
        var bat = pp.percent >= 0 ? pp.percent + "%" : "";
        var prof = pp.profile.length ? pp.labelOf(pp.profile) : "";
        if (bat.length && prof.length)
            return bat + " · " + prof;
        return bat + prof;
    }

    function setProfile(p) {
        _run(["powerprofilesctl", "set", p]);
    }

    // One action at a time (see Net._run for why).
    property Process _action: Process {
        onExited: {
            pp._actionBusy = false;
            pp._settle.restart();
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
        interval: 1200
        onTriggered: pp.refresh()
    }

    // ── polling ─────────────────────────────────────────────────
    function refresh() {
        if (!_probe.running)
            _probe.running = true;
    }

    property Timer _tick: Timer {
        interval: 8000
        repeat: true
        running: pp.polling
        triggeredOnStart: true
        onTriggered: pp.refresh()
    }

    property Process _probe: Process {
        command: ["sh", "-c", "powerprofilesctl get; echo ---BAT---; upower -i $(upower -e 2>/dev/null | grep battery | head -1) 2>/dev/null"]
        stdout: StdioCollector {
            onStreamFinished: pp._parse(text)
        }
        onExited: code => {
            if (code !== 0)
                pp.available = false;
        }
    }

    function _parse(text) {
        var section = "profile";
        var profile = "";
        var percent = -1;
        var state = "";
        var lines = ("" + text).split("\n");
        for (var i = 0; i < lines.length; i++) {
            var line = lines[i].trim();
            if (line === "---BAT---") {
                section = "battery";
                continue;
            }
            if (!line.length)
                continue;
            if (section === "profile") {
                if (!profile.length)
                    profile = line;
            } else {
                if (line.indexOf("percentage:") === 0)
                    percent = parseInt(line.split(":")[1], 10);
                else if (line.indexOf("state:") === 0)
                    state = line.split(":")[1].trim();
            }
        }
        if (!profile.length || profile.indexOf(" ") >= 0) {
            pp.available = false;
            return;
        }
        pp.available = true;
        pp.profile = profile;
        pp.percent = isNaN(percent) ? -1 : percent;
        pp.state = state;
    }
}
