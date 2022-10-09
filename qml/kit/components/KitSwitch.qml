import QtQuick 2.12
import QtQuick.Controls 2.15


/*
属性
  width:48                      设置switch的长度
  height:26                     设置switch的高度
  inactiveColor:""              设置未激活时的开关颜色
  activeColor:""                设置激活后的开关颜色
  checked:                      获取开关状态,也可以用来初始化
  checkable:                    设置开关是否可用[?还有问题]
事件
  onClicked:{}                  设置点击事件
bug
  初始值checked:true时，checkable:false不起作用，qml原生的switch也有这个问题
  即设置不了：开关打开且开关被禁用的状态
todo
  开关加载状态
*/

Rectangle{

    property color activeColor:$theme.color_success
    property color inactiveColor:"#cccccc"
    property alias checkable:control.checkable
    property alias checked:control.checked
    property color activeColor2

    signal clicked
    id:switch1
    implicitWidth:48
    implicitHeight:26

    Component.onCompleted: {
        if(checkable){
            activeColor2 = activeColor
        }
        else{
            activeColor2 = Qt.lighter(activeColor,2)
        }
    }

    Switch {
            id: control
            width:parent.width
            height:parent.height
            indicator: Rectangle {
                id:control2
                width: parent.width
                height: parent.height

                radius: height/2
                color: control.checked ? activeColor2 : inactiveColor
                // border.color: "#999999"

                //小圆点
                Rectangle {
                    id : smallRect
                    width: parent.height*0.8
                    height: parent.height*0.8
                    radius: height/2
                    anchors.verticalCenter: parent.verticalCenter
                    color: control.down ? "#cccccc" : "#ffffff"
                    // border.color: "#999999"

                    //改变小圆点的位置
                    NumberAnimation on x{
                        to: control2.width-smallRect.width-control2.height*0.1
                        running: control.checked ? true : false
                        duration: 100
                    }

                    //改变小圆点的位置
                    NumberAnimation on x{
                        to: control2.height*0.1
                        running: control.checked ? false : true
                        duration: 100
                    }
                }
            }
            onCheckableChanged: {
                if(checkable){
                    activeColor2 = activeColor
                }
                else{
                    activeColor2 = Qt.lighter(activeColor,2)
                }
            }
        }
    MouseArea{
        anchors.fill:control
        focus: true
        hoverEnabled: true
        propagateComposedEvents: true
        //鼠标图标， hovered 或者 pressed时显示此图标
        cursorShape: checkable?Qt.PointingHandCursor:Qt.ForbiddenCursor
        onClicked:{
            if(checkable){
                control.checked = !control.checked
                switch1.clicked()
            }
        }
    }
}

