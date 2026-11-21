import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs

Rectangle {
    id: root

    implicitHeight: 37
    implicitWidth: 58 + label.implicitWidth

    Behavior on implicitWidth {
        SpringAnimation { spring: 3; damping: 0.25 }
    }

    Behavior on implicitHeight {
        SpringAnimation { spring: 3; damping: 0.25 }
    }

    Behavior on opacity {
        NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
    }


    MouseArea {
	anchors.fill: parent
	hoverEnabled: true
	onEntered: {
	    parent.implicitWidth = parent.implicitWidth - 2.5
	    parent.implicitHeight = parent.implicitHeight - 2.5
	    parent.opacity = 0.90
	}
	onExited: {
	    parent.implicitHeight = 37
	    parent.implicitWidth = 58 + label.implicitWidth
	    parent.opacity = 1
	    labelLayout.opacity = 1
	}
	onClicked: {
	    labelLayout.opacity = 0
	    openProc.running = true
	}
    }

    Process {
	id: openProc
	command: ["sh", "-c", "qs -p ~/.config/quickshell/chromeshell ipc call cpu toggle"]
    }

    radius: 17
    color: Colors.md3.background

    property int cpuUsage: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    Process {
	id: cpuProc
	command: ["sh", "-c", "head -1 /proc/stat"]
	stdout: SplitParser {
	    onRead: data => {
		var p = data.trim().split(/\s+/)
		var idle = parseInt(p[4]) + parseInt(p[5])
		var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
		if (lastCpuTotal > 0) {
		    cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
		}
		lastCpuTotal = total
		lastCpuIdle = idle
	    }
	}
	Component.onCompleted: running = true
    }

    Timer {
	interval: 2000
	running: true
	repeat: true
	onTriggered: cpuProc.running = true
    }

    RowLayout {
	id: labelLayout
	anchors.fill: parent
	anchors.rightMargin: 13
	anchors.leftMargin: 13

	Behavior on opacity {    
	    NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
	}

	Text {
	    id: icon
	    text: ""
	    font.family: "IosevkaTerm Nerd Font Mono Propo"
	    font.pixelSize: 15
	    color: cpuUsage >= 80 ? Colors.md3.error : Colors.md3.tertiary
	}

	Text {
	    id: label
	    text: cpuUsage + "%"
	    font.family: "Google Sans"
	    font.pixelSize: 14
	    font.weight: 600
	    color: cpuUsage >= 80 ? Colors.md3.error : Colors.md3.tertiary
	}

    }
}
