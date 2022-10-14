import QtQuick
import QtQuick.Shapes

Shape{
//    property alias from:from.sourceComponent
//    property alias to:to.sourceComponent
    property alias color:from_to.strokeColor
    property KitSvg from
    property KitSvg to
    z:to.z-1
    ShapePath {
        id:from_to
        capStyle: ShapePath.RoundCap
        strokeColor: "black"
        strokeWidth: 5
        fillColor: "transparent"
        PathPolyline{
            path:[
                Qt.point(from.x+from.width/2,from.y+from.height/2),
                Qt.point(to.x+to.width/2,from.y +from.height/2),
                Qt.point(to.x+to.width/2,to.y+to.height/2)
            ]
        }
    }
}
