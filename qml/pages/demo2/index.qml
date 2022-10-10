import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls.Material
import Qt.labs.qmlmodels
 import QtQuick.Shapes
import "../../kit/components"

Rectangle {
    width: parent.width
    height: 2000
    id: demo2
    property int count:0

    Component.onCompleted:{
        picker.init(new Date())
        console.log(picker.value)
    }

    Row{
        id: r1
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
            text: "自定义footer"
            onClicked: {
                modal.open()
            }
        }
        KitModal{
            id:modal
            width: 400
            height: 240
            yesButtonText: "是"
            noButtonText: "否"


            property string message: "确认删除?"
            function setMessage(msg){
                if(msg){
                    message = msg
                }
            }


            scrollContent: ColumnLayout{
                Rectangle {
                    Layout.fillWidth: true
                    height: 400
                    color: "red"
                }
                Rectangle {
                    Layout.fillWidth: true
                    height: 400
                    color: "blue"
                }
                Rectangle {
                    Layout.fillWidth: true
                    height: 400
                    color: "green"
                }
            }
            footer: RowLayout{
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                Text {
                    id: name
                    text: qsTr("text")
                    Layout.alignment: Qt.AlignVCenter
                }
            }

        }

        KitDateTimePicker{
            id: picker
        }

        Button{
            text: "webview"
            onClicked: {
                webpp.open()
            }
        }
        Popup{
            id: webpp
            width: 800
            height: 600
            anchors.centerIn: Overlay.overlay
            closePolicy: Popup.CloseOnEscape
            modal: true
            focus:true
//                KitWebView{
//                    id: webview
//                    anchors.fill: parent
//                    url: "https://www.baidu.com"
//                }
        }
        Button{
            text: "table update"
            onClicked: {
                table.addData({
                     // Each property is one cell/column.
                     checked: count%2===0,
                     amount: count,
                     fruitType: "Apple "+count,
                     fruitName: "Granny Smith "+count,
                     fruitPrice: count,
                     id:new Date()
                 })
                count++
            }
        }

    }

    ScrollView{
        id: scroll1
        anchors.top: r1.bottom
        width:300
        height:100
        ColumnLayout{
            anchors.fill:parent
            Rectangle{
                Layout.fillWidth: true
                height: 2000
                color: "green"
                Component.onCompleted:{
                    console.log(3,parent.height,this.height)
                }
            }
        }

    }

    KitTable{
        id:table
        anchors.top: scroll1.bottom
        width: parent.width
        anchors.topMargin: 8
        headers: ["checked:序号:60","amount:数量","fruitType:类型","fruitName:名称","fruitPrice:价格","_handle:操作:150"]
        tableModel: TableModel {
           TableModelColumn { display: "checked" }
           TableModelColumn { display: "amount" }
           TableModelColumn { display: "fruitType" }
           TableModelColumn { display: "fruitName" }
           TableModelColumn { display: "fruitPrice" }
           TableModelColumn { display: "_handle" }
        }
        tableDelegate: DelegateChooser {
            DelegateChoice {
                column: 0
                delegate: KitTableCell{
                    type: "checkbox"
                }
            }
            DelegateChoice {
                column: 5
                delegate: KitTableCell{
                    type: ""
                    RowLayout{
                        anchors.fill: parent
                        Button{
                            Layout.preferredWidth: 50
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignCenter
                            text: "修改"
                            onClicked: {
                                console.log(table.tableModel.rows[model.row].id)
                            }
                        }
                    }
                }
            }
            DelegateChoice {
                delegate: KitTableCell{}
            }
        }
    }

}
