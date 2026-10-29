import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import 'theme.js' as Theme

	RowLayout { // Power Options
	    id: root 
	    spacing: 10
	    implicitHeight: 140
	    implicitWidth: 40
	    anchors.bottom: parent.bottom
	    anchors.bottomMargin: 10
    
	    Process {
		id: shutdown
		running: false
		command: ["shutdown", "now"]
	    }

	    // Reboot
	    Process {
		id: reboot
		running: false
		command: ["reboot"]
	    }

	    // Logout
	    Process {
		id: logout
		running: false
		command: ["sh", "-c", "hyprctl dispatch 'hl.dsp.exit()'"]
	    }

	    // Power
	    Rectangle { 
		id: powerButton
		color: "transparent"
		implicitWidth: 40
		implicitHeight: 40
		radius: 100
		
		Behavior on color {
		    ColorAnimation { duration: 150 }
		}

		Behavior on opacity {
		    NumberAnimation { duration: 250; easing.type: Easing.InOutCubic }
		}

		MouseArea {
		    anchors.fill: parent
		    hoverEnabled: true
		    onEntered: { parent.color = Theme.colors.bgdim; parent.opacity = 0.75 }
		    onExited: { parent.color = "transparent"; parent.opacity = 1 }
		    onClicked: { shutdown.running = true }  
		}

		Text {
		    text: "⏻"
		    anchors.centerIn: parent
		    font.pixelSize: 18
		    font.family: "JetBrainsMono Nerd Font Propo"
		    color: Theme.colors.fg
		}
	    }

	    // reboot
	    Rectangle { 
		id: rebootButton
		implicitHeight: 40
		implicitWidth: 40
		color: "transparent"
		radius: 100

		Behavior on color {
		    ColorAnimation { duration: 150 }
		}

		Behavior on opacity {
		    NumberAnimation { duration: 250; easing.type: Easing.InOutCubic }
		}

		MouseArea {
		    anchors.fill: parent
		    hoverEnabled: true
		    onEntered: { parent.color = Theme.colors.bgdim; parent.opacity = 0.75 }
		    onExited: { parent.color = "transparent"; parent.opacity = 1 }
		    onClicked: { reboot.running = true } 
		}

		Text {
		    text: ""
		    anchors.centerIn: parent
		    font.family: "JetBrainsMono Nerd Font Propo"
		    font.pixelSize: 18
		    color: Theme.colors.fg
		}
	    }

	    // Log Out
	    Rectangle { 
		id: logoutButton
		implicitHeight: 40
		implicitWidth: 40
		color: "transparent"
		radius: 100


		Behavior on color {
		    ColorAnimation { duration: 150 }
		}

		Behavior on opacity {
		    NumberAnimation { duration: 250; easing.type: Easing.InOutCubic }
		}

		MouseArea {
		    anchors.fill: parent
		    hoverEnabled: true
		    onEntered: { parent.color = Theme.colors.bgdim; parent.opacity = 0.75 }
		    onExited: { parent.color = "transparent"; parent.opacity = 1 }
		    onClicked: { logout.running = true }  
		}

		Text {
		    text: "󰈆"
		    anchors.centerIn: parent
		    font.family: "JetBrainsMono Nerd Font Propo"
		    font.pixelSize: 19
		    color: Theme.colors.fg
		    }
		}
	    }
	

