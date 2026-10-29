import Quickshell
import QtQuick

import 'theme.js' as Theme

        Rectangle {
          topLeftRadius: 20
          bottomLeftRadius: 20
          topRightRadius: 4
          bottomRightRadius: 4
          implicitHeight: 26
          implicitWidth: 70
          color: Theme.colors.bgdim
            Text {
                color: Theme.colors.magenta
                anchors.centerIn: parent
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
          Rectangle {
          topLeftRadius: 4
          bottomLeftRadius: 4
          topRightRadius: 20
          x: 75
          bottomRightRadius: 20
          implicitHeight: 26
          implicitWidth: 80
          color: Theme.colors.bgdim
            Text {
                color: Theme.colors.magenta
                anchors.centerIn: parent
                text: Qt.formatDateTime(clock.date, "MMM dd")
                font {
                 family: "Google Sans"
                 letterSpacing: 0
                 pixelSize: 14
                 weight: 600
                }   
            SystemClock {
                id: date 
                precision: SystemClock.Minutes
              } 
            }
        }
      }
        

        
