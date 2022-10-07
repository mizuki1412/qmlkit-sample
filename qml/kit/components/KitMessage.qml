import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

KitModal{
    width: 400
    height: 240
    oneButton: true

    property string message: ""
    function setMessage(msg){
        if(msg){
            message = msg
        }
    }

    content: ColumnLayout{
        KitIcon {
            source: "\ue6bc"
            size: 24
            color: "gray"
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: 12
        }
        // todo 长文字时
        Text{
            text: message
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 40
        }
    }
}

