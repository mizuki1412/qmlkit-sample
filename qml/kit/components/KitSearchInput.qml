import QtQuick
import QtQuick.Controls

KitInput{
	id: rect

	placeholder: "输入关键字搜索"
	icon: "\ueafe"
	iconPlace: "right"

	signal searched(string searchText)
	onInput:(text)=>{
		searched(text)
	}
}
