import Quickshell
import Quickshell.Io
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts
import qs

Rectangle {
    id: root
    implicitWidth: 180
    implicitHeight: 65

    property var wifiDevice: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
    property var active: wifiDevice ? wifiDevice.networks.values.find(n => n.connected): null

    readonly property real signal: active ? active.signalStrength : 0

    readonly property string icon: {
	if (!Networking.wifiEnabled) return String.fromCodePoint(0xF05AA)
	if (!active) return String.fromCodePoint(0xF092D)

	let tier = signal >= 0.75 ? 4
		 : signal >= 0.50 ? 3
		 : signal >= 0.25 ? 2
		 : 1
	return String.fromCodePoint(0xF091F + (tier - 1) * 3 )
    }

    radius: 80

    color: root.active ? Colors.md3.primary : Colors.md3.tertiary


    RowLayout {
	anchors.fill: parent
	anchors.leftMargin: 20
	spacing: 10
	anchors.rightMargin: 20
	clip: true

	Text {
	    text: root.icon
	    font.pixelSize: 30
	    font.family: 'JetBrainsMono Nerd Font Propo'
	    color: Colors.md3.on_primary
	}

	Rectangle {
	    color: 'Transparent'
	    implicitWidth: 90
	    implicitHeight: 45

	    ColumnLayout {
		anchors.fill: parent
		spacing: 0

		Text {
		    text: "Network"
		    font.family: "Google Sans"
		    font.pixelSize: 19
		    font.weight: 500
		    color: Colors.md3.on_primary
		}

		Text {
		    Layout.bottomMargin: 20
		    font.family: "Google Sans"
		    text: {
			if (!Networking.wifiEnabled) return "Off"
			if (!root.active) return "Disconnected"

			return root.active.name
		    } 
		    font.pixelSize: 16
		    color: Colors.md3.on_primary
		}
	    }
	}
    }

    MouseArea {
	anchors.fill: parent
	hoverEnabled: true
	onEntered: {
	    root.opacity = 0.75
	    console.log("network hover entered")
	}
	onExited: {
	    root.opacity = 1
	}
	onClicked: console.log("network: clicked")
    }
}
