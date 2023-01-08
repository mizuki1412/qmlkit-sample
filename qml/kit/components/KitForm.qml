import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    id: form
	color: "transparent"
	Layout.preferredHeight: 40
	property int labelWidth: 120
	property string label
	// right, left, center
	property string labelAlign: "right"
	property string unit
	// 普通文字:text
	property string contentType: "text"
	property Component content
	property alias contentObj: loader.item
	// 传入的值
	property var contentValue
	// 需要回传时，回传的对象和key
	property var formData: ({})
	property string dataKey
	property string tooltip

	RowLayout{
		anchors.fill: parent
		spacing: 12
		Rectangle{
			Layout.preferredWidth: labelWidth
			Layout.fillHeight:true
			color: 'transparent'
			Layout.alignment: Qt.AlignVCenter
            Text{
				width: parent.width
				horizontalAlignment: labelAlign==="right"?Text.AlignRight:(labelAlign==="left"?Text.AlignLeft:Text.AlignHCenter)
				anchors.verticalCenter: parent.verticalCenter
				color: $theme.color_text
				text: qsTr(label)
			}
			MouseArea{
                id: ma
                anchors.fill: parent
                hoverEnabled: true
                propagateComposedEvents: true
            }
            ToolTip{
                visible: ma.containsMouse && form.tooltip!==''
                text: qsTr(form.tooltip)
                delay: 50
            }
		}
//		Item{Layout.fillWidth: true}
		Loader{
			visible: content
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignVCenter
//			Layout.preferredHeight: height
			id:loader
			sourceComponent: content
		}
		// text 显示
		Rectangle{
			visible: contentType==="text" && !content
			Layout.fillWidth: true
			Layout.fillHeight:true
			color: "transparent"
			Layout.alignment: Qt.AlignVCenter
			Text{
			    id: txtVal
				width: parent.width
				horizontalAlignment: Text.AlignRight
				anchors.verticalCenter: parent.verticalCenter
				text: qsTr(contentValue?String(contentValue):"")
				color: $theme.color_text
				elide: Text.ElideMiddle
			}
			MouseArea{
                id: ma2
                anchors.fill: parent
                hoverEnabled: true
                propagateComposedEvents: true
            }
            // 显示被缩放的text的全文
            ToolTip{
                visible: ma2.containsMouse && txtVal.text !== "" && textMetrics.width > (txtVal.width)
                text: qsTr(String(txtVal.text))
                delay: 100
            }
            TextMetrics {
                id: textMetrics
                text: qsTr(String(txtVal.text))
            }
		}
		// input todo 考虑替换kitinput
		TextField{
			visible: contentType==="input" && !content
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignVCenter
			text: contentValue?contentValue:""
			onTextChanged:{
				if(!formData) formData = {}
				formData[dataKey] = this.text
			}
		}
		// textarea
		TextArea{
			visible: contentType==="area" && !content
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignVCenter
			text: contentValue?contentValue:""
			onTextChanged:{
				if(!formData) formData = {}
				formData[dataKey] = this.text
			}
		}
		// 单位
		Rectangle{
			visible: unit!==""
			Layout.preferredWidth: 16
			Layout.alignment: Qt.AlignVCenter
			Text{
				anchors.centerIn: parent
				text: qsTr(unit)
				font.pixelSize: 14
				color: $theme.color_text_inactive
			}
		}
	}
}
