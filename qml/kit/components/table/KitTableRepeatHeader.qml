import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

// 标题单元 横向
Rectangle{
	property int _index
	Layout.preferredWidth: properties[_index]._width
	Layout.preferredHeight: cellHeight
	color: $theme.table_header_bg
	KitTableCell{
		id: table_tv
		type: "title"
	}
	Component.onCompleted:{
		table_tv.value = properties[_index].name
		table_tv.align = properties[_index].align
	}
}
