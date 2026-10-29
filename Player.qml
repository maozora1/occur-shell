import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

import 'theme.js' as Theme

ClippingRectangle {
    id: root

    implicitWidth: 240
    implicitHeight: 30
    radius: 40
    color: Theme.colors.bgdim

    property MprisPlayer player: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null
    
    ColorQuantizer {
	id: quantizer
	source: player?.trackArtUrl || ""
	depth: 2           // gives 2^depth colors
	rescaleSize: 64     // downsizes the image first, which is faster
    }

    RowLayout {
        anchors.fill: parent
        spacing: 12

	ClippingRectangle {
	    implicitHeight: 30
	    implicitWidth: 30
	    color: Theme.colors.magenta
	    radius: 8

	    Image {
		source: player?.trackArtUrl || ""
		anchors.fill: parent
		fillMode: Image.PreserveAspectCrop
	    }
	}

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 2

            Text {
                text: player?.trackTitle || "No Media Playing"
                Layout.fillWidth: true
		font.family: "Google Sans"
		color: quantizer.colors.length > 0 ? quantizer.colors[0] : Theme.colors.fg
		Behavior on color { ColorAnimation { duration: 300 } }
            }

            Text {
                text: player?.trackArtist || "Unknown Artist"
                Layout.fillWidth: true
		font.family: "Google Sans"
		color: quantizer.colors.length > 0 ? quantizer.colors[0] : Theme.colors.fg
		Behavior on color { ColorAnimation { duration: 300 } }
            }
        }

        RowLayout {
            spacing: 8

            Button {
                text: "⏮"
                enabled: player?.canGoPrevious ?? false
                onClicked: player?.previous()
		implicitWidth: 30
		implicitHeight: 30
            }

            Button {
                text: player?.playbackState === MprisPlaybackState.Playing ? "⏸" : "▶"
                enabled: player?.canTogglePlaying ?? false
                onClicked: player?.togglePlaying()
		implicitWidth: 30
		implicitHeight: 30
            }

            Rectangle {
		Text {
		    text: "󰒭"
		    font.family: "JetBrainsMono Nerd Font Propo"
		    font.pixelSize: 19
		    anchors.centerIn: parent
		    color: Theme.colors.fgdim
		}

	        color: Theme.colors.magenta
		implicitWidth: 30
		implicitHeight: 30
		radius: 20

		MouseArea {
		    anchors.fill: parent
                    enabled: player?.canGoNext ?? false
                    onClicked: player?.next()
		}
            }
        }
    }
}
