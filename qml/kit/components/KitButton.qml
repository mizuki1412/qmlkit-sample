import QtQuick 2.15
import QtGraphicalEffects 1.12

/*
    width: 72       设置按钮宽度
    height: 28      设置按钮高度
    textSize:15     设置文字大小
    text = ""       设置按钮上的文字内容，缺省为空
    round:false     设置按钮是否圆角，缺省为false
    circle:false    设置按钮是否圆形，缺省为false
    type="primary"  设置按钮类型，区别显示不同颜色风格，有primary,info,warning,success,danger五种。缺省为默认。
*/

Rectangle{
    id: button
    width: 72
    height: 28

    property alias textSize:buttonText.font.pixelSize   //导出按钮文字字体大小、颜色、内容等属性
    property alias text:buttonText.text                 //按钮上的文字

    property bool round: false                          //是否为圆角
    property bool circle: false                         //是否为圆形按钮，圆形按钮下，大小由宽度控制
    property string type:"primary"                             //设置按钮类型

    //button针对不同的type而展现的颜色
    property color primary:"#79BBFF"
    property color success:"#95D475"
    property color info:"#B1B3B8"
    property color warning:"#EEBE77"
    property color danger:"#F89898"


    signal clicked   //可以在外部通过onClicked:等方式获取按钮状态
    signal released
    signal hovered
    signal pressed
    signal exited

    Component.onCompleted: {
        if(circle){
            button.height = button.width
            button.radius = button.height/2
            }
        if(round){
            button.radius = button.height/2
        }
        switch(type){
            case "primary":
                button.color = primary;
                break;
            case "success":
                button.color = success;
                break;
            case "info":
                button.color = info;
                break;
            case "warning":
                button.color = warning;
                break;
            case "danger":
                button.color = danger;
                break;
            default:
                button.color = "white"
                buttonText.color = "black"
        }
    }

    //设置按钮样式
    radius: button.height/5
    color: "white"
    border.width: 1
    border.color: Qt.rgba(238, 238, 238, 0.3)
    opacity: 0.8
    //设置按钮的阴影效果
    layer.enabled: true
    layer.effect: DropShadow{
        verticalOffset: 4
        samples:16
        radius:5
    }


    Text{
        id:buttonText
        text:"test"
        anchors.centerIn: parent
        color:"white"
        font.pixelSize: 15
        //设置文字水平，垂直居中
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    //设置鼠标区域
    MouseArea{
        anchors.fill:parent;
        focus: true
        hoverEnabled: true
        propagateComposedEvents: true
        //鼠标图标， hovered 或者 pressed时显示此图标
        cursorShape: Qt.PointingHandCursor
        onPressed: {
            parent.opacity=1
            button.pressed()
        }
        onEntered:{
            parent.opacity=0.5
            button.hovered()
        }
        onExited:{
            parent.opacity=0.8
            button.exited()
        }
        onReleased:{
            parent.opacity=0.5
            button.released()
        }
        onClicked:{
            button.clicked();
        }
    }
}

