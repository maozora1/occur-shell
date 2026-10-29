import Quickshell
import Quickshell.Io
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts

import 'theme.js' as Theme


    GridLayout {
        id: root 
        columns: 2
        implicitWidth: 380
        implicitHeight: 100
	anchors.fill: parent

	property var wifiDevice: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
	property var active: wifiDevice ? wifiDevice.networks.values.find(n => n.connected): null

	readonly property real signal: active ? active.signalStrength * 100 : 0

	readonly property string icon: {
	    if (!Networking.wifiEnabled) return String.fromCodePoint(0xF05AA)
	    if (!active) return String.fromCodePoint(0xF092D)

	    let tier = signal >= 0.75 ? 4
		     : signal >= 0.50 ? 3
		     : signal >= 0.25 ? 2
		     : 1
	    return String.fromCodePoint(0xF091F + (tier - 1) * 3 )
	}

            Rectangle { // Network Module
                radius: Networking.wifiEnabled ? 14 : 31
                color: Networking.wifiEnabled ? Theme.colors.yellow : Theme.colors.bgdim
                implicitWidth: 200
                implicitHeight: 65

                Behavior on radius {
                    SpringAnimation { spring: 4; damping: 0.50 } 
                }

                Behavior on opacity {
                    NumberAnimation { duration: 100 }
                }

                Process {
                    id: networkOn
                    command: ["sh", "-c", "nmcli radio wifi on"]
                }

                Process {
                    id: networkOff
                    command: ["sh", "-c", "nmcli radio wifi off"]
                }

                GridLayout {
                    id: wifiGrid
                    anchors.left: parent.left
                    anchors.leftMargin: 60
                    anchors.top: parent.top
                    anchors.topMargin: 9
                    columns: 1
                    flow: GridLayout.TopToBottom
                    

                    Text { // Network Label
                        text: "Network" 
                        color: Networking.wifiEnabled ? Theme.colors.fgon : Theme.colors.fg
                        font.family: "Google Sans"
                        font.weight: 600 
                        font.pixelSize: 20
                    }

                    Text { // More info
                        text: {
                            if (!Networking.wifiEnabled) return "Wifi is turned off"
                            if (!root.active) return "Not Connected"
                            return root.active.name
                        }
                        font.family: "Google Sans"
                        font.pixelSize: !root.active ? 14 : 15
                        font.weight: 500
                        color: Networking.wifiEnabled ? Theme.colors.fgon : Theme.colors.fg
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 9
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: parent.opacity = 0.75
                    onExited: parent.opacity = 1
                    onClicked: Networking.wifiEnabled ? networkOff.running = true : networkOn.running = true
                }

                Text { // icon
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: 4
                        anchors.leftMargin: 13
                        text: root.icon
                        font.pixelSize: 40
                        color: Networking.wifiEnabled ? Theme.colors.fgon : Theme.colors.fg
                }

            }
            

            Rectangle { // Bluetooth Module, add functionallity to see devices later
		radius: 16
		id: btModule
                color: Theme.colors.bgdim
                implicitWidth: 170
		implicitHeight: 70
		property bool bluetoothBool: false

                Process {
                    id: bluetoothOn
                    command: ["sh", "-c", "bluetoothctl power on"]
                }

                Process {
                    id: bluetoothOff
                    command: ["sh", "-c", "bluetoothctl power off"]
                }

                 Text { // Network Name
                    text: "Bluetooth"
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 13
                    anchors.rightMargin: 15
                    color: Theme.colors.fg
                    font.family: "Google Sans"
                    font.weight: 600
                    font.pixelSize: 19
                }

                Text { // More info
                    text: "Disabled"
                    font.family: "Google Sans"
                    color: Theme.colors.fg
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 45
                    anchors.bottomMargin: 15
		    font.pixelSize: 14
		    font.weight: 500
                }

                Rectangle {
		    color: parent.bluetoothBool ? Theme.colors.yellow : Theme.colors.off
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 10
                    implicitHeight: 50
                    radius: 10
                    implicitWidth: 50

                    Behavior on opacity {
                        NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
                    }

                    Text { // icon
                        anchors.centerIn: parent
                        text: btModule.bluetoothBool ? "󰂯" : "󰂲"
                        font.pixelSize: 25
			color: Theme.colors.fg	
                        font.family: "JetBrainsMono Nerd Font Propo"
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.opacity = 0.75
                        onExited: parent.opacity = 1
			onClicked: {
			    if (!parent.bluetoothBool) { 
				bluetoothOn.running = true
				parent.bluetoothBool = true 
			    } else {   
				bluetoothOff.running = true 
				parent.bluetoothBool = false 
			    }
			}
		    }
		}
	    }   
	}

