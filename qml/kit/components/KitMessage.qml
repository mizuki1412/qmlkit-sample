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
        spacing: 24
        Item{
            Layout.fillHeight: true
        }
        KitIcon {
            source: "\ue6bc"
            size: 24
            color: $theme.color_text_inactive
            Layout.alignment: Qt.AlignCenter
        }
        // todo 长文字时
        Text{
            text: qsTr(message)
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 40
        }
        Item{
            Layout.fillHeight: true
        }
    }
}

