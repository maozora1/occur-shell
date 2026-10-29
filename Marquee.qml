import QtQuick

Item {
    id: root

    property alias text: label.text
    property alias color: label.color
    property alias font: label.font
    property real speed: 40      // pixels per second
    property int pause: 1500     // ms to wait at each end

    readonly property real overflow: Math.max(0, label.implicitWidth - width)

    clip: true
    implicitWidth: 0             // so the long text doesn't force the layout wider
    implicitHeight: label.implicitHeight

    function reset() {
        anim.stop()
        label.x = 0
        if (overflow > 0) anim.start()
    }

    onOverflowChanged: reset()

    Text {
        id: label
        x: 0
        // no elide here, or the text would never overflow
    }

    SequentialAnimation {
        id: anim
        loops: Animation.Infinite

        PauseAnimation { duration: root.pause }
        NumberAnimation {
            target: label; property: "x"
            to: -root.overflow
            duration: root.overflow / root.speed * 1000
        }
        PauseAnimation { duration: root.pause }
        NumberAnimation {
            target: label; property: "x"
            to: 0
            duration: root.overflow / root.speed * 1000
        }
    }
}
