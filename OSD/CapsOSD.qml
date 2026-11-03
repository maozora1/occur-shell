import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs

Scope {
    id: root
    property bool capsLock: false
    property bool showOsd: false


    onCapsLockChanged: {
	console.log("caps lock:", capsLock ? 1 : 0)

	if (capsLock)
        onProc.running = true
	    else
        offProc.running = true

	showOsd = true
	hideTimer.interval = capsLock ? 2000 : 1500
	hideTimer.restart()
    }

    Process {
	id: onProc
	command: ["sh", "-c", "sleep 0.05 && paplay ~/.config/quickshell/chromeshell/reuseable/Unlock.ogg"]
    }

    Process {
	id: offProc
	command: ["sh", "-c", "sleep 0.05 && paplay ~/.config/quickshell/chromeshell/reuseable/Lock.ogg"]
    }
    Timer {
        id: hideTimer
        interval: 3000
        onTriggered: root.showOsd = false
    }


    Process {
        id: capsProc
        command: ["sh", "-c", "cat /sys/class/leds/input*::capslock/brightness | grep -q 1 && echo 1 || echo 0"]
        stdout: StdioCollector {
            onStreamFinished: root.capsLock = (text.trim() === "1")
        }
    }

    Timer {
        interval: 200
        running: true
        repeat: true
        onTriggered: capsProc.running = true
    }

    PanelWindow {
	visible: osd.opacity > 0
	anchors { bottom: true }
	margins { bottom: 10 }
	implicitWidth: 200
	implicitHeight: 85
	color: 'transparent'
	exclusionMode: ExclusionMode.Ignore

	mask: Region { item: osd; intersection: Intersection.Subtract }

	Rectangle {
	    id: osd

	    anchors.fill: parent
	    radius: 15
	    color: Colors.md3.background

	    opacity: root.showOsd ? 1 : 0
	    Behavior on opacity { NumberAnimation { duration: 300 } }

	    RowLayout {
		anchors.fill: parent
		anchors.leftMargin: 10

		Rectangle {
		    implicitWidth: root.capsLock ? 65 : 60
		    implicitHeight: root.capsLock ? 65 : 60
		    radius: 15
		    color: root.capsLock ? Colors.md3.primary : Colors.md3.on_primary

		    Behavior on color {
			ColorAnimation { duration: 100 }
		    }

		    Behavior on implicitHeight {
			SpringAnimation { spring: 4; damping: 0.4 }
		    }

		    Behavior on implicitWidth {
			SpringAnimation { spring: 4; damping: 0.4 }
		    }


		    Text {
			anchors.centerIn: parent
			font.family: 'JetBrains Mono Nerd Font'
			color: root.capsLock ? Colors.md3.on_primary : Colors.md3.primary
			text: '󰘲'
			font.pixelSize: root.capsLock ? 40 : 30

			Behavior on font.pixelSize {
			     SpringAnimation { spring: 4; damping: 0.4 }
			}

			Behavior on color {
			    ColorAnimation { duration: 100 }
			}
		    }
		}

		ColumnLayout {
		    Text {
			text: 'Caps Lock'
			color: Colors.md3.primary
			font.family: 'Google Sans'
			font.weight: 500
			font.pixelSize: 19
		    }

		    Text {
			text: root.capsLock ? 'On' : 'Off'
			color: Colors.md3.on_surface
			font.family: 'Google Sans'
			font.pixelSize: 17
		    }
		}
	    }
	}
    }
}
