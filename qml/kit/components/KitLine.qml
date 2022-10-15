import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

Shape{
//    property alias from:from.sourceComponent
//    property alias to:to.sourceComponent
    property var middlePoint:[]
    property var pathPoint:[]
    property alias color:from_to.strokeColor
    property KitSvg from
    property KitSvg to
    property Item drawer
//    z:to.z-1
    Component.onCompleted:{
    }
    ShapePath {
        id:from_to
        capStyle: ShapePath.RoundCap
        strokeColor: "black"
        strokeWidth: 5
        fillColor: "transparent"
        PathPolyline{
            id:path2
//            path:[
//                Qt.point(from.x+from.width/2,from.y+from.height/2),
//                Qt.point(to.x+to.width/2,from.y +from.height/2),
//                Qt.point(to.x+to.width/2,to.y+to.height/2)
//            ]
            path:[
                Qt.point(drawer.width*0.4+25,drawer.width*0.4+25),
                Qt.point(drawer.width*0.5+25,drawer.width*0.5+25),
                Qt.point(drawer.width*0.6+25,drawer.width*0.6+25)
            ]
        }
    }
}
