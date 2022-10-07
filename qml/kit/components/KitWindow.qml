import QtQuick
import QtQuick.Window
import QtQuick.Controls

ApplicationWindow {
    width: 800
    height: 600
    // 用于KitWinMng管理
    property string key
    onClosing: function(){
        $wins.close(key)
    }

    Loader{
        id: content
        anchors.fill: parent
        source: key
    }
}
