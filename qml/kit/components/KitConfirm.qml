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
        KitIcon {
            source: "\ue6b2"
            size: 24
            color: "gray"
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: 12
        }
        Text{
            text: message
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 40
        }
    }

}
