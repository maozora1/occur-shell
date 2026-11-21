import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import qs

Rectangle  {
    implicitHeight: 38
    implicitWidth: 50

    radius: 17

    color: Colors.md3.background

    RowLayout {
	anchors.fill: parent

	Repeater {
            model: SystemTray.items

	    delegate: Item {
		id: trayItem

	    }
	}
    }
}
