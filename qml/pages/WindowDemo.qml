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
    title: qsTr("多子窗口demo")

    menuBar: LayoutMenu{}

    Loader{
        id: winLoader
        width: parent.width
    }

    Component.onCompleted: {
    }

}
