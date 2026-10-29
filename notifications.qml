import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import "theme.js" as Config

Scope {
    id: root
    property bool centerOpen: false
    NotificationServer {
        id: server
        actionsSupported: true
        bodySupported: true
        imageSupported: true
        onNotification: n =>{
            history.insert (0,{
                summary: n.summary,
                body: n.body,
                appName: n.appName,
                urgency: n.urgency,
                time: Qt.formatDateTime(new Date(), "HH:mm")
            })
            n.tracked = true
        }
    }


    IpcHandler {
        target: "notifications"
        function toggle() : void { root.centerOpen = !root.centerOpen }
        function show() : void { root.centerOpen = true }
        function hide() : void { root.centerOpen = false }
    }

    // Notification Center
    PanelWindow {
        visible: root.centerOpen
        anchors.top: true
        anchors.left: true
        margins.top: 40
        margins.left: 7
        
        implicitWidth: 580
        implicitHeight: centerCol.implicitHeight + 24
        color: "transparent"

        exclusionMode: ExclusionMode.Ignore

        Rectangle {
            anchors.fill: parent
            radius: 10
            color: Config.colors.bg
        }

        ColumnLayout {
            id: centerCol
            anchors.fill: parent
            anchors.margins: 12
            spacing: 10
            
            RowLayout {
                Layout.fillWidth: true
                spacing: 6
                Text {
                    Layout.fillWidth: true
                    text: "Notifications"
                    color: Config.colors.green
                    font.family: "Google Sans"
                    font.weight: 600
                    font.pixelSize: 15
                    elide: Text.ElideRight
                }
                Text {
                    text: model.time
                }
            }

            Rectangle {
                implicitWidth: 80
                implicitHeight: 30
                radius: 7
                color: '#1d1c1b'
                Text {
                    text: "Clear All"
                    anchors.centerIn: parent
                    visible: history.count > 0
                    color: Config.colors.red 
                    font.family: "Google Sans"
                    font.weight: 500
                    font.pixelSize: 13
                    MouseArea {
                        anchors.fill: parent
                        onClicked: history.clear()
                        }
                    }
                }
            }

    // Notification
    PanelWindow {
        anchors.top: true
        anchors.right: true
        margins.top: 40
        margins.right: 7
        
        implicitWidth: 380
        implicitHeight: Math.max(1, column.implicitHeight)
        color: "transparent"

        exclusionMode: ExclusionMode.Ignore

        ColumnLayout {
            id: column
            width: parent.width
            spacing: 10

            Repeater {
                model: server.trackedNotifications
                delegate: Rectangle {
                    id: ncard
                    required property var modelData

                    Timer {
                        running: ncard.modelData.urgency !== NotificationUrgency.Critical
                        interval: Config.notifications.timeout
                        onTriggered: ncard.modelData.dismiss()
                    }

                    Layout.fillWidth: true
                    Layout.preferredHeight: layout.implicitHeight + 20
                    radius: 13
                    color: '#232222'
                    border.width: 2
                    border.color: modelData.urgency === NotificationUrgency.Critical ? "#ea6962" : "#7daea3"

                    RowLayout {
                        id: layout
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10

                        Image {
                            Layout.preferredHeight: 36
                            Layout.preferredWidth: 36
                            Layout.alignment: Qt.AlignTop
                            fillMode: Image.PreserveAspectFit
                            visible: source.toString() !== ""
                            source: ncard.modelData.image || ncard.modelData.appIcon || ""
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2

                            Text {
                                Layout.fillWidth: true
                                text: ncard.modelData.summary
                                color: "#a9b665"
                                font.family: "Google Sans"
                                font.pixelSize: 17

                                elide: Text.ElideRight
                            }


                            Text {
                                Layout.fillWidth: true
                                visible: text !== ""
                                text: ncard.modelData.body
                                color: "#d4be98"

                                font.family: "Google Sans"
                                font.pixelSize: 14

                                wrapMode: Text.WordWrap
                            }
                        }
                    }

                    MouseArea {
                            anchors.fill: parent
                            onClicked: ncard.modelData.dismiss()
                            }
                        }
                    }
                }  
            }
        }
    }
//}