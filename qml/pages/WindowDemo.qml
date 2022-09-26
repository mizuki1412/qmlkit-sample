import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../layouts"
import "../kit/components"

Rectangle {
    id: win
    width: $settings.width
    height: $settings.height

    RowLayout{
        id: row1
        anchors.top: parent.top
        anchors.left: parent.left
        Button{
            id: btn1
            height: 30
            text: "弹出page2"
            onClicked: {
                $wins.open("qrc:/pages/Page2.qml","Page2");
            }
        }
        Button{
            id: btn2
            height: 30
            text: "加入tab"
            onClicked: {
                $wins.tab("qrc:/pages/Page3.qml","Page3");
            }
        }
        Button{
            id: btn3
            height: 30
            text: "添加page4"
            onClicked: {
                $wins.tab("qrc:/pages/Page4.qml","Page4");
            }
        }
        Button{
            height: 30
            text: "弹出page4"
            onClicked: {
                $wins.open("qrc:/pages/Page4.qml","Page4");
            }
        }
    }



    TabBar {
        id: bar
        anchors.top: row1.bottom
        anchors.topMargin: $theme.margin
        width: parent.width
        currentIndex: $wins.tabCurrentIndex
        onCurrentIndexChanged: {
            console.log("change: ",this.currentIndex)
        }

        Repeater {
            model: $wins.tabModels
            TabButton {
                text: model.title
                width: Math.max(100, bar.width / model.length)
            }
        }
    }

    StackLayout {
        width: parent.width
        anchors.top: bar.bottom
        currentIndex: bar.currentIndex
        Repeater {
            model: $wins.tabModels
            Rectangle{
                Loader{

                    source: model.path
                    height: 600
                    width: parent.width
//                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    onLoaded: {
                        console.log("load:",model.title, model.path)
                    }
                }
            }
        }
    }


    Component.onCompleted: {

    }

//    Timer{
//        running: true
//        repeat: true
//        interval: 1000
//        onTriggered: {
//            console.log(222,rep.model.count)
//            console.log(223,$wins.tabModels.count)
//        }
//    }
}
