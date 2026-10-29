import Quickshell
import Quickshell.Io
import QtQuick

import 'theme.js' as Theme

    Rectangle { // Blue Light Filter
	id: root
	anchors.left: parent.left 
	anchors.top: parent.top
	anchors.topMargin: 85
	anchors.leftMargin: 7
	implicitHeight: 70
	implicitWidth: 120
	color: Theme.colors.bgdim
	radius: 31

	property bool filterOn: false

	Process {
	    id: filterProcOn
	    running: false
	    command: [ "hyprsunset", "-t", "4500" ]
	}

	Process {
	    id: filterProcOff
	    running: false
	    command: [ "pkill", "hyprsunset" ]
	}

	Text {
	    id: filIcon
	    text: "󰃛"
	    font.family: "JetBrainsMono Nerd Font Propo"
	    anchors.centerIn: parent
	    font.pixelSize: 35
	    color: Theme.colors.yellow

	    Behavior on color {
		ColorAnimation { duration: 200 }  
	    }
	}

	Behavior on opacity {
	    NumberAnimation { duration: 100 }
	}

	Behavior on color {
	    ColorAnimation { duration: 200 }
	}

	Behavior on radius {
	    SpringAnimation { spring: 4; damping: 0.50 } 
	}

	MouseArea {
	    anchors.fill: parent
	    hoverEnabled: true
	    onEntered: parent.opacity = 0.75
	    onExited: parent.opacity = 1
	    onClicked: {
		if (!parent.filterOn) { 
		    parent.radius = 15
		    parent.color = Theme.colors.yellow
		    filIcon.color = Theme.colors.bgdim
		    parent.filterOn = true 
		    filterProcOn.running = true
		} else {   
		    parent.radius = 31  
		    parent.color = Theme.colors.bgdim
		    filIcon.color = Theme.colors.yellow
		    parent.filterOn = false 
		    filterProcOff.running = true 
		}
	    }
	}
    }

