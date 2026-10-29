import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io
import QtQuick
import QtQuick.Controls

import 'theme.js' as Theme

	Rectangle {
	    id: root

	    anchors.fill: parent
	    color: "transparent"

	    property var sink: Pipewire.defaultAudioSink 
	    readonly property bool ready: sink && sink.ready
	    readonly property bool muted: ready && sink.audio.muted
	    readonly property int vol: ready ? Math.round(sink.audio.volume * 100) : 0

	    
	    // Mute Audio
	    Process {
		id: mute
		running: false
		command: ["sh", "-c", "wpctl set-mute @DEFAULT_AUDIO_SINK@ 1"]
	    }

	    // Unmute Audio
	    Process {
		id: unmute
		running: false
		command: ["sh", "-c", "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0"]
	    }

            // Volume Slider UNFINISHED
            Rectangle {
                radius: 10
		anchors.centerIn: parent
                color: Theme.colors.bgdim
                implicitWidth: 60
                implicitHeight: 220

                Slider { // UNFINISHED
                    id: volumeSlider
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.topMargin: 15
                    anchors.rightMargin: 18
                    from: 1
                    value: root.vol
                    to: 100
                    orientation : Qt.Vertical

                    onMoved: {
                        volumeProc.running = true;
                    }

                    
                    Process {
                        id: volumeProc
                        running: false
                        command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", (volumeSlider.value / 100).toFixed(2)]
                    }

                    handle: Rectangle {            
                        y: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableHeight - height)
                        x: volumeSlider.topPadding + volumeSlider.availableWidth / 2 - width / 2
                        radius: 4
                        implicitHeight: 5
                        implicitWidth: 25

                    }
                }
                
                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.bottomMargin: 10
                    anchors.rightMargin: 18
                    color: '#484543'
                    implicitHeight: 25
                    implicitWidth: 25
                    radius: 7

                    Behavior on opacity {
                        NumberAnimation { duration: 250; easing.type: Easing.InOutCubic }
                    }

                    Text {
                        text: root.muted ? "" : ""
                        anchors.centerIn: parent
                        color: root.muted ? Theme.colors.red : Theme.colors.green
                        font.pixelSize: 15
                        font.family: "JetBrainsMono Nerd Font Propo"

                        Behavior on color {
                            ColorAnimation { duration: 250 }
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.opacity = 0.75
                        onExited: parent.opacity = 1
                        onClicked: root.muted ? unmute.running = true : mute.running = true
                    }       
                }
            }

            Rectangle {
                anchors.top: parent.top
                anchors.topMargin: 41
                anchors.rightMargin: 59
                radius: 10
                color: Theme.colors.bgdim
                anchors.right: parent.right
                implicitWidth: 60
                implicitHeight: 220

                Slider { // UNFINISHED
                    id: brightnessSlider
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.topMargin: 15
                    anchors.rightMargin: 18
                    from: 1
                    value: 65
                    to: 100
                    orientation : Qt.Vertical

                    handle: Rectangle {            
                        y: brightnessSlider.leftPadding + brightnessSlider.visualPosition * (brightnessSlider.availableHeight - height)
                        x: brightnessSlider.topPadding + brightnessSlider.availableWidth / 2 - width / 2
                        radius: 4
                        implicitHeight: 5
                        implicitWidth: 25

                    }
                }
                
                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.bottomMargin: 10
                    anchors.rightMargin: 18
                    color: '#484543'
                    implicitHeight: 25
                    implicitWidth: 25
                    radius: 7

                    Behavior on opacity {
                        NumberAnimation { duration: 250; easing.type: Easing.InOutCubic }
                    }

                    Text {
                        text: "󰃠"
                        anchors.centerIn: parent
                        color: root.muted ? Theme.colors.cyan : Theme.colors.blue
                        font.pixelSize: 15
                        font.family: "JetBrainsMono Nerd Font Propo"

                        Behavior on color {
                            ColorAnimation { duration: 250 }
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.opacity = 0.75
                        onExited: parent.opacity = 1
                        onClicked: root.muted ? unmute.running = true : mute.running = true
                        }
                    }
		    PwObjectTracker {
			objects: [root.sink]
		    }
                }
	    }
