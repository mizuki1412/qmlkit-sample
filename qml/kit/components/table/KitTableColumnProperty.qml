import QtQuick

// 定义table列配置参数
Item{
	// table data key
	property string key
	// column header name
	property string name
	// column 最小宽
	property int minWidth: 40
	// column 固定宽。优先于minWidth
	property int fixWidth: 0
	// 文本对齐: left, center, right
	property string align: "left"
	// cell custom component ：必须是KitTableCellWrapper
	property Component cell

	// column 实际宽。自动计算
	property int _width: 0
}