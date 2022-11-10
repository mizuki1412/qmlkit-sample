import QtQuick

Item {
    id: ic
    property int size: 16
    width:  size
    height: size
    property alias color: content_text.color
    property alias source: content_text.text
    property alias text: content_text.text

    Text {
        id:content_text
        anchors.fill: parent;
        font.family:      $iconfont.family
        font.pixelSize:   ic.size
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment:   Text.AlignVCenter
    }

}
