import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "../qml_UI/MyStyle"
import "../Qml/Style"

//确认删除提示框
MyPopup{
    id:componet_confirm
    width: 400
    height: 240
    property var confirmFun: function(){}
    property string message: "确认删除?"

    function setMessage(msg){
        if(msg){
            message = msg
        }

    }

    function setConfirmFun(fun){
        if(fun){
            confirmFun = fun
        }
    }
    Rectangle {
        id:componet_confirm_in
        anchors.fill: parent

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
                            componet_confirm.close()
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
                        text: message
                        anchors{
                            horizontalCenter: parent.horizontalCenter
                            top: parent.top
                            topMargin: 84
                        }
                    }
                    Row{
                        anchors{
                            right: parent.right
                            rightMargin: 16
                            bottom: parent.bottom
                            bottomMargin: 16
                        }
                        spacing: 8
                        MyButton{
                            text: "否"
                            onClicked: {
                                componet_confirm.close()
                            }
                        }
                        MyButton{
                            text: "是"
                            onClicked: {
                                confirmFun()
                                componet_confirm.close()
                            }
                        }
                    }
                }


            }
        }
    }
}
