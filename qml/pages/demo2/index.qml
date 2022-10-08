import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls.Material
import "../../kit/components"

Rectangle {
    id: demo2
    width:1000
    height:1000
    Flickable{
        id:flick
        anchors.fill: parent
        clip: true
        contentHeight: 2000
        contentWidth: parent.width

        Row{
            spacing: 12
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


                content: ColumnLayout{
                    KitIcon {
                        source: "\ue6b2"
                        size: 24
                        color: "gray"
                        Layout.alignment: Qt.AlignCenter
                        Layout.topMargin: 12
                    }
                    Text{
                        text: "合适的话电话"
                        Layout.alignment: Qt.AlignCenter
                        Layout.preferredHeight: 40
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

                }
            }
        }
    }
}
