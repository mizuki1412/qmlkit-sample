import QtQuick 2.12
import QtQml 2.12
import QtQuick.Controls 2.12
import QmlEvents 1.0
import "./Qml/Page"
import "./qml_UI/MyStyle"
import "./Qml/Style"
import "./"
import Theme 1.0

//登录界面
ApplicationWindow{
    //Rectangle {
    id:loginPage
    width: 1200
    height: 720
    visible: true

    //设置无边界
    flags: Qt.Window
           |Qt.FramelessWindowHint
           |Qt.WindowMinMaxButtonsHint
    color: "#00061B"

    Image
    {
        source: "qrc:/Image/Window/bg_login.png"
    }

    CusButton_Image{
        width: 24
        height: 24
        anchors.right: parent.right
        anchors.rightMargin: 24
        anchors.top: parent.top
        anchors.topMargin: 16
        Image {
            source: "qrc:/Image/Window/close_gray.png"
        }
        tipText: qsTr("close")
        onClicked: {
            loginPage.close()
        }
    }

    Row {
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.top: parent.top
        anchors.topMargin: 16
        spacing: 8


        Image{
            width: 24
            height:24
            source: "qrc:/Image/logo/icon.png"

        }
        Text {
            id: t
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 14
            font.bold: true
            text: "卫星地面站运管系统"
            color: "#EEEEEE"
            //            font.family: PingFangSC-Regular
        }

    }

    Rectangle    //和窗口一样大的矩形
    {
        anchors.fill: parent
        color:"transparent"
        Button
        {
            id:button
            width: 500
            height: 480

            anchors{
                left: parent.left
                leftMargin: 628
            }
            anchors.top:parent.top
            anchors.topMargin:  120
            MouseArea
            {
                id:mouse_window_button
                pressAndHoldInterval: 3000
                acceptedButtons: Qt.LeftButton | Qt.RightButton
            }

            background:Rectangle
            {
                color: "#222831"
            }
            onPressAndHold:
            {
                ppp.open()
            }


            Rectangle
            {
                id:rec2
                width: 500
                height: 480
                anchors.fill: parent
                color: "#222831"

                Text
                {
                    id: text1
                    anchors.left: rec2.left
                    anchors.leftMargin:  35
                    anchors.top:  rec2.top
                    anchors.topMargin:  30
                    text: ("Hi~")
                    color: "#EEEEEE"
                    //                    font.family: "PingFangSC-Medium"
                    font.pixelSize: 20
                }

                Text
                {
                    id: text2
                    text: ("欢迎登录卫星地面站运管系统")
                    anchors.left: text1.left
                    anchors.top:  text1.bottom
                    anchors.topMargin: 5
                    font.letterSpacing: 2

                    color: "#EEEEEE"
                    //                    font.family: "PingFangSC-Medium"
                    font.pixelSize: 20
                }

                Rectangle
                {
                    id:rec3
                    width: 400
                    height: 50
                    anchors.left: rec2.left
                    anchors.leftMargin: 35
                    anchors.top:text2.bottom
                    anchors.topMargin:  80
                    radius:25
                    opacity:0.8
                    color: "#41464e"
                    Image
                    {
                        id: rec3_text
                        anchors.left: rec3.left
                        anchors.verticalCenter:  rec3.verticalCenter
                        anchors.topMargin:  2
                        anchors.leftMargin: 25
                        source: "qrc:/Image/Icon/icon_user.png"
                    }
                    TextField
                    {
                        id: text_user_name
                        font.pointSize: 16

                        horizontalAlignment: TextField.AlignHCenter // 文本水平对齐方式
                        anchors.horizontalCenter: rec3.horizontalCenter
                        anchors.verticalCenter: rec3.verticalCenter
                        background: Rectangle
                        {
                            color:"transparent"
                        }

                        selectByMouse: true      //允许鼠标剪贴
                        placeholderText: "请输入用户名"
                        text:"admin"
                        color: "black"
                        focus: true        // 不设置焦点，获取不了键盘事件
                        Keys.enabled: true // 不设置按键使能，获取不了按键事件
                        //大回车键按下
                        Keys.onReturnPressed: {
                            text_passward.focus = true
                            console.log("回车键按下")
                        }
                    }
                }

                Rectangle
                {
                    id:rec4
                    width: 400
                    height: 50
                    anchors.left: rec2.left
                    anchors.leftMargin: 35
                    anchors.top:rec3.bottom
                    anchors.topMargin:  30
                    radius:25
                    opacity:0.8
                    color: "#41464e"

                    Image
                    {
                        id: rec4_text
                        anchors.left: rec4.left
                        anchors.verticalCenter:  rec4.verticalCenter
                        anchors.topMargin:  2
                        anchors.leftMargin: 25
                        source: "qrc:/Image/Icon/icon_password.png"

                    }
                    TextField
                    {
                        id: text_passward
                        font.pointSize: 16
                        horizontalAlignment: TextField.AlignHCenter // 文本水平对齐方式

                        anchors.horizontalCenter: rec4.horizontalCenter
                        anchors.verticalCenter: rec4.verticalCenter
                        background: Rectangle
                        {
                            color:"transparent"
                        }

                        selectByMouse: true      //允许鼠标剪贴
                        placeholderText: "请输入密码"
                        echoMode: TextInput.Password
//                        text: "123456"
                        text:"999999"
                        color:"black"
                    }

                }

                Rectangle
                {
                    id:rec5
                    width: 400
                    height: 56
                    anchors.left: rec2.left
                    anchors.leftMargin: 35
                    anchors.top:rec4.bottom
                    anchors.topMargin:  30
                    radius:30
                    opacity:0.1
                    color: "#00adb5"

                    Text {
                        id: rec5_text
                        color: "#EEEEEE"
                        //                        font.family: "PingFangSC-Medium"
                        font.pixelSize: 20
                        anchors.centerIn: rec5
                        text: ("登录")
                    }



                    MouseArea
                    {
                        id:rec5_mouse
                        anchors.fill: rec5
                        hoverEnabled: true       //启动悬停
                        acceptedButtons:  Qt.LeftButton	//左键按下触发
                        pressAndHoldInterval: 3000
                        onHoveredChanged:{
                            animateOpacity.start()
                        }
                        cursorShape: Qt.PointingHandCursor//鼠标进入区域鼠标指针变成手型
                        onClicked: {
                            Request.request({   urlPath: "/rest/user/loginByUsername",
                                                params:{username: text_user_name.text, pwd:text_passward.text},
                                                parentPage: loginPage
                                            },function (res){
                                                window.visible = true
                                                rootBackground.visible = true
                                                loginPage.visible = false
                                                QmlEvents.loadHome()
                                                Theme.margin = 24
                                            })

                        }

                        NumberAnimation
                        {
                            id: animateOpacity  //通过点击，将透明度从0.1改成1
                            target: rec5
                            properties: "opacity"
                            from: 0.1
                            to: 1.0
                            duration: 1500
                        }
                        NumberAnimation
                        {
                            id: animateclose  //通过点击，将透明度从0.1改成1
                            target: rec5
                            properties: "opacity"
                            from: 1.0
                            to: 0.1
                            duration: 1500
                        }
                    }

                }

            }
        }
        Popup
        {
            id:ppp
            width: 500
            height: 300
            x:300
            y:250
            modal:true
            closePolicy:Popup.NoAutoClose    //手动关闭

            enter:Transition     //进入动画
            {
                NumberAnimation
                {
                    property: "opacity"		//透明度
                    from: 0.1
                    to:0.9
                    duration: 600
                }
            }

            contentItem: Rectangle
            {
                id:ppp_rec
                color:"#222831"
                opacity: 0.9
                anchors.fill:parent

                Text
                {
                    id: ppp_text
                    x:130
                    y:90
                    font.letterSpacing: 10

                    color: "white"
                    font.family: "PingFangSC-Medium"
                    font.pointSize: 20
                    text: ("是否退出程序")
                }
                Button
                {
                    id: ppp_but1
                    x:150
                    y:200
                    width: 50
                    height: 30
                    flat:true        //平面按钮不绘制背景，除非被按下

                    Text
                    {
                        x:15
                        y:5
                        id: pop_button_yes
                        color: "white"
                        font.family: "PingFangSC-Medium"
                        font.pointSize: 15
                        text: ("是")
                    }
                    onClicked:
                    {
                        loginPage.close()
                    }
                }
                Button
                {
                    id: ppp_but2
                    x:280
                    y:200
                    width: 50
                    height: 30
                    flat:true
                    onClicked:
                    {
                        ppp.close()      //关闭界面
                    }

                    Text
                    {
                        x:15
                        y:5
                        id: pop_button_no
                        color: "white"
                        font.family: "PingFangSC-Medium"
                        font.pointSize: 15

                        text: ("否")
                    }
                }
            }

        }
    }
}


