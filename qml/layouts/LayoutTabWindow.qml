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

    TabBar {
        id: bar
        anchors.topMargin: $theme.margin
        width: parent.width
        onCurrentIndexChanged: {}
        property color backgroundColor: "red"
        property color borderColor: "black"

        implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                contentWidth + leftPadding + rightPadding)
        implicitHeight: Math.max(36, contentHeight + topPadding + bottomPadding)
        spacing: 1
        padding: 0
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

//        background: Rectangle {
//            implicitHeight: 40
//            color: parent.backgroundColor
//            Rectangle {
//                width: parent.width
//                height: 1
//                anchors.bottom: parent.bottom
//            }
//        }


        Repeater {
            model: $wins.tabModels
            TabButton {
                id:tbb
                text: model.title
                property color textColor: (this.checked||this.hovered) ? "cyan" : "white"
                property color buttonColor: this.checked ? "black": $color.gray400
                width: this.checked?bar.width/3: 60
                implicitHeight: Math.max(36, implicitContentHeight + topPadding + bottomPadding)
                padding: 1
                spacing: 1
                contentItem: Rectangle{
                    color: tbb.checked?Material.primary:$color.gray300
                    RowLayout{
                        spacing: 8
                        width: parent.width
                        Text {
                            Layout.alignment: Qt.AlignVCenter
                            Layout.fillWidth: true
                            Layout.preferredHeight: 36
                            Layout.leftMargin: 4
                            text: qsTr(model.title)
                            font.pixelSize: $theme.font_sm
                            width: tbb.checked?bar.width/6: 50
                            color: tbb.checked?"white":$color.gray600
                            verticalAlignment: Text.AlignVCenter
                            renderType: Text.NativeRendering
                            elide: Text.ElideRight
                        }
                        Button {
                            Layout.alignment: Qt.AlignVCenter
                            Layout.preferredHeight: 36
                            Layout.preferredWidth: 30
                            visible: tbb.checked
                            font.family: $iconfont.family
                            font.pixelSize: 12
                            text: "\ue622"
                            onClicked: {
                                $wins.open(model.path,model.title)
                            }
                        }
                        Button {
                            Layout.alignment: Qt.AlignVCenter
                            Layout.preferredHeight: 36
                            Layout.preferredWidth: 30
                            Layout.rightMargin: 8
                            visible: tbb.checked
                            font.family: $iconfont.family
                            font.pixelSize: 10
                            text: "\ue634"
                            onClicked: {
                                $wins.close(model.path)
                            }
                        }
                    }
                }

//                background: Rectangle {
//                    implicitHeight: bar.implicitBackgroundHeight
//                    height: parent.height - 1
//                    color: parent.buttonColor
//                }

            }
        }
    }

    StackLayout {
        anchors.top: bar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: $theme.margin_sm
        currentIndex: bar.currentIndex
        Repeater {
            model: $wins.tabModels
            ScrollView{
                id: scroll0
                Layout.fillWidth: true
                Layout.fillHeight: true
                Loader{
                    id: loader0
                    anchors.top:parent.top
                    anchors.left:parent.left
                    anchors.right:parent.right
                    source: model.path
                    onLoaded: {
                        console.log("tab load:",model.title, model.path)
                    }
                }
            }
        }
    }

}
