import QtQuick
import QtQuick.Controls.Material

Rectangle {
    anchors.top: name.bottom
    width: 40
    height: 40
    id: img
    color: "grey"
    Image {
        anchors.centerIn: parent
        Material.background: "white"
        width: 30
        height: 30
        source: "qrc:/qml/kit/assets/svg/search.svg"
    }
}
