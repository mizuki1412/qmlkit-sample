import QtQuick 2.15
import QtQuick.Controls 2.12

MenuBar {
    id:bar
    Menu {
        title: qsTr("页面demo")
        Action {
            text: qsTr("page1")
            onTriggered: {
                mainLoader.source="qrc:/pages/Page1.qml"
            }
        }
        Action {
            text: qsTr("&Open...")
        }
        Action { text: qsTr("&Save") }
        Action { text: qsTr("Save &As...") }
        MenuSeparator { }
        Action { text: qsTr("&Quit") }
    }
    Menu {
        title: qsTr("&Edit")
        Action { text: qsTr("Cu&t") }
        Action { text: qsTr("&Copy") }
        Action { text: qsTr("&Paste") }
    }
    Menu {
        title: qsTr("&Help")
        Action { text: qsTr("&About") }
    }
}
