import QtQuick

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
    width: 120
    height: 40

    property alias textSize:buttonText.font.pixelSize   //导出按钮文字字体大小、颜色、内容等属性
    property alias text:buttonText.text                 //按钮上的文字

    property bool round: false                          //是否为圆角
    property bool circle: false                         //是否为圆形按钮，圆形按钮，大小由宽度控制
    property bool plain:false                           //是否为朴素按钮
    property string type:""                             //设置按钮类型

   property color typeColor


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
                typeColor = $theme.color_primary
                break;
            case "success":
                typeColor = $theme.color_success
                break;
            case "info":
                typeColor = $theme.color_info
                break;
            case "warning":
                typeColor = $theme.color_warning
                break;
            case "danger":
                typeColor = $theme.color_danger
                break;
            default :
                typeColor = $theme.color_primary
        }
        if(type){
            if(plain){
                button.color = Qt.lighter(typeColor, 1.7)
                button.border.color = typeColor
                buttonText.color = typeColor
            }
            else{
                button.color = typeColor
                button.border.color = typeColor
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
    border.width: 1
    border.color: $theme.color_default

    Text{
        id:buttonText
        anchors.centerIn: parent
        font.pixelSize: $theme.font_xl
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
                button.color = Qt.darker(typeColor, 1.2)
            }
            else{
                if(!plain){
                    button.border.color = typeColor
                }
            }
            button.pressed()
        }
        onEntered:{
            if(type){
                if(plain){
                    button.color =typeColor
                    buttonText.color = $theme.color_text
                }
                else{
                    button.color =Qt.lighter(typeColor, 1.2)
                    button.border.width= 0
                }
            }
            else{
                if(plain){
                    button.border.color = typeColor
                    buttonText.color = typeColor
                }
                else{
                    button.color = Qt.lighter(typeColor, 1.7)
                    button.border.color = Qt.lighter(typeColor, 1.7)
                    buttonText.color = typeColor
                }
            }
            button.hovered()
        }
        onExited:{
            if(type){
                if(plain){
                    button.color = Qt.lighter(typeColor, 1.7)
                    button.border.color = typeColor
                    buttonText.color = typeColor
                }
                else{
                    button.color = typeColor
                    button.border.width = 0
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
                    button.color =typeColor
                    buttonText.color = $theme.color_text
                }
                else{
                    button.color =Qt.lighter(typeColor, 1.2)
                }
            }
            else{
                if(plain){
                    button.border.color.color = typeColor
                    buttonText.color = typeColor
                }
                else{
                    button.color = Qt.lighter(typeColor, 1.7)
                    button.border.color = Qt.lighter(typeColor, 1.7)
                    buttonText.color = typeColor
                }
            }
            button.released()
        }
        onClicked:{
            button.clicked();
        }
    }
}

