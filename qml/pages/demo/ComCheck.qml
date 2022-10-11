import QtQuick
import QtQuick.Controls

Rectangle{
    id:checkRec
    width:parent.width
    height:300
    Column{
        Row{
            Label{
                anchors.verticalCenter: parent.verticalCenter
                text:"单选"
            }
            RadioButton{
                text:"A"
            }
            RadioButton{
                text:"B"
            }
            RadioButton{
                text:"C"
            }
            RadioButton{
                text:"D"
            }
        }
        Row{
            Label{
                anchors.verticalCenter: parent.verticalCenter
                text:"多选"
            }
            CheckBox{
                text:"A"
            }
            CheckBox{
                text:"B"
            }
            CheckBox{
                text:"C"
            }
            CheckBox{
                text:"D"
            }
        }
        Row{
            Label{
                anchors.verticalCenter: parent.verticalCenter
                text:"全选"
            }
            ButtonGroup {
                id: childGroup
                exclusive: false
                checkState: parentBox.checkState
            }

            CheckBox {
                id: parentBox
                text: qsTr("全选")
                checkState: childGroup.checkState
            }
            CheckBox {
                checked: true
                text: qsTr("slect 1")
                ButtonGroup.group: childGroup
            }

            CheckBox {
                text: qsTr("slect 2")
                ButtonGroup.group: childGroup
            }
        }
    }
}
