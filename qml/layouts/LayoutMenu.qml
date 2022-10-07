import QtQuick
import QtQuick.Controls

MenuBar {
    id:bar
    MenuBarItem{
        onTriggered: {
            $wins.open("qrc:/main/qml/pages/Page1.qml", "单菜单窗口");
        }
        menu:Menu {
            title: qsTr("单菜单窗口")
            onOpened: {
                // 取消菜单列表的popup
                this.close()
            }
        }

    }
    Menu {
        title: qsTr("测试")
        Action {
            text: qsTr("基础组件示例")
            onTriggered: {
                $wins.tab("qrc:/main/qml/pages/demo/index.qml",this.text)
            }
        }
        Action {
            text: qsTr("其他组件示例")
            onTriggered: {
                $wins.tab("qrc:/main/qml/pages/demo2/index.qml",this.text)
            }
        }
        Action {
            text: qsTr("拓扑图")
            onTriggered: {
                $wins.open("qrc:/main/qml/pages/demo/topu.qml",this.text)
            }
        }
        MenuSeparator { }
        Action {
            text: qsTr("Quit")
            onTriggered: {
                // 调用Window.close会进onClosing
//                main.close()
                Qt.quit()
            }
        }
    }
    Menu {
        title: qsTr("其他")
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
                $wins.tab("qrc:/main/qml/pages/popMenu/PopMenuWindow.qml", this.text);
            }
        }
        Menu {
            title: qsTr("三级菜单")
            Action {
                text: qsTr("page1")
                onTriggered: {
                    $wins.tab("qrc:/main/qml/pages/Page1.qml",this.text)
                }
            }
        }
    }

}
