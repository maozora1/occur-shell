import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

import 'theme.js' as Theme

RowLayout {
    id: root
    spacing: 7
 
    property var sink: Pipewire.defaultAudioSink

    readonly property bool ready: sink && sink.ready
    readonly property bool muted: ready && sink.audio.muted
    readonly property int vol: ready ? Math.round(sink.audio.volume * 100) : 0

    readonly property string icon: { 
        if (!ready) return String.fromCodePoint(0xF0581)
        if (muted) return ""

        if (vol === 0) return String.fromCodePoint(0xF0581)
        if (vol < 34) return String.fromCodePoint(0xF057F)
        if (vol < 67) return String.fromCodePoint(0xF0580)

        return String.fromCodePoint(0xF057E)  
    }
    
    Rectangle {
        implicitHeight: 26
        implicitWidth: root.muted ? 100 : 80
        radius: 20
        color: Theme.colors.bgdim

        Behavior on implicitWidth {
            NumberAnimation { duration: 250; easing.type: Easing.InOutCubic }
        }
        
        Behavior on opacity {
            NumberAnimation { duration: 250; easing.type: Easing.InOutCubic }
        }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: parent.opacity = 0.8
        onExited: parent.opacity = 1
    }

    RowLayout {
        spacing: 1
        anchors.fill: parent
        anchors.leftMargin: 10
    Text {
        id: icon
        text: root.icon
        color: !root.muted ? Theme.colors.yellow : Theme.colors.red
        font {
            family: "JetBrainsMono Nerd Font Propo"
            pixelSize: 17
            weight: 600
        }

        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }
    Text {
        text: {
            if (!root.ready) return "-"
            if (root.muted) return "Muted"

            return root.vol + "%"
        }
        color: !root.muted ? Theme.colors.yellow : Theme.colors.red

        Behavior on color {
            ColorAnimation { duration: 150 }
        }

        font {
            family: "Google Sans"
            weight: 600
            pixelSize: 13
        }
    }
        PwObjectTracker {
            objects: [root.sink]
            }
        }
    }
}
