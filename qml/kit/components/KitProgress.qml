import QtQuick
import QtQuick.Controls

ProgressBar {
	from:0
	to:100
	id: control
	padding: 2

	background: Rectangle {
		implicitWidth: control.implicitHeight
		implicitHeight: 18
		color: "#e6e6e6"
		radius: 3
	}
	contentItem: Item {
		implicitWidth: control.implicitHeight
		implicitHeight: 16
		Rectangle {
			width: control.visualPosition * parent.width
			height: parent.height
			radius: 2
			color: "#17a81a"
		}
	}
}