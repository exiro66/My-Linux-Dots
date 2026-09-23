import QtQuick
import Quickshell
import Quickshell.Wayland
import "../core"

// Static reservation the size of the resting pill, so tiled windows never
// slide under the notch. The interactive overlay cannot do this itself: a
// fullscreen-anchored surface gets no exclusive zone, and tying reservation
// to visibility would reflow the whole desktop on every hover.
//
// Top-anchored with no horizontal anchor, which the protocol centers on its
// own. No input, never drawn: pure reservation.
PanelWindow {
    id: win

    property var modelData
    screen: modelData

    anchors {
        top: true
    }
    // La reserva sigue al tamaño. Solo en modo visible (pin): en
    // auto-ocultar la ventana se esconde y no reserva nada.
    implicitWidth: Math.round(Config.peekWidth)
    implicitHeight: 10
    visible: UiState.alwaysPeek
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "quickshell-notch-reserve"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
    WlrLayershell.exclusionMode: ExclusionMode.Auto
    WlrLayershell.exclusiveZone: 12

    mask: Region {}
}
