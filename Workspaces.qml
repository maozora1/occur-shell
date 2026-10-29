import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import 'theme.js' as Theme


    Rectangle {
        implicitHeight: 26
        implicitWidth: 200
        radius: 20
        color: Theme.colors.bgdim

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 5
            anchors.rightMargin: 5

            Repeater {     
                model: 5

                Rectangle {
                    property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

                    radius: 20
                    color: isActive ? Theme.colors.magenta : (ws ? Theme.colors.red : Theme.colors.off)

                    implicitHeight: 17
                    implicitWidth: isActive ? 50 : 30

                    Behavior on implicitWidth {
                        SpringAnimation { spring: 4; damping: 0.4 }
                    }
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }

                    Behavior on opacity {
                        NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.opacity = 0.8
                        onExited: parent.opacity = 1
                        onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (index + 1 ) + " })")
                    }
            }
        }
    }
}
