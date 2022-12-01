import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
	id: rect
	implicitWidth: 200
	implicitHeight: $theme.btn_height
	radius: 4
	border.width:1
	border.color: $theme.color_btn_border
	color: $theme.color_btn_bg

	property string placeholder: ""
	property alias text: textValue.text
	property bool readonly
	property string icon
	// 图标位置：left,right
	property string iconPlace: "right"
	// 校验 int,double
	property string validator
	// 单位
	property string unit
	property bool password: false

	signal input(string text)

//	onTextChanged:{
//		textValue.text = qsTr(String(text))
//	}
	function clear(){
		textValue.text = ""
	}
    TextInput{
		id: v_int
		visible: false
        validator: IntValidator{}
	}
    TextInput{
		id: v_double
		visible: false
        validator: DoubleValidator{}
	}
	RowLayout{
        anchors.fill: parent
		spacing: 0
		Item{Layout.preferredWidth: 8}
		Text{
            Layout.fillHeight: true
			visible: icon!="" && iconPlace==="left"
			font.pixelSize: 18
			font.family: $iconfont.family
			color: $theme.color_text_inactive
			text: icon
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
		}
		Item{
			visible: icon!="" && iconPlace==="left"
			Layout.preferredWidth: 8
		}
		Item{
			Layout.fillWidth: true
			Layout.fillHeight: true
			Text{
				id: placeholderText
				visible: textValue.text===""
				anchors.fill: parent
				text: qsTr(placeholder)
				color: $theme.color_text_inactive
				verticalAlignment: Text.AlignVCenter
			}
			TextInput{
				id: textValue
				height: parent.height
				anchors.fill: parent
				verticalAlignment: TextInput.AlignVCenter
				color: $theme.color_text
				clip:true
				focus: true
				readOnly: readonly
				echoMode: rect.password?TextInput.Password:TextInput.Normal
				validator: rect.validator==="int"?v_int.validator:(rect.validator==="double"?v_double.validator:null)
//				text: qsTr(String(rect.text))
				onTextChanged: {
//					rect.text = this.text
					input(textValue.text)
				}
			}
		}
		Item{
			visible: (icon!="" && iconPlace==="right") || unit!==""
			Layout.preferredWidth: 8
		}
		Text{
            Layout.fillHeight: true
			visible: icon!="" && iconPlace==="right"
			font.pixelSize: 18
			font.family: $iconfont.family
			color: $theme.color_text_inactive
			text: icon
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
		}
		Item{
			visible: unit===""
			Layout.preferredWidth: 8
		}
		Rectangle{
			visible: unit!==""
//			color: $color.rgba(rect.color,1.5)
			color: "transparent"
			border.width:1
			border.color: $theme.color_btn_border
			radius: 4
			Layout.fillHeight: true
			Layout.preferredWidth: unitText.width+20
			Text{
				id: unitText
				anchors.centerIn: parent
				text: qsTr(unit)
				font.pixelSize: 14
				color: $theme.color_text_inactive
			}
		}
	}
}
