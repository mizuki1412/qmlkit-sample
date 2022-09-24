import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../layouts"

ApplicationWindow {
    id: win
    width: $settings.width
    height: $settings.height
    visible: true
    title: qsTr("window demo")

    menuBar: LayoutMenu{}

    Loader{
        id: mainLoader
        width: parent.width
    }

    footer: Rectangle{
        height: 20
        color: $color.emerald300
    }

    Component.onCompleted: {
    }

}
