import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs

    Rectangle {
        implicitHeight: 38
        implicitWidth: wsLayout.implicitWidth + 25
        radius: 15  
        color: Colors.md3.background

        RowLayout {
	    id: wsLayout
	    implicitWidth: 300
	    anchors.centerIn: parent
	    spacing: 7

            Repeater {     
                model: 10

                Rectangle {
                    property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

                    radius: 70
                    color: isActive ? Colors.md3.primary : (ws ? Colors.md3.secondary : Colors.md3.primary_container)

                    implicitHeight: isActive ? 20 : (ws ? 20 : 10)
                    implicitWidth: isActive ? 50 : (ws ? 22 : 10)

                    Behavior on implicitWidth {
                        SpringAnimation { spring: 3.5; damping: 0.25 }
                    }

                    Behavior on implicitHeight {
                        SpringAnimation { spring: 3; damping: 0.2 }
                    }
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }

                    Behavior on radius {
                        SpringAnimation { spring: 2; damping: 0.5 }
                    }

                    Behavior on opacity {
                        NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
		    }

		    Process {
			id: sfxHoverProc
			command: ["sh", "-c", "sleep 0.05 && paplay ~/.config/quickshell/chromeshell/reuseable/TW_SIP_Calm.ogg && sleep 0.2"]
		    }

		    Process {
			id: sfxClickProc
			command: ["sh", "-c", "paplay ~/.config/quickshell/chromeshell/reuseable/TW_SIP_Fun.ogg"]
		    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
			onEntered: { 
			    parent.opacity = 0.8
			    sfxHoverProc.running = true
			}
                        onExited: parent.opacity = 1
			onClicked: { 
			    Hyprland.dispatch("hl.dsp.focus({ workspace = " + (index + 1 ) + " })")
			    sfxClickProc.running = true
			}
                    }
            }
        }
    }
}
