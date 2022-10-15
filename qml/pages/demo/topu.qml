import QtQuick
import QtQuick.Shapes
import QtQuick.Controls
import "../../kit/components"

KitPage {
    anchors.fill: parent
    Component.onCompleted: {
    }
    KitSvg{
        id:device1
        width:50
        defaultSource: 0
        x:parent.width*0.4
        y:parent.width*0.4
        text:qsTr("主机1")
        stateList: [{state:"normal",source:"qrc:/main/qml/assets/svg/device_default.svg"},{state:"success",source:"qrc:/main/qml/assets/svg/device_success.svg"},{state:"error",source:"qrc:/main/qml/assets/svg/device_error.svg"}]
        onClicked: {
            this.changeState("success")
        }
    }
    KitSvg{
        id:device2
        width:50
        x:parent.width*0.5
        y:parent.width*0.5
        defaultSource: 0
        text:qsTr("主机2")
        stateList: [{state:"normal",source:"qrc:/main/qml/assets/svg/device_default.svg"},{state:"success",source:"qrc:/main/qml/assets/svg/device_success.svg"},{state:"error",source:"qrc:/main/qml/assets/svg/device_error.svg"}]
        onClicked: {
            this.changeState("success")
        }
    }
    KitLine{
        from:device1
        to:device2
    }
}

