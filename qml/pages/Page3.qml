import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import "../kit/components"

Rectangle {
    color: $color.red100
    anchors.fill: parent

    Component.onCompleted: {
        console.log("加载page3")
    }
}
