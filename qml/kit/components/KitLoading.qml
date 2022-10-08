import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup{
    id: loading
    anchors.centerIn: Overlay.overlay
    closePolicy: Popup.CloseOnEscape
    modal: true
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
        anchors.fill: parent
        BusyIndicator {
            running: true

            Layout.alignment: Qt.AlignHCenter
        }
        Text {
            text: qsTr("请等待")
            Layout.alignment: Qt.AlignHCenter
        }
        RoundButton{
            visible: count>=8
            Layout.alignment: Qt.AlignHCenter
            font.family: $iconfont.family
            font.pixelSize: 12
            text: "\ue634"
            onClicked: {
                loading.close()
            }
        }
    }

}
