import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Wayland

import "theme.js" as Theme

Scope {
    id: root
    property bool windowOpen: false


IpcHandler {
    target: "window"
    function toggle() : void { root.windowOpen = !root.windowOpen }
    function show() : void { root.windowOpen = true }
    function hide() : void { root.windowOpen = false }
}
// Settings Menu
PanelWindow {
    visible: root.windowOpen
    implicitHeight: 700
    implicitWidth: 850
    color: "transparent"

    Rectangle {
        radius: 15
        anchors.fill: parent
        color: '#2d2b2a'

        Rectangle {
            implicitHeight: 700
            implicitWidth: 300

            anchors.left: parent.left
            bottomLeftRadius: 15
            topLeftRadius: 15
            color: '#282727'


            // Title
            RowLayout {
                id: layout
                anchors.top: parent.top
                anchors.topMargin: 40
                spacing: 6
 

                Text {
                    Layout.fillWidth: true
                    text: "Settings"
                    Layout.alignment: Qt.AlignLeft
                    Layout.leftMargin: 14
                    font.family: "Google Sans"
                    font.pixelSize: 35
                    color: Theme.colors.fg
                    font.weight: 500
                }

                Text {
                    text: "x"
                    color: Theme.colors.fg
                    font.family: "Google Sans"
                    font.weight: 600
                    font.pixelSize: 25
                    Layout.leftMargin: 100
                    Layout.alignment: Qt.AlignLeft



                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.windowOpen = false
                    }
                }
            }

            // uhh
            Rectangle {
                color: '#1c1b1b'
                radius: 9
                implicitHeight: 595
                implicitWidth: 275
                x: 13
                y: 95
            }


            }
        }
    }
}