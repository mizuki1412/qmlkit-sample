import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./kit/config"
import "./kit/service"
import "./layouts"
import "./pages"

ApplicationWindow {
    id:main
    width: $settings.width
    height: $settings.height
    visible: true
    title: qsTr("Hello World")

    // 全局变量区域
    property KitSettings $settings: KitSettings{}
    property KitColor $color: KitColor{}
    property KitTheme $theme: KitTheme{}
    property KitDao $dao: KitDao{}
    property KitUtils $utils: KitUtils{}

    menuBar: LayoutMenu{}

    Loader{
        id: mainLoader
        width: parent.width
    }

    footer: Rectangle{
        height: 30
        color: $color.gray200
        Label {
            leftPadding: 10
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("状态栏")
        }
    }

    Component.onCompleted: {
    }

    onClosing: function(closeevent){
        //CloseEvent的accepted设置为false就能忽略该事件
        closeConfirm.open()
        closeevent.accepted = false
    }

    Popup{
        id:closeConfirm
        anchors.centerIn: parent
        Column{
            spacing: 10
            Text {
                text: qsTr("确认退出？")
            }
            Button{
                text: "是"
                onClicked: Qt.quit()
            }
            Button{
                text: "否"
                onClicked: closeConfirm.close()
            }
        }
    }

}
