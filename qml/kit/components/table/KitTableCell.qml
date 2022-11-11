import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Shapes

// 表格cell
KitTableCellWrapper{
	 id: rect
	 anchors.fill: parent
//	 border.width: 1
//     border.color: $theme.table_border_color
     // text-一般文本, checkbox, title-标题
	 property string type: "text"

     // 交替row换底色
//     color: model.row % 2 == 0 ? $theme.table_cell_bg1_color : $theme.table_cell_bg2_color

     Rectangle{
         anchors.fill: parent
         anchors.margins: 4
         color: "transparent"
//         CheckBox {
//             visible: type==="checkbox"
//             anchors.centerIn:   parent
//             checked: model.display
//             onToggled: model.display = checked
//         }
         Text {
            visible: type==="text"
            anchors.left: parent.left
			anchors.right: parent.right
            text: qsTr(value)
            color: $theme.table_font_data_color
            elide: Text.ElideMiddle
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: {
				switch(align){
				case "left": return Text.AlignLeft;break;
				case "center": return Text.AlignHCenter;break;
				case "right": return Text.AlignRight;break;
				}
			}
            MouseArea{
                id:ma
                hoverEnabled: true
                anchors.fill: parent
            }
            ToolTip{
                visible: ma.containsMouse && value !== "" && textMetrics.width > (rect.width-(2+8))
                text: qsTr(value)
                delay: 100
            }
            TextMetrics {
                id: textMetrics
                text: qsTr(value)
            }
         }
         Text {
			visible: type==="title"
         	anchors.left: parent.left
         	anchors.right: parent.right
			text: qsTr(value)
			font.bold: true
			color: $theme.table_font_header_color
			elide: Text.ElideMiddle
			verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: {
            	switch(align){
				case "left": return Text.AlignLeft;break;
				case "center": return Text.AlignHCenter;break;
				case "right": return Text.AlignRight;break;
            	}
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