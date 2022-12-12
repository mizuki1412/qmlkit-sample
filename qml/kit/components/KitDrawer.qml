import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Templates as T

Drawer{
    id: drawer
    closePolicy: Popup.CloseOnEscape
    modal: true
    margins: 0
    padding: 8
    focus: true

    // 幕布颜色
	T.Overlay.modal: Rectangle {
        color: $color.rgba($theme.color_bg, 0.8)
	}
}
