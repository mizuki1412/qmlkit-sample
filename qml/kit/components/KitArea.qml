import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
	id: rect
    implicitWidth: 200
    implicitHeight: textArea.contentHeight+24
    Layout.preferredHeight: textArea.contentHeight+24
    radius: 4
	border.width:1
    border.color: $theme.color_btn_border
	color: $theme.color_btn_bg

	property alias text: textArea.text
	property bool readonly

	signal input(string text)
	TextArea {
		anchors.fill: parent
		anchors.leftMargin: 8
		anchors.rightMargin: 8
		id: textArea
		focus: true
		wrapMode: TextArea.Wrap	// 换行
		selectByMouse: true
		selectByKeyboard: true
		readOnly: readonly
		onTextChanged: {
			input(this.text)
		}
		background: Rectangle{
			color: "transparent"
		}
	}

}
