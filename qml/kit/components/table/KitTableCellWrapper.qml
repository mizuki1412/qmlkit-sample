import QtQuick
import QtQuick.Controls

// 表格cell wrapper, 用于自定义cell组件的外部
Rectangle{
	// 当前cell具体的值
    property var value
	// 数据的下标
	property var index
	// 数据的key值
	property var key
	property var rowData
	// ui - align
	property string align
	property string alignTitle
	color: "transparent"
}
