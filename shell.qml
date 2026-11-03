import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "Modules" as Modules
import "Widgets" as Widgets
import "OSD" as OSD

ShellRoot {
    Widgets.ClockWidget{}
    Widgets.Visualizer{}
    OSD.CapsOSD{}

    PanelWindow {
        id: bar
        anchors {
          top:true
          right:true
          left:true
        }
	margins {
	    top: 5
	    left: 15
	    right: 15
	}
        implicitHeight: 40
        color: "transparent"

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            spacing: 8

            // Left
            Modules.Workspaces {}
            Modules.Clock {} 
            //Item { Layout.preferredWidth: 595 }  
            // Center        
            Item { Layout.fillWidth: true } 
            // Right
            Modules.Volume {}
            Modules.Network {}

        }
    }
}
