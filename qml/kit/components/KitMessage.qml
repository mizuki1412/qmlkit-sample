import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

KitModal{
    id: mod
    width: 400
    height: 240
    oneButton: true

    property string message: ""
    function setMessage(msg){
        if(msg){
            message = msg
        }
    }

    scrollContent:  Item{
        anchors.top: parent.top
        anchors.topMargin: 24
        width: parent.width
        height: message.length/22*16+24
        Text{
            visible: message.length>22
            width: parent.width
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr(message)
            color: $theme.color_text
            wrapMode: Text.Wrap
        }
        Text{
            visible: message.length<=22
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr(message)
            color: $theme.color_text
            wrapMode: Text.Wrap
        }
    }

//            KitIcon {
//                source: "\ue6bc"
//                size: 24
//                color: $theme.color_text_inactive
////                Layout.alignment: Qt.AlignCenter
//            }


}

