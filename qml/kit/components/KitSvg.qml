import QtQuick
import QtQuick.Shapes
import QtQuick.Controls

/*
  width     大小设置宽度即可，svg都是正方形，宽高一样。
  source    图像路径
  text      底部标签内容
  textSize  底部文字大小
  bgColor   图像背景颜色
*/

Rectangle {
    id:control
    property alias source:img.source
    property alias text: name.text
    property alias textSize:name.font.pixelSize
    property var stateList:[]
    property int defaultSource:0
    property string a :"223"
    signal clicked
    signal doubleClicked
    color:"white"
    width: 100
    height: width
    Component.onCompleted:{
        if(!source.length){
            source = stateList[defaultSource].source
        }
    }

    Image{
        id:img
        anchors.fill: parent
    }
    MouseArea {
        anchors.fill: control
        drag.target: control
        drag.axis: Drag.XAndYAxis//设置拖拽的方式
        onClicked:{
            control.clicked()
        }
        onDoubleClicked: {
            control.doubleClicked()
        }
    }
    Label{
        anchors.horizontalCenter: img.horizontalCenter
        anchors.top: img.bottom
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            id:name
        }
    }

    function changeState(state){
        for(var i of stateList){
            if(i.state === state){
                source = i.source
            }
        }
    }
}
