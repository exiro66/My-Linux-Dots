import QtQuick
import Quickshell
import Quickshell.Hyprland
import "Singletons"

Item {
    id: bar
    width: 600
    height: 40

    property string pillMode: "notch"
    property string notchMode: "dark"

    Rectangle {
        anchors.fill: parent
        radius: pillMode === "dynamic" ? 20 : 0
        topLeftRadius: pillMode === "dynamic" ? 20 : 0
        topRightRadius: pillMode === "dynamic" ? 20 : 0
        bottomLeftRadius: 20
        bottomRightRadius: 20
        color: notchMode === "light" ? "#ffffff" : "#000000"
    }

    Row {
        anchors.left: parent.left
        anchors.leftMargin: 16
        anchors.verticalCenter: parent.verticalCenter
        spacing: 12

        Workspaces {
            id: ws
            anchors.verticalCenter: parent.verticalCenter
            screenName: ""
            s: 1
            gap: 8
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: 0

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: clock.hhmm
            color: bar.notchMode === "light" ? "#000000" : "#ffffff"
            font.pixelSize: 16
            font.bold: true
        }
    }

    Row {
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.verticalCenter: parent.verticalCenter
        spacing: 12

        GlyphIcon { name: "mixer"; color: bar.notchMode === "light" ? "#000000" : "#ffffff"; stroke: 1.7 }
        GlyphIcon { name: "cog"; color: bar.notchMode === "light" ? "#000000" : "#ffffff"; stroke: 1.6 }
        GlyphIcon { name: "shutdown"; color: bar.notchMode === "light" ? "#000000" : "#ffffff"; stroke: 1.7 }
    }

    QtObject {
        id: clock
        property var now: new Date()
        property string hhmm: now.toLocaleTimeString(Qt.locale("en_US"), "HH:mm")
    }
}
