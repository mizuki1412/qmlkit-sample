import QtQuick 2.15
import QtGraphicalEffects 1.12

/*
    width: 72       设置按钮宽度
    height: 28      设置按钮高度
    textSize:15     设置文字大小
    text = ""       设置按钮上的文字内容，缺省为空
    round:false     设置按钮是否圆角，缺省为false
    circle:false    设置按钮是否圆形，缺省为false
    plain:false     设置按钮是否为朴素按钮，缺省为false
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
    property bool plain:false                           //是否为朴素按钮
    property string type:""                             //设置按钮类型

    //button针对不同的type而展现的颜色
    /*
    0   按钮正常颜色
    1   按钮朴素颜色
    2   按钮hover颜色
    3   按钮点击颜色
    */
    property var primary:[$theme.color_primary,$theme.color_primary_plain,$theme.color_primary_hover,$theme.color_primary_click]
    property var success:[$theme.color_success,$theme.color_success_plain,$theme.color_success_hover,$theme.color_success_click]
    property var info:[$theme.color_info,$theme.color_info_plain,$theme.color_info_hover,$theme.color_info_click]
    property var warning:[$theme.color_warning,$theme.color_warning_plain,$theme.color_warning_hover,$theme.color_warning_click]
    property var danger:[$theme.color_danger,$theme.color_danger_plain,$theme.color_danger_hover,$theme.color_danger_click]
    property var typeColor:[]


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
                typeColor = primary
                break;
            case "success":
                typeColor = success
                break;
            case "info":
                typeColor = info
                break;
            case "warning":
                typeColor = warning
                break;
            case "danger":
                typeColor = danger
                break;
            default :
                typeColor = primary
        }
        if(type){
            if(plain){
                button.color = typeColor[1]
                button.border.color = typeColor[0]
                buttonText.color = typeColor[0]
            }
            else{
                button.color = typeColor[0]
                button.border.color = typeColor[0]
                buttonText.color = $theme.color_text
            }
        }
        else{
            button.color = "white"
            button.border.color = $theme.color_default
            buttonText.color = $theme.color_default
        }
    }

    //设置按钮样式
    radius: button.height/5
    color: "white"
    border.width: 0.2
    border.color: $theme.color_default

    //设置按钮的阴影效果
    layer.enabled: true
    layer.effect: DropShadow{
        verticalOffset: 0
        samples:12
        radius:4
        color: $theme.color_default
    }


    Text{
        id:buttonText
//        text:"test"
        anchors.centerIn: parent
//        color:"white"
        font.pixelSize: $theme.font_base
//        font.bold:true
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
            if(type){
                button.color = typeColor[3]
            }
            else{
                if(!plain){
                    button.border.color = typeColor[0]
                }
            }
            button.pressed()
        }
        onEntered:{
            if(type){
                if(plain){
                    button.color =typeColor[0]
                    buttonText.color = $theme.color_text
                }
                else{
                    button.color =typeColor[2]
                }
            }
            else{
                if(plain){
                    button.border.color = typeColor[0]
                    buttonText.color = typeColor[0]
                }
                else{
                    button.color = typeColor[1]
                    button.border.color = typeColor[1]
                    buttonText.color = typeColor[0]
                }
            }
            button.hovered()
        }
        onExited:{
            if(type){
                if(plain){
                    button.color = typeColor[1]
                    button.border.color = typeColor[0]
                    buttonText.color = typeColor[0]
                }
                else{
                    button.color = typeColor[0]
                    button.border.color = typeColor[0]
                    buttonText.color = $theme.color_text
                }
            }
            else{
                button.color = "white"
                button.border.color = $theme.color_default
                buttonText.color = $theme.color_default
            }
            button.exited()
        }
        onReleased:{
            if(type){
                if(plain){
                    button.color =typeColor[0]
                    buttonText.color = $theme.color_text
                }
                else{
                    button.color =typeColor[2]
                }
            }
            else{
                if(plain){
                    button.border.color.color = typeColor[0]
                    buttonText.color = typeColor[0]
                }
                else{
                    button.color = typeColor[1]
                    button.border.color = typeColor[1]
                    buttonText.color = typeColor[0]
                }
            }
            button.released()
        }
        onClicked:{
            button.clicked();
        }
    }
}

