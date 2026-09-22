import QtQuick
import "../../../core"
import "../../../services"
import "../../primitives"
import ".."

// Battery drill-down: charge state, then the power-profiles-daemon modes.
// Switching profiles applies system-wide immediately. See
// services/PowerProfiles.qml.
Item {
    id: page
    implicitHeight: col.implicitHeight

    Column {
        id: col
        width: parent.width
        spacing: Config.gap

        PageHeader {
            width: parent.width
            title: "Battery"
        }

        ListRow {
            width: parent.width
            glyph: Icons.battery
            label: PowerProfiles.percent >= 0 ? PowerProfiles.percent + "%" : "No battery"
            sublabel: PowerProfiles.state.length ? PowerProfiles.state : PowerProfiles.summary
            selected: PowerProfiles.percent >= 0
            enabled: false
        }

        Text {
            text: "Profile"
            color: Theme.textMuted
            font.family: Theme.fontSans
            font.pixelSize: 11
            font.weight: Font.DemiBold
            font.capitalization: Font.AllUppercase
            font.letterSpacing: 0.8
        }

        Column {
            width: parent.width
            spacing: 6

            Repeater {
                model: PowerProfiles.profiles
                delegate: ListRow {
                    required property string modelData
                    width: col.width
                    glyph: PowerProfiles.iconOf(modelData)
                    label: PowerProfiles.labelOf(modelData)
                    sublabel: modelData === PowerProfiles.profile ? "Active" : "Switch"
                    selected: modelData === PowerProfiles.profile
                    onActivated: PowerProfiles.setProfile(modelData)
                }
            }
        }
    }
}
