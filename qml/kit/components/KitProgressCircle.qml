import QtQuick
import QtQuick.Controls

Item {
	property real value: 50		// 0-100
	property int size: 200               // The size of the circle in pixel
	property real rotation: 0           // rotation
	property bool isPie: false           // paint a pie instead of an arc
	property bool showBackground: true  // a full circle as a background of the arc
	property real lineWidth: 5          // width of the line
	property string colorCircle: "#CC3333"
	property string colorBackground: "#E6E6E6"
	id: circleRoot

	width: size
	height: size
	property real arcBegin: 0            // start arc angle in degree
	property real arcEnd: value/100*360  // end arc angle in degree
	property real arcOffset: rotation

	property alias beginAnimation: animationArcBegin.enabled
	property alias endAnimation: animationArcEnd.enabled
	property int animationDuration: 200

	onValueChanged:{
		if(value<0) value=0
		if(value>100) value=100
	}

	onArcBeginChanged: canvas.requestPaint()
	onArcEndChanged: canvas.requestPaint()

	Behavior on arcBegin {
	   id: animationArcBegin
	   enabled: true
	   NumberAnimation {
		   duration: circleRoot.animationDuration
		   easing.type: Easing.InOutCubic
	   }
	}

	Behavior on arcEnd {
	   id: animationArcEnd
	   enabled: true
	   NumberAnimation {
		   duration: circleRoot.animationDuration
		   easing.type: Easing.InOutCubic
	   }
	}

	Canvas {
		id: canvas
		anchors.fill: parent
		rotation: -90 + parent.arcOffset

		onPaint: {
			var ctx = getContext("2d")
			var x = width / 2
			var y = height / 2
			var start = Math.PI * (parent.arcBegin / 180)
			var end = Math.PI * (parent.arcEnd / 180)
			ctx.reset()

			if (circleRoot.isPie) {
				if (circleRoot.showBackground) {
					ctx.beginPath()
					ctx.fillStyle = circleRoot.colorBackground
					ctx.moveTo(x, y)
					ctx.arc(x, y, width / 2, 0, Math.PI * 2, false)
					ctx.lineTo(x, y)
					ctx.fill()
				}
				ctx.beginPath()
				ctx.fillStyle = circleRoot.colorCircle
				ctx.moveTo(x, y)
				ctx.arc(x, y, width / 2, start, end, false)
				ctx.lineTo(x, y)
				ctx.fill()
			} else {
				if (circleRoot.showBackground) {
					ctx.beginPath();
					ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, 0, Math.PI * 2, false)
					ctx.lineWidth = circleRoot.lineWidth
					ctx.strokeStyle = circleRoot.colorBackground
					ctx.stroke()
				}
				ctx.beginPath();
				ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, start, end, false)
				ctx.lineWidth = circleRoot.lineWidth
				ctx.strokeStyle = circleRoot.colorCircle
				ctx.stroke()
			}
		}
	}
}
