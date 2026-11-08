import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs

import 'MenuModules' as Modules

PanelWindow {
    id: root
    anchors {
	left: true;
	top: true
    }

    implicitHeight: 400 + 30
    implicitWidth: 400 + 30

    color: 'transparent'
	
    Rectangle {
	id: rect 
	implicitWidth: menuOpen ? 400 : 300
	implicitHeight: menuOpen ? 400 : 300
	anchors.centerIn: parent
	color: Colors.md3.background
	clip: true
	radius: 23    

	Behavior on implicitHeight { 
            SpringAnimation { spring: 4; damping: 0.3 }
	}

	Behavior on implicitWidth {  
            SpringAnimation { spring: 4; damping: 0.3 }
	} 
	
	Rectangle {
	    implicitHeight: menuOpen ? 100 : 10
	    implicitWidth: menuOpen ? 370 : 10
	    color: 'Transparent'
	    x: 13

	    Behavior on implicitHeight { 
		SpringAnimation { spring: 8; damping: 0.75 }
	    }

	    Behavior on implicitWidth {
		SpringAnimation { spring: 3; damping: 0.3 }
	    }

	    RowLayout {
		anchors.fill: parent

		Modules.Network{}
	    }
	}
    }

    property bool menuOpen: false

    visible: menuOpen

    IpcHandler {
        target: "menu"
        function toggle() : void { root.menuOpen = !root.menuOpen }
        function show() : void { root.menuOpen = true }
        function hide() : void { root.menuOpen = false }
    }

    MouseArea {
	anchors.fill: parent
	hoverEnabled: true
	onExited: {
	    toggleProc.running = true
	}
    }

    Process {
	id: toggleProc
	running: false
	command: ["sh", "-c", "sleep 0.2 && qs -p ~/.config/quickshell/chromeshell ipc call menu hide"]
    }

}
