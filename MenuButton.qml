import Quickshell
import Quickshell.Io
import QtQuick

import 'theme.js' as Theme

Rectangle {
    radius: 70
    implicitHeight: 26
    implicitWidth: 26
    color: Theme.colors.bgdim

    Rectangle {
        radius: 70
        anchors.fill: parent
        anchors.margins: 4
        color: Theme.colors.bg

        Process {
            id: menuProc
            running: false
            command: ["sh", "-c", "qs -p ~/.config/quickshell/chromeshell/Menu/Menu.qml ipc call menu toggle"]
        }

        Text {
            text: "󰀚"
            anchors.centerIn: parent
            font.pixelSize: 19
            color: Theme.colors.green
            font.family: "JetBrainsMono Nerd Font Propo"
        }

        Behavior on opacity {
            NumberAnimation { duration: 250 }
        }
        
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.opacity = 0.5
            onExited: parent.opacity = 1
            onClicked: menuProc.running = true
        }
    }
}
