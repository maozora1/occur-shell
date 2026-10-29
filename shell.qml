import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import 'theme.js' as Theme

ShellRoot {

    PanelWindow {
        id: bar
        anchors {
          top:true
          right:true
          left:true
        }
	margins {
	    top: 4
	    left: 15
	    right: 15
	}
        implicitHeight: 40
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            color: Theme.colors.bg
	    radius: 20
        }
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            spacing: 8

            // Left
            MenuButton {}
            Workspaces {}
	    Player {}
            Clock {} 
            //Item { Layout.preferredWidth: 595 }  
            // Center        
            Item { Layout.fillWidth: true } 
            // Right
            Volume {}
            Network {}

        }
    }
}
