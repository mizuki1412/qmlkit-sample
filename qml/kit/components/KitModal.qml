import QtQuick
import QtQuick.Controls
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

    // 标题栏
    Rectangle{
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
    }

    Loader{
        id:loader
        anchors.fill: parent
        anchors.topMargin: modalTitleHeight
        anchors.bottomMargin: modalFootHeight
    }

    // 底部
    RowLayout{
        visible: !noFooter
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
