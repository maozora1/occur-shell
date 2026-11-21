import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs

Rectangle {
    id: root
    implicitHeight: 38
    implicitWidth: 130

    color: Colors.md3.background
    clip: true
    radius: 17

    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 5
        spacing: -4

        Text {
            text: "Workspace " + (Hyprland.focusedWorkspace?.name ?? "none")
            color: Colors.md3.secondary
            font.family: "Google Sans"
            font.pixelSize: 12
        }

        Item {
            id: titleBox
            Layout.fillWidth: true
            Layout.preferredHeight: first.implicitHeight
            clip: true

            Row {
                id: scroller
                spacing: 40   // gap between the end of the text and its repeat

                Text {
                    id: first
                    text: (Hyprland.activeToplevel?.workspace?.id === Hyprland.focusedWorkspace?.id
                           && Hyprland.activeToplevel?.title) || "Desktop"
                    color: Colors.md3.primary
                    font.family: "Google Sans"
                    font.pixelSize: 16

                    // Start fresh when the title changes
                    onTextChanged: {
                        scroller.x = 0
                        if (anim.running) anim.restart()
                    }
                }

                // The copy that follows, only shown when scrolling
                Text {
                    text: first.text
                    visible: first.text.length > 18
                    color: Colors.md3.primary
                    font.family: "Google Sans"
                    font.pixelSize: 16
                }
            }

            SequentialAnimation {
                id: anim
                loops: Animation.Infinite
                running: first.text.length > 18
                onRunningChanged: if (!running) scroller.x = 0

                PropertyAction { target: scroller; property: "x"; value: 0 }
                PauseAnimation { duration: 1500 }   // rest at the start
                NumberAnimation {
                    target: scroller
                    property: "x"
                    to: -(first.implicitWidth + scroller.spacing)
                    duration: (first.implicitWidth + scroller.spacing) * 20   // ~20ms per pixel
                }
            }
        }
    }
}
