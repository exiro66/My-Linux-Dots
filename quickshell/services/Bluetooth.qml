pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import "../core"

// Bluetooth state via bluetoothctl. Polled rather than pushed, like Net:
// the Command Center only needs a refresh while it is actually open (see
// `polling`).
//
// One probe round gives everything: controller state, the paired list and
// the connected set. Pairing itself needs an agent and a terminal, so the
// UI deliberately offers only what works headless — power plus
// connect/disconnect for already-paired devices.
QtObject {
    id: bt

    // Set true by the Command Center while it is visible.
    property bool polling: false

    // False when there is no adapter (or no bluetoothctl at all): the tile
    // hides itself, like every other capability tile.
    property bool available: false
    property bool powered: false
    // [{ name, mac, connected }]
    property var devices: []

    readonly property var _connected: {
        var out = [];
        for (var i = 0; i < devices.length; i++)
            if (devices[i].connected)
                out.push(devices[i]);
        return out;
    }

    // What the tile shows underneath "Bluetooth".
    readonly property string summary: {
        if (!available)
            return "No adapter";
        if (!powered)
            return "Off";
        if (_connected.length === 0)
            return "On · idle";
        var names = [];
        for (var i = 0; i < _connected.length; i++)
            names.push(_connected[i].name);
        return names.join(", ");
    }

    function togglePower() {
        if (!available)
            return;
        _run(["bluetoothctl", "power", powered ? "off" : "on"]);
    }

    function toggleDevice(dev) {
        if (!dev)
            return;
        _run(["bluetoothctl", dev.connected ? "disconnect" : "connect", dev.mac]);
    }

    // One bluetoothctl action at a time. Restarting a Process that is still
    // running is how two changes end up racing, with the slower one
    // reporting last and the UI settling on the wrong state.
    property Process _action: Process {
        onExited: {
            bt._actionBusy = false;
            bt._settle.restart();
        }
    }
    property bool _actionBusy: false

    function _run(cmd) {
        if (_actionBusy)
            return;
        _actionBusy = true;
        _action.command = cmd;
        _action.running = true;
        // Give BlueZ a beat to settle, then re-read.
        _settle.restart();
    }
    property Timer _settle: Timer {
        interval: 1200
        onTriggered: bt.refresh()
    }

    // ── polling ─────────────────────────────────────────────────
    function refresh() {
        if (!_probe.running)
            _probe.running = true;
    }

    property Timer _tick: Timer {
        interval: 5000
        repeat: true
        running: bt.polling
        triggeredOnStart: true
        onTriggered: bt.refresh()
    }

    property Process _probe: Process {
        command: ["sh", "-c", "bluetoothctl show; echo ---PAIRED---; bluetoothctl devices; echo ---CONNECTED---; bluetoothctl devices Connected"]
        stdout: StdioCollector {
            onStreamFinished: bt._parse(text)
        }
    }

    function _parse(text) {
        var section = "show";
        var powered = false;
        var foundController = false;
        var paired = [];
        var connected = {};
        var lines = ("" + text).split("\n");
        for (var i = 0; i < lines.length; i++) {
            var line = lines[i].trim();
            if (line === "---PAIRED---") {
                section = "paired";
                continue;
            }
            if (line === "---CONNECTED---") {
                section = "connected";
                continue;
            }
            if (section === "show") {
                if (line.indexOf("Controller ") === 0)
                    foundController = true;
                if (line.indexOf("Powered:") === 0)
                    powered = line.split(":")[1].trim() === "yes";
            } else {
                // "Device MAC Name with spaces"
                var m = line.match(/^Device\s+([0-9A-Fa-f:]{17})\s+(.*)$/);
                if (!m)
                    continue;
                if (section === "paired")
                    paired.push({
                        name: m[2],
                        mac: m[1],
                        connected: false
                    });
                else
                    connected[m[1]] = true;
            }
        }
        // No controller (or no bluetoothctl at all): every section is empty.
        bt.available = foundController;
        if (!foundController) {
            bt.powered = false;
            bt.devices = [];
            return;
        }
        bt.powered = powered;
        for (var j = 0; j < paired.length; j++)
            paired[j].connected = connected[paired[j].mac] === true;
        bt.devices = paired;
    }
}
