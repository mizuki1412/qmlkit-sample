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

     Rectangle{
         anchors.fill: parent
         anchors.margins: 4
         color: "transparent"
         CheckBox {
             visible: type==="checkbox"
             Material.theme: Material.Light
             anchors.centerIn: parent
             checked: value?true:false
             // todo
//             onToggled: model.display = checked
         }
         Text {
            visible: type==="text" || type==="title"
            anchors.left: parent.left
			anchors.right: parent.right
            text: qsTr(String(value))
            font.bold: type==="title"
			color: type==="title"?$theme.table_font_header_color: $theme.table_font_data_color
            elide: Text.ElideMiddle
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: {
				switch(align){
                case "left": return Text.AlignLeft;
                case "center": return Text.AlignHCenter;
                case "right": return Text.AlignRight;
				}
			}
         }
     }

}
