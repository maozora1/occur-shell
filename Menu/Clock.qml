import Quickshell
import QtQuick
import QtQuick.Layouts

import 'theme.js' as Theme

RowLayout {
    anchors.left: parent.left
    anchors.leftMargin: 10
    anchors.bottomMargin: 55
    anchors.bottom: parent.bottom

    Rectangle {
	radius: 15
	color: Theme.colors.bgdim
	implicitWidth: 115
	implicitHeight: 180
    }

    Rectangle {
	radius: 15
	color: Theme.colors.bgdim
	implicitWidth: 115
	implicitHeight: 180
    }

    SystemClock {
      id: clock
      precision: SystemClock.Minutes
    }

    Text {
      text: Qt.formatDateTime(clock.date, "hh mm")
      color: Theme.colors.fg
      font.family: "Google Sans"
      font.pixelSize: 80
      font.weight: 650
      font.letterSpacing: 5
      anchors.left: parent.left
      anchors.leftMargin: 15
    }
}
