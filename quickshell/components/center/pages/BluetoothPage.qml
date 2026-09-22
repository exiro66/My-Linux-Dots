import QtQuick
import "../../../core"
import "../../../services"
import "../../primitives"
import ".."

// Bluetooth drill-down: adapter power, then every paired device. Pairing
// needs an agent and a terminal, so this page offers only what works
// headless — power plus connect/disconnect. See services/Bluetooth.qml.
Item {
    id: page
    implicitHeight: col.implicitHeight

    Column {
        id: col
        width: parent.width
        spacing: Config.gap

        PageHeader {
            width: parent.width
            title: "Bluetooth"
        }

        ListRow {
            width: parent.width
            glyph: Icons.bluetooth
            label: Bluetooth.powered ? "On" : "Off"
            sublabel: Bluetooth.powered ? Bluetooth.summary : "Adapter off"
            selected: Bluetooth.powered
            onActivated: Bluetooth.togglePower()
        }

        Text {
            text: "Devices"
            color: Theme.textMuted
            font.family: Theme.fontSans
            font.pixelSize: 11
            font.weight: Font.DemiBold
            font.capitalization: Font.AllUppercase
            font.letterSpacing: 0.8
            visible: Bluetooth.devices.length > 0
        }

        Column {
            width: parent.width
            spacing: 6
            visible: Bluetooth.devices.length > 0

            Repeater {
                model: Bluetooth.devices
                delegate: ListRow {
                    required property var modelData
                    width: col.width
                    glyph: Icons.bluetooth
                    label: modelData.name
                    sublabel: modelData.connected ? "Connected · " + modelData.mac : "Paired · " + modelData.mac
                    selected: modelData.connected
                    onActivated: Bluetooth.toggleDevice(modelData)
                }
            }
        }

        Text {
            width: parent.width
            wrapMode: Text.WordWrap
            text: Bluetooth.devices.length > 0 ? "Pair new devices from a terminal: bluetoothctl" : "No paired devices — pair from a terminal: bluetoothctl"
            color: Theme.textMuted
            font.family: Theme.fontSans
            font.pixelSize: 12
        }
    }
}
