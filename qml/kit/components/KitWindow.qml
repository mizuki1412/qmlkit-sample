import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Material

ApplicationWindow {
    width: 800
    height: 600

    Material.theme: Material.System
    Material.primary: Material.Blue
    Material.accent: Material.Blue

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
