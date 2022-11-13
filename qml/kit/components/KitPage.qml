import QtQuick
import QtQuick.Controls

Rectangle {
	// 自适应内部元素高度，内部组件不可设置 anchors.bottom 或anchors.fill
    implicitHeight: childrenRect.height+8
    color: "transparent"
//    anchors.right: parent.right
//    anchors.rightMargin: 8

}
