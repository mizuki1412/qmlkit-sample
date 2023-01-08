import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
	id: rect
	property string title
	property int titleSize: 16
	property int titleHeight: 40
    height: collapse?titleHeight:(titleHeight+bodyHeight)
	Layout.preferredHeight: height
    property int bodyHeight: 200
    property Component content
    property alias contentObj: loader.item
	color: "transparent"
//	clip: true
	property bool collapse: false

	Rectangle{
		id: t
		width: parent.width
		height: titleHeight
		radius: 4
		color: $theme.collapse_title_bg
		RowLayout{
			anchors.fill: parent
			spacing: 0
			Item{Layout.preferredWidth: 12}
			Text{
                text: qsTr(title)
				font.pixelSize: titleSize
				Layout.alignment: Qt.AlignVCenter
				color: $theme.color_text
			}
			Item{Layout.fillWidth: true}
			KitIcon{
				Layout.alignment: Qt.AlignVCenter
				source: collapse?"\ue626":"\ue625"
				color: $theme.color_text
			}
			Item{Layout.preferredWidth: 12}
		}
		MouseArea{
			anchors.fill:parent
			onClicked:{
				collapse = !collapse
			}
		}
	}
	Rectangle{
		id: body
		visible: !collapse
		anchors.top:t.bottom
		anchors.left: parent.left
		anchors.right: parent.right
		height: bodyHeight
		color: $theme.collapse_body_bg
		ScrollView{
			id: scrollview
			anchors.fill: parent
			anchors.margins: 8
			Loader{
				visible: content
				id: loader
				width: parent.width
				sourceComponent: content
			}
		}

	}
    transitions: [
        Transition {
            NumberAnimation { target: rect; property: "height"; duration: 300 }
//				NumberAnimation { target: body; property: "opacity"; duration: 300 }
//				NumberAnimation { target: titleArrow; property: "rotation"; duration: 200 }
        }
    ]

}
