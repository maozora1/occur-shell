import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io
import QtQuick
import QtQuick.Controls

import 'theme.js' as Theme

Scope {
    id: root
    property bool showOsd: false

    property var sink: Pipewire.defaultAudioSink 
    readonly property bool ready: sink && sink.ready
    readonly property bool muted: ready && sink.audio.muted
    readonly property int vol: ready ? Math.round(sink.audio.volume * 100) : 0

    onVolChanged: {
	showOsd = true
	hideTimer.interval = 2000
	hideTimer.restart()
    }

    Timer {
        id: hideTimer
        interval: 2000
        onTriggered: root.showOsd = false
    }

    PanelWindow {
	id: osdPanel
	visible: osd.opacity > 0
	anchors { right: true }
	margins { right: 10 }
	implicitWidth: 75
	implicitHeight: 300
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
		Slider {
		    implicitHeight: osdPanel.implicitHeight - 40
		    from: 0
		    to: 100
		    value: root.vol
		    orientation: Qt.Vertical
		    anchors.centerIn: parent

		}

	    }
	   PwObjectTracker { objects: [root.sink] }
	}
    }
