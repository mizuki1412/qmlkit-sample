import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../kit/components"
KitPage {
    header: ToolBar {
        contentHeight: toolButton.implicitHeight
        //调出抽屉窗口的按钮
        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }
        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }
    //抽屉式的窗口结构
    Drawer {
        id: drawer
        width: parent.width * 0.5
        height: parent.height

        Column {
            anchors.fill: parent
            ItemDelegate {
                text: qsTr("第一页")
                width: parent.width
                onClicked: {
                    stackView.push(firstPage)
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("第二页")
                width: parent.width
                onClicked: {
                    stackView.push(secondPage)
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("第三页")
                width: parent.width
                onClicked: {
                    stackView.push(thirdPage)
                    drawer.close()
                }
            }
        }
    }

    //堆叠窗口结构
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: firstPage
        function switchFirstPage()
        {
            stackView.push(firstPage)
        }
    }
    //每一个子窗口
    Component{
        id: firstPage
        Page2{}
    }
    Component {
        id: secondPage
        Page3{}
    }
    Component{
        id:thirdPage
        Page4{}
    }

}
