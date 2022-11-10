import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

KitModal{
    width: 400
    height: 240
    yesButtonText: "是"
    noButtonText: "否"

    property string message: "确认删除?"
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
            source: "\ue6b2"
            size: 24
            color: $theme.color_text_inactive
            Layout.alignment: Qt.AlignCenter
        }
        Text{
            text: qsTr(message)
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 40
            color: $theme.color_text
        }
        Item{
            Layout.fillHeight: true
        }
    }

}
