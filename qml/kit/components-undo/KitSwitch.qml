import QtQuick 2.12
import QtQuick.Controls


/*
属性
  width:48                      设置switch的长度
  height:26                     设置switch的高度
  activeText:""                 设置switch后面的文字
  activeTextColor:""            设置switch激活后文字的颜色
  inactiveText:""               设置switch前面的文字
  inactiveTextColor:""          设置switch激活前文字的颜色
  textSize:                     设置字体大小
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
    
    property alias activeText:activeText.text
    property alias inactiveText:inactiveText.text
    property color inactiveTextColor: $theme.color_defalut
    property color activeTextColor: $theme.color_primary
    property int textSize:$theme.font_base
    property color activeColor:$theme.color_success
    property color inactiveColor:"#cccccc"
    property alias checkable:control.checkable
    property alias checked:control.checked

    signal clicked
    id:switch1
    width:48
    height:26


    Component.onCompleted:{
        width =width+activeText.contentWidth+inactiveText.contentWidth
        if(checked){
            activeText.color = activeTextColor
        }
        if(!checked){
            inactiveText.color = activeTextColor
        }
    }
    Text{
        id:inactiveText
        anchors.verticalCenter: parent.verticalCenter
        text:""
        font.pixelSize:textSize
        color:inactiveTextColor
    }


    Switch {
            id: control
            width:parent.width-inactiveText.contentWidth-activeText.contentWidth
            height:parent.height
            anchors.left: inactiveText.right
            anchors.leftMargin:8
            indicator: Rectangle {
                id:control2
                implicitWidth: parent.width
                implicitHeight: parent.height

                radius: height/2
                color: control.checked ? activeColor : inactiveColor
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
                        duration: 200
                    }

                    //改变小圆点的位置
                    NumberAnimation on x{
                        to: control2.height*0.1
                        running: control.checked ? false : true
                        duration: 200
                    }
                }
            }
        }
    Text{
        id:activeText
        color:inactiveTextColor
        text: ""
        font.pixelSize:textSize
        anchors.left: control.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin:8
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
                if(checked){
                    activeText.color = activeTextColor
                    inactiveText.color = inactiveTextColor
                }
                if(!checked){
                    inactiveText.color = activeTextColor
                    activeText.color = inactiveTextColor
                }
                switch1.clicked()
            }
        }
    }
}

