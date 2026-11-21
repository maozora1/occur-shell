import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs

Rectangle {
    id: root
    implicitHeight: 38
    implicitWidth: 130

    color: Colors.md3.background
    clip: true
    radius: 17

    property string currentWorkspace: ""

    Process {
	id: fetchWorkspaceProc
	command: ["sh", "-c", "niri msg --json workspaces | jq -r '.[] | select(.is_focused == true) | .idx'"]
	running: true
	stdout: StdioCollector {
            onStreamFinished: {
                root.currentWorkspace = this.text.trim()
            }
	}
    }

    ColumnLayout {
	anchors.fill: parent
	anchors.margins: 5
	spacing: -4

	Text {
	    text: "Workspace " + root.currentWorkspace
	    color: Colors.md3.primary
	    font.family: "Google Sans"
	    font.pixelSize: 13
	}
	Text {
	    text: "Workspace" 
	    color: Colors.md3.primary
	    font.family: "Google Sans"
	    font.pixelSize: 16
	}
    }

}
