import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import qs

PanelWindow {
    WlrLayershell.layer: WlrLayer.Background
    implicitHeight: 200
    implicitWidth: 300
    anchors {
	right: true;
	top: true
    }
    margins {
	right: 25;
	top: 50
    }
    color: 'transparent'
    id: root

    Rectangle {
	anchors.fill: parent
	color: Colors.md3.background
	radius: 28

	ColumnLayout {
	    anchors.fill: parent
	    anchors.leftMargin: 10
	    anchors.rightMargin: 10

	    Text {
		text: Mpris.players.values[0].trackTitle || "Unknown Title"
		color: Colors.md3.primary
		font.family: 'Google Sans'
		font.pixelSize: 20
		font.weight: 550
	    }

	    Text {
		text: Mpris.players.values[0].trackArtist || "Unknown Artist"
		color: Colors.md3.primary
		font.family: 'Google Sans'
		font.pixelSize: 16
	    }
	}

    }
}
