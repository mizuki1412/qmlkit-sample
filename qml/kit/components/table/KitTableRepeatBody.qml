import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

// 内容单元 横向
Rectangle{
	property int _index
	Layout.preferredWidth: properties[_index]._width
	Layout.preferredHeight: cellHeight
	color: {
		if(rowSelectBgChange && rIndex===rowSelectIndex){
			return $theme.table_select_bg
		}else{
			return rIndex%2===0?$theme.table_data_bg1:$theme.table_data_bg2
		}
	}
	// 默认cell效果
	KitTableCell{
		id: table_bv
		visible: !(properties[_index]&&properties[_index].cell)
		type: "text"
	}
	// 自定义component
	Loader {
		anchors.fill: parent
		visible: properties[_index]&&properties[_index].cell
		id: table_loader
		sourceComponent: properties[_index].cell
	}
	MouseArea{
		id: ma
		anchors.fill: parent
		hoverEnabled: true
		acceptedButtons: Qt.LeftButton | Qt.RightButton
		propagateComposedEvents: true
        onClicked:(mouse)=>{
            if (mouse.button === Qt.RightButton){
				rowSelectIndex = rIndex
				if(rightMenuActions.length===0) return
				rightMenu.rowData = rModel
				rightMenu.rowIndex = rIndex
				rightMenu.popup();
			}else{
				rowSelectIndex = rIndex
				table_rect.rowSelect()
			}
		}
	}
	// 显示被缩放的text的全文
	ToolTip{
		visible: table_bv.visible && ma.containsMouse && table_bv.value !== "" && textMetrics.width > (table_bv.width-(2+8))
		text: qsTr(String(table_bv.value))
		delay: 100
	}
	TextMetrics {
		id: textMetrics
		text: qsTr(String(table_bv.value))
	}
	Component.onCompleted:{
		let item0
		if(properties[_index]&&properties[_index].cell){
			item0 = table_loader.item
		}else{
			item0 = table_bv
		}
        item0.value = rModel[properties[_index].key]!==undefined?rModel[properties[_index].key]:""
		item0.index = rIndex
		item0.key = properties[_index].key
		item0.rowData = rModel
		item0.align = properties[_index].align
    }

    // 右键菜单
	Menu {
		id: rightMenu
		property var rowData
		property int rowIndex
		Repeater{
			model: rightMenuActions.length
			MenuItem {
				id: item
				text: qsTr(rightMenuActions[index].name)
				background: Rectangle{
					implicitWidth: rightMenuWidth
					gradient: Gradient{
						orientation: Gradient.Horizontal
						GradientStop{position: 1; color:$color.rgba("#5293FF", item.highlighted?1:0)}
						GradientStop{position: 0; color:$color.rgba("#62BDFF", item.highlighted?1:0)}
					}
				}
				onTriggered: {
					rightMenuActions[index].action(rightMenu.rowData,rightMenu.rowIndex)
				}
			}
		}
		background: Rectangle{
			implicitWidth: rightMenuWidth
			color: $color.rgba("#0E1021", 0.89)
			radius: 4
		}
	}
}
