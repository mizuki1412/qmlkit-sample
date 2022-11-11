import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Templates as T

Popup{
    id: loading
    anchors.centerIn: Overlay.overlay
    closePolicy: Popup.CloseOnEscape
    modal: true
    focus:true
    margins: 0
    padding: 0
    width: 200
    height: 200
    property int count:0
    Material.theme: Material.Light

    Timer{
        running: true
        repeat: true
        interval: 1000
        onTriggered: {
            count++
        }
    }
    // 幕布颜色
    T.Overlay.modal: Rectangle {
        color: $color.rgba($theme.color_bg, 0.7)
    }

    background: Rectangle{
        color: "transparent"
    }
    ColumnLayout{
        spacing: 24
        anchors.fill: parent
        Item{
            Layout.fillHeight: true
        }
        BusyIndicator {
        	Material.theme: Material.Light
            running: true
            Layout.alignment: Qt.AlignCenter
        }
        Text {
            text: qsTr("请求中,请等待...")
            color: $color.gray200
            Layout.alignment: Qt.AlignCenter
        }
        RoundButton{
        	Material.theme: Material.Light
            Layout.alignment: Qt.AlignCenter
            visible: count>=5
            font.family: $iconfont.family
            font.pixelSize: 12
            text: "\ue634"
            onClicked: {
                loading.close()
            }
        }
    }

}
