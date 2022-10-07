import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls.Material
import "../../kit/components"

Rectangle {
    width:1000
    height:1000
    Flickable{
        id:flick
        anchors.fill: parent
        clip: true
        contentHeight: 2000
        contentWidth: parent.width
        // -------- tabbar demo

        TabBar {
            id: bar
            width: parent.width

                TabButton {
                    text: "First"
                    width: Math.max(100, bar.width / 5)
                }
                TabButton {
                    text: "Second"
                    width: Math.max(100, bar.width / 5)
                }
                TabButton {
                    text: "Third"
                    width: Math.max(100, bar.width / 5)
                }
                TabButton {
                    text: "Fourth"
                    width: Math.max(100, bar.width / 5)
                }
                TabButton {
                    text: "Fifth"
                    width: Math.max(100, bar.width / 5)
                }

        }

        StackLayout {
            id:barPage
            width: parent.width
            anchors.top: bar.bottom
            currentIndex: bar.currentIndex
            Text {
                id: homeTab
                text: "1"
            }
            Text {
                id: discoverTab
                text: "2"
            }
            Text {
                id: activityTab
                text: "3"
            }
            Text {
                text: "4"
            }
            Text {
                text: "5"
            }
        }

        //-----button demo
        Label{
            id:labButton
            text:"按钮"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: barPage.bottom
            anchors.topMargin: 30
            font.pixelSize: $theme.font_xl
        }
        Rectangle{
            id:div_1
            width:Screen.width
            height:1
            color:"black"
            anchors.top: labButton.bottom
            anchors.topMargin: $theme.margin
        }

        ComButton{
            id:showButton
            anchors.top: div_1.bottom
            anchors.topMargin: $theme.margin_xl
        }
        //------switch demo
        Label{
            id:labSwitch
            text:"开关"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: showButton.bottom
            anchors.topMargin: $theme.margin_xl
            font.pixelSize: $theme.font_xl
        }
        Rectangle{
            id:div_2
            width:Screen.width
            height:1
            color:"black"
            anchors.top: labSwitch.bottom
            anchors.topMargin: $theme.margin
        }

        ComSwitch{
            id:showSwitch
            anchors.top: div_2.bottom
            anchors.topMargin: $theme.margin_xl
        }

        //----slider demo
        Label{
            id:labSlider
            text:"滑动条"
            anchors.top: showSwitch.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: $theme.margin_xl
            font.pixelSize: $theme.font_xl
        }
        Rectangle{
            id:div_3
            anchors.top: labSlider.bottom
            anchors.topMargin: $theme.margin
            width:Screen.width
            height:1
            color: "black"
        }
        ComSlider{
            id:showSlider
            anchors.top: div_3.bottom
            anchors.topMargin: $theme.margin
        }
        //-----progressbar demo
        Label{
            id:labProgressBar
            text:"进度条"
            anchors.top: showSlider.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: $theme.margin_xl
            font.pixelSize: $theme.font_xl
        }
        Rectangle{
            id:div_4
            anchors.top: labProgressBar.bottom
            anchors.topMargin: $theme.margin
            width:Screen.width
            height:1
            color: "black"
        }
        ComProgressBar{
            id:showProgressBar
            anchors.top: div_4.bottom
            anchors.topMargin: $theme.margin
        }
        // ------combobox demo
        Label{
            id:labCombobox
            text:"下拉列表"
            anchors.top: showProgressBar.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: $theme.margin_xl
            font.pixelSize: $theme.font_xl
        }
        Rectangle{
            id:div_5
            anchors.top: labCombobox.bottom
            anchors.topMargin: $theme.margin
            width:Screen.width
            height:1
            color: "black"
        }
        ComComboBox{
            id:showComboBox
            anchors.top: div_5.bottom
            anchors.topMargin: $theme.margin
        }
        //textinput TextField
        Label{
            id:labText
            text:"输入框"
            anchors.top: showComboBox.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: $theme.margin_xl
            font.pixelSize: $theme.font_xl
        }
        Rectangle{
            id:div_6
            anchors.top: labText.bottom
            anchors.topMargin: $theme.margin
            width:Screen.width
            height:1
            color: "black"
        }
        ComText{
            id:showText
            anchors.top: div_6.bottom
            anchors.topMargin: $theme.margin
        }

    }
}
