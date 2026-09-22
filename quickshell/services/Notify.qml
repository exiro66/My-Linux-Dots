pragma Singleton

import QtQuick
import "../core"

// Do-Not-Disturb and notification history, fed by the in-process
// NotificationServer in shell.qml (which owns org.freedesktop.Notifications
// instead of dunst, so live notifications render in the notch).
//
// Same public surface the pages already use: `paused`, `history`,
// `historyCount`, `toggle()`, `clearHistory()`. `push()` is the bridge's
// entry point; everything else is local state, so nothing here can fail
// when a helper binary is missing.
QtObject {
    id: notify

    // Kept so CommandCenter's `Notify.polling = …` assignment still lands.
    // The store is push-driven; nothing polls.
    property bool polling: false

    // False until the NotificationServer actually owns the bus (see shell).
    property bool serverUp: false
    readonly property bool available: serverUp

    property bool paused: false
    // [{ id, summary, body, app, timestamp }], newest first, capped.
    property var history: []
    readonly property int historyCount: history.length

    function toggle() {
        notify.paused = !notify.paused;
    }
    function setPaused(v) {
        notify.paused = v === true;
    }
    function clearHistory() {
        notify.history = [];
    }

    function push(rec) {
        var rows = notify.history.slice();
        // A replacement (progress updates and the like) edits in place
        // instead of stacking duplicates.
        for (var i = 0; i < rows.length; i++) {
            if (rows[i].id === rec.id) {
                rows[i] = rec;
                notify.history = rows;
                return;
            }
        }
        rows.unshift(rec);
        notify.history = rows.slice(0, 40);
    }
}
