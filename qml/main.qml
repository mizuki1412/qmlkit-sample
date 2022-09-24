import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import "./kit/config"
import "./kit/service"

ApplicationWindow {
    id:main
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    // 全局变量区域
    property KitSettings $settings: KitSettings{}
    property KitColor $color: KitColor{}
    property KitTheme $theme: KitTheme{}
    property KitDao $dao: KitDao{}
    property KitUtils $utils: KitUtils{}

    flags: Qt.WindowSystemMenuHint|Qt.WindowTitleHint

    menuBar: MenuBar {
        Menu {
                    title: qsTr("&File")
                    Action { text: qsTr("&New...") }
                    Action { text: qsTr("&Open...") }
                    Action { text: qsTr("&Save") }
                    Action { text: qsTr("Save &As...") }
                    MenuSeparator { }
                    Action { text: qsTr("&Quit") }
                }
                Menu {
                    title: qsTr("&Edit")
                    Action { text: qsTr("Cu&t") }
                    Action { text: qsTr("&Copy") }
                    Action { text: qsTr("&Paste") }
                }
                Menu {
                    title: qsTr("&Help")
                    Action { text: qsTr("&About") }
                }
    }

    Component.onCompleted: {
//        $dao.showMessage({parentPage: main, message:"s2sdsds"})
        console.log(new Date() instanceof String)
    }

}
