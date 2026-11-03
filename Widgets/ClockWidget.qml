import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs

PanelWindow {
    id: panWindow
    implicitWidth: 575
    implicitHeight: 300
    exclusionMode: ExclusionMode.Ignore
    color: 'transparent'
    WlrLayershell.layer: WlrLayer.Background

    mask: Region { item: rect; intersection: Intersection.Subtract }

    anchors {
	top: true;
	left: true;
    }

    margins {
	top: 100;
	left: 100;
    }

    SystemClock {
	id: clock2
	precision: SystemClock.Minutes
    }

    readonly property var specialDays: ({
	"10-31": "Happy Halloween!",
	"02-01": "First Day of February",
	"03-01": "First Day of March",
	"04-01": "First Day of April",
	"05-01": "First Day of May",
	"06-01": "First Day of June",
	"06-11": "Happy Birthday!",
	"07-01": "First Day of July",
	"08-01": "First Day of August",
	"09-01": "First Day of September",
	"10-01": "First Day of October",
	"11-01": "First Day of November",
	"12-01": "First Day of December",
	"12-25": "Merry Christmas!",
	"01-01": "Happy New Year!"
    })

    
    readonly property string today: Qt.formatDateTime(clock.date, "MM-dd")
    readonly property string greeting: specialDays[today] ?? ""

    Rectangle {
	id: rect

	ColumnLayout {
	    id: colLayout
	    anchors.fill: parent

	    Text {
		visible: panWindow.greeting !== ""
		text: panWindow.greeting
		color: Colors.md3.primary
		font.family: 'Google Sans'
		font.pixelSize: 24
		wrapMode: Text.WordWrap
		Layout.fillWidth: true
	    }

	    Text {
		color: Colors.md3.primary
                text: Qt.formatDateTime(clock.date, "dddd MMM d")
		font.family: 'Google Sans'
		font.pixelSize: 50

	    }

	    Text {
		color: Colors.md3.primary
                text: Qt.formatDateTime(clock.date, "hh:mm")
		font.family: 'Google Sans'
		font.pixelSize: 90

	    }
	}
	
	SystemClock {
	    id: clock
	    precision: SystemClock.Minutes
	  } 
    }

}
