import QtQuick 2.15
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import "../qml_UI/MyStyle"
import "../Qml/Style"
import Request 1.0
import QmlEvents 1.0

//确认删除提示框
MyPopup{
    id:busyIndicator
    width: 400
    height: 240
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
                //下半部分
                Rectangle{
                    anchors.fill: parent
                    color: "#222831"
                    Item {
                        anchors.centerIn: parent
                        width:60
                        height:60
                        Rectangle {
                            id: rect
                            width: parent.width
                            height: parent.height
                            color: Qt.rgba(0, 0, 0, 0)
                            radius: width / 2
                            border.width: width / 6 //设置边框，看起来是一个圆环
                            visible: false
                        }
                        //旋转的渐变色，效果是圆环外部看起来转动的颜色变化
                        ConicalGradient {
                           width: rect.width
                           height: rect.height
                           gradient: Gradient {
                                GradientStop { position: 0.0; color: "#687698" }
                                GradientStop { position: 1.0; color: "#37415F" }
                           }
                           source: rect //渐变色作用范围
                           //边框中的一个圆形， 可以看成旋转的头部
                           Rectangle {
                               width: rect.border.width
                               height: width
                               radius: width / 2
                               color: "#37415F"
                           }

                           RotationAnimation on rotation {
                               from: 0
                               to: 360
                               duration: 1000 //旋转速度，默认250
                               loops: Animation.Infinite //一直旋转
                            }
                        }
                    }

                }
            }
        }
    }

}
