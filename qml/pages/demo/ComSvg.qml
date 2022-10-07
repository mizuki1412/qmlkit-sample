import QtQuick
import QtQuick.Controls.Material

Rectangle {
    width: 40
    height: 40
    id: img
    color: "blue"
    Image {
        anchors.centerIn: parent
        Material.foreground: "red"
        Material.background: "red"
        Material.accent: "red"
        smooth: true
        width: 30
        height: 30
        source: "qrc:/main/qml/kit/assets/svg/search"
    }
}
