import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
	id: button
	implicitWidth: $theme.btn_width
    implicitHeight: $theme.btn_height
    Layout.preferredWidth: $theme.btn_width
	Layout.preferredHeight: $theme.btn_height
	property string text
	property string icon
	property int size: 16
    property bool disabled: false
    property bool highlight: false
	radius: 4
	border.width: highlight?0:1
	border.color: $theme.color_btn_border
	state: "normal"
	property int contentWidth: ic.width+bt.width+16

	RowLayout{
		anchors.fill: parent
		spacing: 8
		Item{
			Layout.fillWidth: true
		}
		Text{
			id: ic
			font.family: $iconfont.family
			font.pixelSize: size
			color: $theme.color_text
			text: icon
			visible: icon&&icon!==""
		}
		Text{
			id: bt
			text: qsTr(button.text)
			font.pixelSize: size
			color: $theme.color_text
		}
		Item{
			Layout.fillWidth: true
		}
	}

	signal clicked
	signal released
    signal entered
	signal pressed
	signal exited

	MouseArea{
		anchors.fill: parent
//		focus: true
		hoverEnabled: true
//		propagateComposedEvents: true
        cursorShape: disabled?Qt.ForbiddenCursor:Qt.PointingHandCursor
		onClicked:{
            if(disabled) return
			button.clicked()
        }
        onEntered: {
            if(disabled) return
            parent.state = "hover"
            button.entered()
        }
        onExited:{
            if(disabled) return
			parent.state = "normal"
            button.exited()
		}
        onReleased: {
            parent.state = "normal"
        }
        onCanceled: {
			parent.state = "normal"
        }
        onPressed: {
            if(disabled) return
			parent.state = "hover"
        }
	}

	states: [
		State {
			name: "normal"
			PropertyChanges {
				target: button
				color: highlight?$theme.color_primary:$theme.color_btn_bg
			}
		},
		State {
			name: "hover"
			PropertyChanges {
				target: button
				color: Qt.darker((highlight?$theme.color_primary:$theme.color_btn_bg),1.3)
			}
		}
    ]
}
