import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    width: 640
    height: 480
    title: qsTr("login")

    Component.onCompleted: {
        console.log($theme)
    }

}
