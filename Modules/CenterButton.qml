import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs

Rectangle {
    id: root
    implicitHeight: 38
    implicitWidth: 80
    color: Colors.md3.background
    radius: 13

    RowLayout {
	anchors.fill: parent
	anchors.leftMargin: 7
	anchors.rightMargin: 7

	Rectangle {
	    id: searchButton
	    implicitHeight: 28
	    implicitWidth: 28
	    radius: 15
	    color: 'Transparent'

	    Behavior on color {
                ColorAnimation { duration: 150 }
	    }

	    Text {
		font.family: 'JetBrains Mono Nerd Font Propo'
		text: ''
		font.pixelSize: 15
		anchors.centerIn: parent
		color: Colors.md3.primary
	    }

	   MouseArea {
		anchors.fill: parent
		hoverEnabled: true
		onEntered: parent.color = Colors.md3.on_primary
		onExited: parent.color = 'Transparent'
	    }
	}


	Rectangle {
	    implicitHeight: 28
	    implicitWidth: 28
	    radius: 15
	    color: 'Transparent'

	    Text {
		font.family: 'JetBrains Mono Nerd Font Propo'
		text: '󰐾'
		font.pixelSize: 18
		anchors.centerIn: parent
		color: Colors.md3.primary
	    }

	    Behavior on color {
                ColorAnimation { duration: 150 }
	    }

	    MouseArea {
	     	 anchors.fill: parent
		 hoverEnabled: true
		 onEntered: { 
		     parent.color = Colors.md3.on_primary
		     onEnteredProc.running = true
	         }
		 onExited: parent.color = 'Transparent'
		 onClicked: {
		     onClickedProc.running = true
		 }
	    }

	    Process {
		id: onEnteredProc
		command: ["sh", "-c", "paplay ~/.config/quickshell/chromeshell/reuseable/TW_SIP_Calm.ogg"]
	    }

	    Process {
		id: onClickedProc
		command: ["sh", "-c", "paplay ~/.config/quickshell/chromeshell/reuseable/TW_Touch.ogg && qs -p ~/.config/quickshell/chromeshell ipc call menu toggle"]
	    }

	}
    }
}
