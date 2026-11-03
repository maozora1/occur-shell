import Quickshell
import QtQuick
import QtQuick.Layouts
import qs

        Rectangle {
          implicitHeight: 35
          implicitWidth: layout.implicitWidth + 20
	  radius: 15
          color: Colors.md3.background
	  RowLayout {
	    id: layout
	    anchors.centerIn: parent
	    implicitWidth: 200

            Text {
                color: Colors.md3.tertiary
                text: Qt.formatDateTime(clock.date, "hh:mm")
                font {
                 family: "Google Sans"
                 letterSpacing: 0
                 pixelSize: 14
                 weight: 600
                }   
            SystemClock {
                 id: clock 
                precision: SystemClock.Minutes
              } 
            }

	    Text {
		color: Colors.md3.on_surface
		text: '•'
	    }

            Text {
                color: Colors.md3.tertiary
                text: Qt.formatDateTime(clock.date, "MMM dd")
                font {
                 family: "Google Sans"
                 letterSpacing: 0
                 pixelSize: 14
                 weight: 600
                }   
            }
	  }
      }
        

        
