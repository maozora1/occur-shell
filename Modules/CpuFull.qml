import Quickshell
import Quickshell.Io
import QtQuick
import qs 

PanelWindow {
    id: root
    color: 'transparent'
    implicitWidth: 250
    implicitHeight: 330
    anchors {
	top: true
	right: true
    }

    margins { 
	top: 10
	right: 120
    }

    property bool windowOpen: false

    visible: windowOpen

    Rectangle {
	anchors.centerIn: parent
	color: Colors.md3.background
	radius: 15
	implicitHeight: windowOpen ? 330 : 275
	implicitWidth: windowOpen ? 250 : 200

	Behavior on implicitHeight { 
	    SpringAnimation { spring: 4; damping: 0.3 }
	} 

	Behavior on implicitWidth {
	    SpringAnimation { spring: 4; damping: 0.3 }
	}

	IpcHandler {
	    target: "cpu"
	    function toggle() : void { root.windowOpen = !root.windowOpen }
	    function show() : void { root.windowOpen = true }
	    function hide() : void { root.windowOpen = false }
	} 
    }
}
