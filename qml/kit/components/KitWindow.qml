import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

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
