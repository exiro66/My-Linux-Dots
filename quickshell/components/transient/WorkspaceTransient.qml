import QtQuick
import "../../services"
import "../../core"

// Compact workspace strip: a dot per workspace, the active one stretched into
// a numbered capsule. The stretch animates so a switch reads as motion.
//
// Positions, not global ids: the keybinds address slots (`r~N` = Nth
// workspace of the focused monitor), so each monitor gets its own 1..K with
// its live slot highlighted. Falls back to the shared numbering while the
// workspace list is still populating at startup.
Item {
    id: root

    // NB: never call this `data` — that name is QtObject's default (children)
    // property and shadowing it drops every child item.
    property var payload: ({})
    readonly property string mon: (payload && payload.monitor) ? payload.monitor : Hypr.focusedMonitorName
    readonly property var ids: Hypr.workspacesOn(root.mon)
    readonly property bool perMon: root.ids.length > 0
    readonly property int activePos: {
        var a = Hypr.activeOn(root.mon) || ((payload && payload.id) ? payload.id : Hypr.focusedWorkspace);
        var k = root.ids.indexOf(a);
        return k >= 0 ? k + 1 : 0;
    }

    // Factory fallback: shared numbering.
    readonly property int activeId: (payload && payload.id) ? payload.id : Hypr.focusedWorkspace
    readonly property int count: Math.max(5, Hypr.maxWorkspace)

    implicitWidth: row.implicitWidth
    implicitHeight: 16

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 6

        Repeater {
            model: root.perMon ? root.ids.length : root.count
            delegate: Item {
                id: cell
                required property int index
                readonly property bool on: root.perMon ? (index + 1) === root.activePos : (index + 1) === root.activeId

                width: on ? 26 : 6
                height: 16

                Behavior on width {
                    NumberAnimation { duration: 220; easing.type: Easing.OutCubic }
                }

                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width
                    height: cell.on ? 16 : 6
                    radius: height / 2
                    color: cell.on ? Theme.accent : Theme.textMuted

                    Behavior on height {
                        NumberAnimation { duration: 220; easing.type: Easing.OutCubic }
                    }
                    Behavior on color {
                        ColorAnimation { duration: 160 }
                    }

                    Text {
                        anchors.centerIn: parent
                        visible: cell.on
                        text: cell.index + 1
                        color: Theme.accentText
                        font.family: Theme.fontMono
                        font.pixelSize: 9
                        font.weight: Font.Bold
                    }
                }
            }
        }
    }
}
