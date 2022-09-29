import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import "../kit/components"

Rectangle {
    color: $color.red100
    anchors.fill: parent

    Component.onCompleted: {
        console.log("加载page3")
    }
}
