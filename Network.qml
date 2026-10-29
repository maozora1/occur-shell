import Quickshell
import QtQuick
import Quickshell.Networking
import QtQuick.Layouts

import 'theme.js' as Theme

Rectangle {
    color: Theme.colors.bgdim
    radius: 20
    implicitHeight: 26
    implicitWidth: Networking.wifiEnabled ? 125 : 100  

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
            color: Networking.wifiEnabled ? Theme.colors.blue : Theme.colors.cyan

            font {
                family: "JetBrainsMono Nerd Font Propo"
                pixelSize: 13
            }

            Behavior on color {
                ColorAnimation { duration: 250 }
            }
        }

        Text {
            text: {
                if (!Networking.wifiEnabled) return "Off"
                if (!root.active) return "Disconnected"

                return root.active.name
            } 

            color: Networking.wifiEnabled ? Theme.colors.blue : Theme.colors.cyan

            font {
                family: "Google Sans"
                weight: 600
                pixelSize: 14
            }

            Behavior on color {
                ColorAnimation { duration: 250 }
            }
        }
    }
}
