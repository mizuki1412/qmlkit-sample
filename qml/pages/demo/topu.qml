import QtQuick
import QtQuick.Shapes
import QtQuick.Controls

Rectangle {
    anchors.fill: parent
    z:1
    Component.onCompleted: {
    }
	Rectangle{
        id:rec1
        width:100
        height:100
        x:parent.width*0.4
        y:parent.height*0.4
        Image{
            id:com_1
            source:"qrc:/main/qml/kit/assets/svg/index.svg"
            anchors.centerIn:parent
            width:100
            height:100
        }
        MouseArea {
            anchors.fill: rec1
            drag.target: rec1
            drag.axis: Drag.XAndYAxis//设置拖拽的方式
            drag.minimumX: 0
            drag.maximumX: root.width
            drag.minimumY: 0
            drag.maximumY: root.height
            onClicked:{
                com_1to2.strokeColor = "red"
            }
        }
        Label{
            text:"com_1"
            font.pixelSize:40
            anchors.top:com_1.bottom
            anchors.left:com_1.left
        }
    }

    Rectangle{
        id:rec2
        width:100
        height:100
        // color:"red"
        x:parent.width*0.5
        y:parent.height*0.5
        Image{
            id:com_2
            source:"qrc:/main/qml/kit/assets/svg/index.svg"
            anchors.centerIn:parent
            width:100
            height:100
        }
        MouseArea {
            anchors.fill: rec2
            drag.target: rec2
            drag.axis: Drag.XAndYAxis//设置拖拽的方式
            drag.minimumX: 0
            drag.maximumX: root.width
            drag.minimumY: 0
            drag.maximumY: root.height
        }
        Label{
            text:"com_2"
            font.pixelSize:40
            anchors.top:com_2.bottom
            anchors.left:com_2.left
        }
    }
    Shape{
        z:1
        ShapePath {
            id:com_1to2
            strokeColor: "black"
            strokeWidth: 5
            fillColor: "transparent"
            joinStyle:ShapePath.MiterJoin
            PathPolyline{
                path:[
                    Qt.point(rec1.x+rec1.width/2,rec1.y+rec1.height/2),
                    Qt.point(rec2.x+rec2.width/2,rec1.y +rec1.height/2),
                    Qt.point(rec2.x+rec2.width/2,rec2.y+rec2.height/2)
                ]
            }
        }
    }
}

