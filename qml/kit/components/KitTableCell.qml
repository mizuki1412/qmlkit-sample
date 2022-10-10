import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import Qt.labs.qmlmodels
import QtQuick.Shapes

// 表格cell
Rectangle{
	 id: rect
	 border.width: 1
     border.color: $theme.table_border_color
     implicitHeight: $theme.table_cell_height
     // text-一般文本, checkbox
	 property string type: "text"

     // 交替row换底色
     color: model.row % 2 == 0 ? $theme.table_cell_bg1_color : $theme.table_cell_bg2_color

     Rectangle{
         anchors.fill: parent
         anchors.margins: 4
         color: "transparent"
         CheckBox {
             visible: type==="checkbox"
             anchors.centerIn:   parent
             checked: model.display
             onToggled: model.display = checked
         }
         Text {
            visible: type==="text"
            anchors.fill: parent
            text: model.display
            elide: Text.ElideMiddle
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            MouseArea{
                id:ma
                hoverEnabled: true
                anchors.fill: parent
            }
            ToolTip{
                visible: ma.containsMouse && display !== "" && textMetrics.width > (rect.width-(2+8))
                text: display
                delay: 100
            }
            TextMetrics {
                id: textMetrics
                text: display
            }
         }
     }

     // todo 滚动后失效？如何影响同row的？
//	 HoverHandler{
//		 acceptedDevices: PointerDevice.Mouse
//         onHoveredChanged: {
//             if(this.hovered) rect.color = "gray"
//             else rect.color = "white"
//		 }
//	 }
}
