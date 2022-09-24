import QtQuick 2.15
import QtQuick.Controls 2.12

MenuBar {
    id:bar
    Menu {
        title: qsTr("页面demo")
        Action {
            text: qsTr("page1")
            onTriggered: {
                mainLoader.source="qrc:/pages/Page1.qml"
            }
        }
        Action {
            text: qsTr("轮播页面")
            onTriggered: {
                mainLoader.source="qrc:/pages/PageSwiper.qml"
            }
        }
        Action {
            text: qsTr("层叠页面")
            onTriggered: {
                mainLoader.source="qrc:/pages/PageStack.qml"
            }
        }
        Action {
            text: qsTr("多文档窗口")
            onTriggered: {
                mainLoader.source="qrc:/pages/PageDocument.qml"
            }
        }
        Action {
            text: qsTr("右键菜单")
            onTriggered: {
                var component = Qt.createComponent("qrc:/pages/popMenu/PopMenuWindow.qml");
                var window = component.createObject();
                window.show()
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
    Menu {
        title: qsTr("多子窗口")
        Action {
            text: qsTr("demo")
            onTriggered: {
                mainLoader.source="qrc:/pages/WindowDemo.qml"
            }
        }
    }
}
