import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import "../layouts"
import "../kit/components"

Rectangle {
    id: win
    width: $settings.width
    height: $settings.height

    Connections{
        target: $wins
        function onTabCurrentIndexChange(index){
            bar.setCurrentIndex(index)
        }
    }

    RowLayout{
        id: row1
        anchors.top: parent.top
        anchors.left: parent.left
        Button{
            id: btn1
            height: 30
            text: "弹出page2"
            onClicked: {
                $wins.open("qrc:/main/qml/pages/Page2.qml","Page2");
            }
        }
        Button{
            id: btn2
            height: 30
            text: "加入tab"
            onClicked: {
                $wins.tab("qrc:/main/qml/pages/Page3.qml","Page3");
            }
        }
        Button{
            id: btn3
            height: 30
            text: "添加page4"
            onClicked: {
                $wins.tab("qrc:/main/qml/pages/Page4.qml","Page4");
            }
        }
        Button{
            height: 30
            text: "弹出page4"
            onClicked: {
                $wins.open("qrc:/main/qml/pages/Page4.qml","Page4");
            }
        }
    }

    TabBar {
        id: bar
        anchors.top: row1.bottom
        anchors.topMargin: $theme.margin
        width: parent.width
        onCurrentIndexChanged: {
            console.log("change: ",this.currentIndex)
        }
        property color backgroundColor: "white"
        property color borderColor: "black"

        implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                contentWidth + leftPadding + rightPadding)
        implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                 contentHeight + topPadding + bottomPadding)
        spacing: 1
//        contentItem: ListView {
//            model: parent.contentModel
//            currentIndex: parent.currentIndex

//            spacing: parent.spacing
//            orientation: ListView.Horizontal
//            boundsBehavior: Flickable.StopAtBounds
//            flickableDirection: Flickable.AutoFlickIfNeeded
//            snapMode: ListView.SnapToItem

//            highlightMoveDuration: 0
//            highlightRangeMode: ListView.ApplyRange
//            preferredHighlightBegin: 40
//            preferredHighlightEnd: width - 40
//        }

        background: Rectangle {
            implicitHeight: 40
            color: parent.backgroundColor
            Rectangle {
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
            }
        }


        Repeater {
            model: $wins.tabModels
            TabButton {
                id:tbb
                text: model.title
                property color textColor: (this.checked||this.hovered) ? "cyan" : "white"
                property color buttonColor: this.checked ? "black": $color.gray400
                width: this.checked?bar.width/3: 40
                implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                         implicitContentHeight + topPadding + bottomPadding)
                padding: 6
                spacing: 6
                font{
                    pixelSize: 14
                }

                contentItem: Rectangle{
                    color: parent.buttonColor
                    Row{
                        spacing: 6
                        Text {
                            text: model.title
                            font: tbb.font
                            color: tbb.textColor
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            renderType: Text.NativeRendering
                            // todo 外部套了后  失效了
                            elide: Text.ElideRight
                        }
                        Button {
                            visible: tbb.checked
                            width:20
                            height:20
                            text: ">"
                            onClicked: {
                                $wins.open(model.path,model.title)
                            }
                        }
                        Button {
                            visible: tbb.checked
                            width:20
                            height:20
                            text: "x"
                            onClicked: {
                                $wins.close(model.path)
                            }
                        }
                    }

                }

                background: Rectangle {
                    implicitHeight: bar.implicitBackgroundHeight
                    height: parent.height - 1
                    color: parent.buttonColor
                }

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
                    onLoaded: {
                        console.log("load:",model.title, model.path)
                    }
                }
            }
        }
    }

}
