import QtQuick
import "../../../core"
import "../../../services"
import "../../primitives"
import ".."

// Layout drill-down: the four tiling layouts the keybinds cycle through.
// Applies immediately, monitor-wide. See services/Layout.qml.
Item {
    id: page
    implicitHeight: col.implicitHeight

    Column {
        id: col
        width: parent.width
        spacing: Config.gap

        PageHeader {
            width: parent.width
            title: "Layout"
        }

        Column {
            width: parent.width
            spacing: 6

            Repeater {
                model: Layout.layouts
                delegate: ListRow {
                    required property var modelData
                    width: col.width
                    glyph: Icons.columns
                    label: modelData.name
                    sublabel: modelData.value === Layout.current ? "Active" : "Switch"
                    selected: modelData.value === Layout.current
                    onActivated: Layout.set(modelData.value)
                }
            }
        }
    }
}
