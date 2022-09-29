import QtQuick
import QtQuick.Controls

MenuBar {
    id:bar
    MenuBarItem{
        onTriggered: {
            $wins.open("qrc:/main/qml/pages/WindowDemo.qml", "多子窗口");
        }
        menu:Menu {
            title: qsTr("多子窗口")
            onOpened: {
                // 取消菜单列表的popup
                this.close()
            }
        }

    }
    Menu {
        title: qsTr("页面demo")
        Action {
            text: qsTr("组件示例")
            onTriggered: {
                mainLoader.source="qrc:/main/qml/pages/Page1.qml"
            }
        }
//        Action {
//            text: qsTr("层叠页面")
//            onTriggered: {
//                mainLoader.source="qrc:/pages/PageStack.qml"
//            }
//        }
//        Action {
//            text: qsTr("多文档窗口")
//            onTriggered: {
//                mainLoader.source="qrc:/pages/PageDocument.qml"
//            }
//        }
        Action {
            text: qsTr("右键菜单")
            onTriggered: {
                $wins.open("qrc:/main/qml/pages/popMenu/PopMenuWindow.qml", "PopMenuWindow");
            }
        }
        Menu {
            title: qsTr("三级菜单")
            Action {
                text: qsTr("page1")
                onTriggered: {
                    mainLoader.source="qrc:/main/qml/pages/Page1.qml"
                }
            }
        }
        MenuSeparator { }
        Action {
            text: qsTr("Quit")
            onTriggered: {
                // 调用Window.close会进onClosing
//                main.close()
                //调用Qt.quit不会进onClosing
                Qt.quit()
            }
        }
    }

}
