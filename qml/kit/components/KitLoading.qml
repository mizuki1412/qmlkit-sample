import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

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

    Timer{
        running: true
        repeat: true
        interval: 1000
        onTriggered: {
            count++
        }
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
            running: true
            Layout.alignment: Qt.AlignCenter
        }
        Text {
            text: qsTr("请等待")
            Layout.alignment: Qt.AlignCenter
        }
        RoundButton{
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
