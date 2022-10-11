import QtQuick 2.14
import Qt.labs.qmlmodels 1.0
Rectangle{
    id:tableRec
    width:parent.width
    height:300
    property var tableHeader: ["name","color"]
    TableView {
        anchors.fill: parent
        clip: true

        model: TableModel {
                        TableModelColumn { display: "name" }
                        TableModelColumn { display: "color" }

//            Repeater{
//                model:tableHeader
//                TableModelColumn{display:modelData}
//            }
            rows: [
                {
                    "name":"动物名",
                    "color":"颜色"
                },
                {
                    "name": "cat",
                    "color": "black"
                },
                {
                    "name": "dog",
                    "color": "brown"
                },
                {
                    "name": "bird",
                    "color": "white"
                }
            ]
        }

        delegate: Rectangle {
            implicitWidth: 100
            implicitHeight: 50
            border.width: 1

            Text {
                text: display
                anchors.centerIn: parent
            }
        }
    }
}
