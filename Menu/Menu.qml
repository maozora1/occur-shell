import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Networking
import Quickshell.Bluetooth
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "theme.js" as Theme
 
Scope {
    id: root
    property bool menuOpen: true // set to true for menu to always be active

    // for volume
    property var sink: Pipewire.defaultAudioSink 
    readonly property bool ready: sink && sink.ready
    readonly property bool muted: ready && sink.audio.muted
    readonly property int vol: ready ? Math.round(sink.audio.volume * 100) : 0
    
    Rectangle {
	implicitHeight: 200
	implicitWidth: 200
	anchors.bottom: parent.bottom
	anchors.left: parent.left

	PowerOpts{}
    }

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

    IpcHandler {
        target: "menu"
        function toggle() : void { root.menuOpen = !root.menuOpen }
        function show() : void { root.menuOpen = true }
        function hide() : void { root.menuOpen = false }
    }

    // Menu
    PanelWindow {
        id: menu
        visible: root.menuOpen
        implicitHeight: 430
        implicitWidth: 430
        anchors {
            top: true
            left: true
        }

        color: "transparent"

        // Main Window
        Rectangle {

           // anchors.fill: parent
            //anchors.leftMargin: 20
            implicitHeight: 400
            implicitWidth: 400
            radius: 12
            color: Theme.colors.bg
            x: 10
            y: root.menuOpen ? 10 : -height

            Behavior on y {
                SpringAnimation { spring: 3.5; damping: 0.5 }
	    }

	    
	    Rectangle {
		implicitHeight: 40
		implicitWidth: 140
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		anchors.leftMargin: 10
		color: "transparent"

		PowerOpts{}
	    }

	    Filter{}
	    DoNotDisturb{}

	    Clock{}

	    Rectangle {
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.topMargin: 7
		anchors.leftMargin: 8
		TopRow {}
	    }

	    Rectangle {
		anchors.bottom: parent.bottom
		anchors.right: parent.right
		anchors.bottomMargin: 54
		anchors.rightMargin: 29
		implicitHeight: 300
		implicitWidth: 40
		color: "transparent"

		Sliders{}
	    }
            

            }
        }
    }
 
