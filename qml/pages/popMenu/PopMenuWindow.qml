import QtQuick 2.5
import QtQuick.Window 2.2

Rectangle {
    width: 500
    height: 300

    RightPopUpMenu {
        id: rightPopUpMenu
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: {
            if (mouse.button === Qt.RightButton) {
                rightPopUpMenu.popup();
            }
        }
    }
}
