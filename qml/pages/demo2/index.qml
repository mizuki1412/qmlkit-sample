import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls.Material
import "../../kit/components"

Rectangle {
    width: parent.width
    height: 2000
    id: demo2
    Row{
        id: r1
        spacing: 12
        height: 100
        Button{
            text: "确认框"
            onClicked: {
                $dao.showConfirm({parentPage: demo2})
            }
        }
        Button{
            text: "信息框"
            onClicked: {
                $dao.showMessage({parentPage: demo2,message:"hello"})
            }
        }
        Button{
            text: "loading框"
            onClicked: {
                $dao.showLoading({parentPage: demo2})
            }
        }
        Button{
            text: "自定义footer"
            onClicked: {
                modal.open()
            }
        }
        KitModal{
            id:modal
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


            scrollContent: ColumnLayout{
                Rectangle {
                    Layout.fillWidth: true
                    height: 400
                    color: "red"
                }
                Rectangle {
                    Layout.fillWidth: true
                    height: 400
                    color: "blue"
                }
                Rectangle {
                    Layout.fillWidth: true
                    height: 400
                    color: "green"
                }
            }
            footer: RowLayout{
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                Text {
                    id: name
                    text: qsTr("text")
                    Layout.alignment: Qt.AlignVCenter
                }
            }

        }

        KitDateTimePicker{
            id: picker
        }

        Button{
            text: "webview"
            onClicked: {
                webpp.open()
            }
        }
        Popup{
            id: webpp
            width: 800
            height: 600
            anchors.centerIn: Overlay.overlay
            closePolicy: Popup.CloseOnEscape
            modal: true
            focus:true
//                KitWebView{
//                    id: webview
//                    anchors.fill: parent
//                    url: "https://www.baidu.com"
//                }
        }

    }

    // todo ?
    ScrollView{
        anchors.top: r1.bottom
        anchors.topMargin: 12
        width:300
        height:300
        Rectangle{
            anchors.top:parent.top
            anchors.left:parent.left
            anchors.right:parent.right
            height: 2000
            color: "green"
            Component.onCompleted:{
                console.log(3,parent.height,this.height)
            }
        }

    }

//    Rectangle{
//        anchors.top: r1.bottom
//        anchors.topMargin: 12
//        width: parent.width
//        height: 2000
//        color: "blue"
//    }

    Component.onCompleted:{
        picker.init(new Date())
        console.log(picker.value)
    }
}
