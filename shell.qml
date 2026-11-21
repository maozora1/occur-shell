import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "Modules" as Modules
import "Widgets" as Widgets
import "OSD" as OSD
import "Menu" as Menu

ShellRoot {
    Menu.MainPanel{}
    Widgets.ClockWidget{}
    Widgets.Visualizer{}
    OSD.CapsOSD{}
    OSD.Notification{}
    Modules.CpuFull{}

    id: root 

    property bool barVisible: true

    IpcHandler {
        target: "bar"
        function toggle() : void { root.barVisible = !root.barVisible }
        function show() : void { root.barVisible = true }
        function hide() : void { root.barVisible = false }
    }

    PanelWindow {
	visible: barVisible
        id: bar
        anchors {
          top:true
          right:true
          left:true
        }
	margins {
	    top: 8
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
	    Modules.CenterButton{}
            Modules.Workspaces {}
	    Modules.Window {}
            Modules.Clock {} 
            //Item { Layout.preferredWidth: 595 }  
            // Center        
            Item { Layout.fillWidth: true } 
            // Right
	    Modules.Memory {}
	    Modules.Tray {}
            Modules.Volume {}
            Modules.Network {}

        }
    }
}
