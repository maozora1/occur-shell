import Quickshell
import QtQuick
import Quickshell.Networking
import QtQuick.Layouts
import qs


Rectangle {
    color: Colors.md3.background
    radius: 15
    implicitHeight: 38
    implicitWidth: label.implicitWidth + 40

    Behavior on implicitWidth {
        NumberAnimation { duration: 250; easing.type: Easing.InOutCubic }
    }

    RowLayout {
        id: root
        spacing: 5
        anchors.centerIn: parent

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
        Text {
            text: root.icon
            color: Networking.wifiEnabled ? Colors.md3.secondary : Theme.colors.outline

            font {
                family: "JetBrainsMono Nerd Font Propo"
                pixelSize: 13
            }

            Behavior on color {
                ColorAnimation { duration: 250 }
            }
        }

        Text {
	    id: label
            text: {
                if (!Networking.wifiEnabled) return "Off"
                if (!root.active) return "Disconnected"

                return root.active.name
            } 

            color: Networking.wifiEnabled ? Colors.md3.secondary : Theme.colors.outline

            font {
                family: "Google Sans"
                weight: 500
                pixelSize: 14
            }

            Behavior on color {
                ColorAnimation { duration: 250 }
            }
        }
    }
}
