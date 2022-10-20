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
    property string path

    ScrollView{
        id: scroll_kit_win
        anchors.fill: parent
        Loader{
            id: loader_kit_win
            anchors.top:parent.top
            anchors.left:parent.left
            anchors.right:parent.right
            source: path
            Component.onCompleted:{
                // 自适应内部元素高度，内部组件不可设置anchors
//                loader_kit_win.item.implicitHeight = loader_kit_win.item.childrenRect.height+8
            }
        }
    }
}
