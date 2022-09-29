import QtQuick
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "../qml_UI/MyStyle"
import "../Qml/Style"

//当result = 0时弹出该错误提示信息框
MyPopup{
    id:popup_message
    width: 400
    height: 240

    function setMessage(msg){
        message_fault.msg_text = msg
    }

    Rectangle {
        id:message_fault
        anchors.fill: parent

        property string msg_text

        Item {
            anchors.fill: parent
            Rectangle {
                id: rectangle
                color: "#222831"
                border.width: 0
                anchors.fill: parent
                //标题栏
                Rectangle{
                    id:title
                    width: parent.width
                    height: 32
                    color: "#484E58"
                    anchors.top: parent.top
                    MyText {
                        text: qsTr("提示")
                        anchors.centerIn: parent
                    }
                    CusButton_Image{
                        width: 56
                        height: 32
                        anchors.right: parent.right
                        Image {
                            source: "qrc:/Image/Icon/icon_close_small.png"
                        }
                        tipText: qsTr("关闭")
                        onClicked: {
                            popup_message.close()
                        }
                    }
                }
                //下半部分
                Rectangle{
                    width: parent.width
                    height: parent.height-title.height
                    anchors.bottom: parent.bottom
                    color: "#222831"
                    Image {
                        source: "qrc:/Image/Icon/Popup/icon_question.png"
                        anchors{
                            horizontalCenter: parent.horizontalCenter
                            top: parent.top
                            topMargin: 24
                        }
                    }
                    MyText{
                        text: message_fault.msg_text
                        anchors{
                            horizontalCenter: parent.horizontalCenter
                            top: parent.top
                            topMargin: 84
                        }
                    }

                    MyButton{
                        text: "确定"
                        anchors{
                            right: parent.right
                            rightMargin: 16
                            bottom: parent.bottom
                            bottomMargin: 16
                        }
                        onClicked: {
                            popup_message.close()
                        }
                    }
                }
            }
        }
    }
}

