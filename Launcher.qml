pragma ComponentBehavior: Bound

import "services"
import qs.config
import qs.components
import qs.services
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

StyledPanelWindow {
    id: window
    name: "launcher"

    visible: Visibility.launcher
    onVisibleChanged: {
        if (!visible) {
            list.currentIndex = 0;
            search.clear();
        }
        Visibility.launcher = focused;
    }
    implicitWidth: rect.width
    implicitHeight: rect.height

    WrapperItem {
        id: rect

        margin: 18

        ColumnLayout {
            StyledWrapperRectangle {
                id: searchWrapper

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop

                color: Styling.theme.base200

                RowLayout {
                    LucideIcon {
                        Layout.leftMargin: 8
                        text: Styling.lucide.icons.search
                    }

                    StyledTextField {
                        id: search

                        Layout.fillWidth: true
                        implicitHeight: 40
                        cursorVisible: true
                        focus: window.visible

                        placeholderText: "Applications"
                        placeholderTextColor: "grey"

                        Keys.onEscapePressed: event => {
                            event.accepted = true;
                            Visibility.launcher = false;
                        }
                        Keys.onReturnPressed: event => {
                            event.accepted = true;
                            Apps.launch(list.currentItem.modelData);
                            Visibility.launcher = false;
                        }
                        Keys.onUpPressed: event => {
                            event.accepted = true;
                            list.decrementCurrentIndex();
                        }
                        Keys.onDownPressed: event => {
                            event.accepted = true;
                            list.incrementCurrentIndex();
                        }
                    }
                }
            }

            Item {
                implicitWidth: list.width
                implicitHeight: list.height
                AppList {
                    id: list
                    search: search
                }
            }
        }
    }
}
