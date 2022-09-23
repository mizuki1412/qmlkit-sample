import QtQuick 2.15
import QtQuick.Window 2.15
import "./kit/config"
import "./kit/service"

Window {
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

    Component.onCompleted: {

    }

}
