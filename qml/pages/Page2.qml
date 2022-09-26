import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import "../kit/components"

Rectangle {
    color: $color.orange100
    width: parent.width
    height: 1000

    // -------- tabbar demo

    TabBar {
        id: bar
        width: parent.width

        Repeater {
            model: ["First", "Second", "Third", "Fourth", "Fifth"]

            TabButton {
                text: modelData
                width: Math.max(100, bar.width / model.length)
            }
        }
    }


    StackLayout {
        width: parent.width
        anchors.top: bar.bottom
        currentIndex: bar.currentIndex
        Text {
            id: homeTab
            text: "1"
        }
        Text {
            id: discoverTab
            text: "2"
        }
        Text {
            id: activityTab
            text: "3"
        }
        Text {
            text: "4"
        }
        Text {
            text: "5"
        }
    }

}
