import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import Qt.labs.qmlmodels
import QtQuick.Shapes

// 表格
Rectangle{
    // headers是字符串数组，可带列宽，eg: ["header1:name:30", "header2:name"]
    // 注意head中_开头的将作为无display值的存在，会自动补值，不用在addData时设置
    property var headers: []
    // 计算headers中的列宽（0为自适应），tablebody的列宽根据header实际宽
    property var columnWidths: {
        let arr = []
        for(let e of headers){
            let es = e.split(":")
            if(es.length>=3){
                let v = parseFloat(es[2])
                if(v>0){
                    arr.push(v)
                    continue
                }
            }
            arr.push(0)
        }
        return arr
    }
    property var headerNames:{
        let arr = []
        for(let e of headers){
            let es = e.split(":")
            if(es.length>=2){
                arr.push(es[1])
                continue
            }
            arr.push("")
        }
        return arr
    }
    onWidthChanged: {
        // 界面变化自适应
        tableBody.forceLayout()
    }
//    color: $color.rose400
    height: tableHeader.height+tableBody.height
    property TableModel tableModel: TableModel{TableModelColumn{display:"_handle"}}
    property DelegateChooser tableDelegate

    function addData(data){
        // 补全_开头的值
        for(let e of headers){
            if(e.split(":")[0].indexOf("_")===0){
                data[e.split(":")[0]] = ""
            }
        }
        tableModel.appendRow(data)
    }

    function setData(list){
        tableModel.clear()
        for(let e of list){
            addData(e)
        }
    }

    Component.onCompleted:{
    }

    Rectangle{
        id:tableHeader
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 42
        border.width: 1
        border.color: $theme.table_border_color
        RowLayout{
            anchors.fill: parent
            anchors.topMargin: 1
            anchors.leftMargin: 1
            anchors.rightMargin: 1
            spacing: 0
            Repeater{
                id: headerCells
                model: columnWidths.length
                Rectangle{
                    Layout.preferredWidth: columnWidths[index]>0?columnWidths[index]:0
                    Layout.fillWidth: columnWidths[index]>0?false:true
                    Layout.fillHeight: true
                    border.width: 1
                    border.color: $theme.table_border_color
                    Text {
                        anchors.fill: parent
                        text: qsTr(headerNames[index])
                        elide: Text.ElideMiddle
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

            }
        }
    }

    TableView{
        id: tableBody
        anchors.top: tableHeader.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 1
        anchors.rightMargin: 1
        height: 300
        focus: true
//        columnSpacing: 1
//        rowSpacing: 1
        clip: true
        alternatingRows:true

        columnWidthProvider: function (column) {
            return headerCells.itemAt(column).width
        }

//        ScrollBar.vertical: ScrollBar {
//            anchors.right:parent.right
//            anchors.rightMargin: 0
//            visible: tableModel.rowCount > 5
//            background: Rectangle{
//                color:"#666666"
//            }
//            onActiveChanged: {
//                active = true;
//            }
//            contentItem: Rectangle
//            {
//                implicitWidth  : 6
//                implicitHeight : 30
//                radius : 3
//                color  : "#848484"
//            }
//        }
        model: tableModel
        delegate: tableDelegate
    }

}
