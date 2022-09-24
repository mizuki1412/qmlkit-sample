import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: qsTr("‹")
                onClicked: stackView.pop()
            }
            Label {
                text: "Title"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton {
                text: qsTr("⋮")
                onClicked: menu.open()
            }
        }
    }

    StackView {
        id: stackView
        property real offset: 10
        width: 100; height: 100

        initialItem: Component {
            id: page
            Rectangle {
                property real pos: StackView.index * stackView.offset
                property real hue: Math.random()
                color: Qt.hsla(hue, 0.5, 0.8, 0.6)
                border.color: Qt.hsla(hue, 0.5, 0.5, 0.9)
                StackView.visible: true
            }
        }

        pushEnter: Transition {
            id: pushEnter
            ParallelAnimation {
                PropertyAction { property: "x"; value: pushEnter.ViewTransition.item.pos }
                NumberAnimation { properties: "y"; from: pushEnter.ViewTransition.item.pos + stackView.offset; to: pushEnter.ViewTransition.item.pos; duration: 400; easing.type: Easing.OutCubic }
                NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 400; easing.type: Easing.OutCubic }
            }
        }
        popExit: Transition {
            id: popExit
            ParallelAnimation {
                PropertyAction { property: "x"; value: popExit.ViewTransition.item.pos }
                NumberAnimation { properties: "y"; from: popExit.ViewTransition.item.pos; to: popExit.ViewTransition.item.pos + stackView.offset; duration: 400; easing.type: Easing.OutCubic }
                NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 400; easing.type: Easing.OutCubic }
            }
        }

        pushExit: Transition {
            id: pushExit
            PropertyAction { property: "x"; value: pushExit.ViewTransition.item.pos }
            PropertyAction { property: "y"; value: pushExit.ViewTransition.item.pos }
        }
        popEnter: Transition {
            id: popEnter
            PropertyAction { property: "x"; value: popEnter.ViewTransition.item.pos }
            PropertyAction { property: "y"; value: popEnter.ViewTransition.item.pos }
        }
    }

}
