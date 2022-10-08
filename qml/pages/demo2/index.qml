import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls.Material
import "../../kit/components"

Rectangle {
    id: demo2
    width:1000
    height:1000
    Flickable{
        id:flick
        anchors.fill: parent
        clip: true
        contentHeight: 2000
        contentWidth: parent.width

        Row{
            spacing: 12
            Button{
                text: "确认框"
                onClicked: {
                    $dao.showConfirm({parentPage: demo2})
                }
            }
            Button{
                text: "信息框"
                onClicked: {
                    $dao.showMessage({parentPage: demo2,message:"hello"})
                }
            }
            Button{
                text: "loading框"
                onClicked: {
                    $dao.showLoading({parentPage: demo2})
                }
            }
            Button{
                text: "时间框"
                onClicked: {

                }
            }
            Button{
                text: "webview"
                onClicked: {

                }
            }
        }
    }
}
