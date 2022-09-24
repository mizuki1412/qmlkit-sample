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
        height: 20
        color: "black"
    }

    Component.onCompleted: {
    }

}
