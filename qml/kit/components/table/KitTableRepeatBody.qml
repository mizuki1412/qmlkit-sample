import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

// 内容单元 横向
Rectangle{
	property int _index
	Layout.preferredWidth: properties[_index]._width
	Layout.preferredHeight: cellHeight
	color: rIndex%2===0?$theme.table_data_bg1:$theme.table_data_bg2
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
	Component.onCompleted:{
		let item0
		if(properties[_index]&&properties[_index].cell){
			item0 = table_loader.item
		}else{
			item0 = table_bv
		}
		item0.value = rModel[properties[_index].key]
		item0.index = rIndex
		item0.key = properties[_index].key
		item0.rowData = rModel
		item0.align = properties[_index].align
    }
}
