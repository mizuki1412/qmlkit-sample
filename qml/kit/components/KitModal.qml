import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Popup{
    id: pp

    property int modalTitleHeight: 32
    property int modalFootHeight: 48
    property bool noFooter: false
    property bool oneButton: false
    property string yesButtonText: "确定"
    property string noButtonText: "取消"
    property string title:"提示"
    property alias content: loader.sourceComponent
    property alias footer: loaderF.sourceComponent
    property var confirmFun: function(){}

    function setConfirmFun(fun){
        if(fun){
            confirmFun = fun
        }
    }

    anchors.centerIn: Overlay.overlay
    closePolicy: Popup.CloseOnEscape
    modal: true
    margins: 0
    padding: 8
    // focus=false是ecs没用
    focus: true

    // 标题栏
    Rectangle{
        id: comTitle
        width: parent.width
        height: modalTitleHeight
        anchors.top: parent.top
        Text {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment:   Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr(title)
        }
        Button{
            anchors.verticalCenter: parent.verticalCenter
            anchors.top: parent.top
            anchors.right: parent.right
            flat: true
            font.family: $iconfont.family
            font.pixelSize: $theme.font_xs
            text: "\ue634"
            onClicked: {
                pp.close()
            }
        }
        // todo 拖拽在anchors.centerIn无效；而且按钮的click事件被覆盖
//        MouseArea {
//            property point clickPoint: "0,0"
//            anchors.fill: parent
//            acceptedButtons: Qt.LeftButton
//            onPressed: (mouse)=>{
//                clickPoint  = Qt.point(mouse.x, mouse.y)
//            }
//            onPositionChanged: (mouse)=>{
//                let offset = Qt.point(mouse.x - clickPoint.x, mouse.y - clickPoint.y)
//                //设置窗口拖拽不能超过父窗口
//                if(pp.x + offset.x < 0){
//                    pp.x = 0
//                }
//                else if(pp.x + offset.x > pp.parent.width - pp.width){
//                    pp.x = pp.parent.width - pp.width
//                }
//                else {
//                    pp.x = pp.x + offset.x
//                }
//                if(pp.y + offset.y < 0){
//                    pp.y = 0
//                }
//                else if(pp.y + offset.y > pp.parent.height - pp.height){
//                    pp.y = pp.parent.height - pp.height
//                }
//                else {
//                    pp.y = pp.y + offset.y
//                }

//            }
//        }
    }

    Loader{
        id:loader
        anchors.top: comTitle.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: modalFootHeight
    }

    // 底部
    Loader{
        id:loaderF
        visible: !noFooter
        height: modalFootHeight
        anchors.top: loader.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        sourceComponent:     RowLayout{
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            spacing: 16
            Button{
                highlighted: true
                text: qsTr(yesButtonText)
    //            Layout.alignment: Qt.AlignVCenter
                onClicked: {
                    confirmFun()
                    pp.close()
                }
            }
            Button{
                visible: !oneButton
                text: qsTr(noButtonText)
    //            Layout.alignment: Qt.AlignVCenter
                onClicked: {
                    pp.close()
                }
            }
        }
    }
}