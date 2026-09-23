import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick
import "components"
import "components/launcher"
import "core"
import "services"

// NotchShell — entry point.
//
// Three things go on screen and nothing else: one notch overlay per monitor,
// one launcher window on the focused monitor, and the IPC handlers that the
// Hyprland keybinds poke. All behaviour lives in the singletons (Config,
// Theme, UiState, CenterNav, Launcher) and in components/.
ShellRoot {
    // System events → transient notch statuses.
    EventBridge {}

    Variants {
        model: Quickshell.screens

        delegate: NotchWindow {}
    }

    Variants {
        model: Quickshell.screens

        delegate: NotchReserve {}
    }

    // The launchers are a single window that follows the focused monitor,
    // not one per screen: only one of them can have the keyboard.
    LauncherWindow {}

    // ── notifications ──────────────────────────────────────────
    // This shell owns org.freedesktop.Notifications (no dunst): live
    // notifications render in the notch, history feeds Notify.
    NotificationServer {
        id: notifServer
        actionsSupported: false
        // Sin señal de registro en esta versión: se asume el bus (dunst
        // está detenido en esta prueba) y Quickshell reintenta solo si el
        // nombre está ocupado.
        Component.onCompleted: Notify.serverUp = true

        onNotification: n => {
            n.tracked = true;
            Notify.push({
                id: n.id,
                summary: notifServer._plain(n.summary),
                body: notifServer._plain(n.body),
                app: n.appName,
                timestamp: Date.now()
            });
            // Do Not Disturb records history but never pops the notch.
            if (!Notify.paused)
                UiState.notify("notification", {
                    summary: notifServer._plain(n.summary),
                    body: notifServer._plain(n.body)
                }, {
                    priority: 1,
                    ttl: 6000
                });
        }

        // Bodies often arrive with HTML markup meant for dunst; the notch
        // shows plain text.
        function _plain(s) {
            return ("" + (s || "")).replace(/<[^>]*>/g, "").replace(/&amp;/g, "&").replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&quot;/g, "\"").trim();
        }
    }

    // ── IPC ──────────────────────────────────────────────────────
    // The shell has no keybinds of its own — a layer surface that grabbed
    // them would be taking them away from every real window. Hyprland owns
    // the keys and pokes these instead, which also makes every state in the
    // shell reachable from a script.

    IpcHandler {
        target: "notch"

        // What a keybind should call: the same thing tapping the notch does.
        // Pinned to the focused monitor — the sheet opens there only.
        function toggle(): void {
            UiState.centerScreen = Hypr.focusedMonitorName;
            UiState.toggleExpanded();
        }
        function open(): void {
            UiState.centerScreen = Hypr.focusedMonitorName;
            UiState.toExpanded();
        }
        function close(): void {
            UiState.dismiss();
        }
        // Fija el notch visible o lo devuelve al auto-ocultado. Devuelve
        // el estado resultante para verificarlo sin mirar la pantalla.
        function pin(): string {
            UiState.togglePin();
            return UiState.alwaysPeek ? "pinned" : "auto";
        }
        // Raise a status in the notch from anywhere — a script that finished,
        // a backup that failed. `kind` picks the view; "notification" is the
        // general-purpose one and reads `summary` / `body`.
        function status(kind: string, summary: string, body: string): void {
            UiState.notify(kind, {
                summary: summary,
                body: body
            }, {
                priority: 2
            });
        }
    }

    IpcHandler {
        target: "launcher"

        function apps(): void {
            Launcher.show("apps");
        }
        function walls(): void {
            Launcher.show("walls");
        }
        function close(): void {
            Launcher.hide();
        }
    }
}
