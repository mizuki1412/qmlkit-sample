import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

Rectangle{
    id: datepicker_show
    property string emptyValue: "--:--:--"
    implicitWidth: 180
	implicitHeight: $theme.btn_height
	Layout.preferredWidth: 180
	Layout.preferredHeight: $theme.btn_height
	radius: $theme.color_btn_radius
	color: $theme.color_btn_bg
	border.color: $theme.color_btn_border
	border.width: 1
	// 初始color
	property color _color: $theme.color_btn_bg
	property int size: 14
	property string text: emptyValue
	property bool disabled: false

	// 作为最终的确定时间
	property var value
	// 初始
	function init(dt){
		currentDate = dt
		value = new Date(dt.getTime())
		datepicker_show.text = Qt.formatDateTime(value, "yyyy-MM-dd HH:mm:ss")
		text_hour.text = currentDate.getHours()
		text_minute.text = currentDate.getMinutes()
		text_second.text = currentDate.getSeconds()
	}
	// 重置 清空
	function clear(){
		value = null
		datepicker_show.text=emptyValue
	}

	MouseArea{
		anchors.fill: parent
		hoverEnabled: true
		cursorShape: Qt.PointingHandCursor
		onClicked:{
		    if(disabled) return
			componet_datepicker.open()
		}
		onEntered: {
		    if(disabled) return
			datepicker_show.color = Qt.darker(_color,1.3)
		}
		onExited:{
		    if(disabled) return
			datepicker_show.color = _color
		}
		onReleased: {
		    if(disabled) return
			datepicker_show.color = _color
		}
		onCanceled: {
		    if(disabled) return
			datepicker_show.color = _color
		}
		onPressed: {
		    if(disabled) return
			datepicker_show.color = Qt.darker(_color,1.3)
		}
	}
    RowLayout{
		anchors.fill: parent
		spacing: 0
		Item{
			Layout.preferredWidth: 12
		}
		Text{
			id: bt
			Layout.fillWidth: true
            text: qsTr(datepicker_show.text)
			font.pixelSize: size
			color: disabled?$theme.color_text_inactive:$theme.color_text
			horizontalAlignment: Text.AlignHCenter
		}
		Text{
			id: ic
			Layout.preferredWidth: size
			font.family: $iconfont.family
			font.pixelSize: size
			color: $theme.color_text_inactive
			text: "\ue691"
		}
		Item{
			Layout.preferredWidth: 12
		}
	}

//    signal datePicked(date d)
	// --- 内置成员变量区域
    // 也是作为起始时间
    property date currentDate: new Date()
    property color selectColor: Material.primary
    property int yearStart: new Date().getFullYear() - 150
    property int yearRange: 300
    property int monthStartWeekDay: (new Date(currentDate.getFullYear(), currentDate.getMonth(), 1).getDay() + 6) % 7;
    property int daysInMonth: new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0).getDate();
    property int daysInPrevMonth: new Date(currentDate.getFullYear(), currentDate.getMonth(), 0).getDate();
    property var monthMap : ({"1":"一月","2":"二月","3":"三月","4":"四月","5":"五月","6":"六月","7":"七月","8":"八月","9":"九月","10":"十月","11":"十一月","12":"十二月"})

    function complete(){
        let {hour, minute, second} = correctHMS()
        value = new Date(currentDate.getFullYear(),currentDate.getMonth(),currentDate.getDate(),hour,minute,second)
        datepicker_show.text = Qt.formatDateTime(value, "yyyy-MM-dd HH:mm:ss")
//        datePicked(currentDate)
        componet_datepicker.close()
    }
    // 修正时分秒
    function correctHMS(){
        let hour = parseInt(text_hour.text)
        if(!(hour>=0&&hour<24)){
            hour = 0
            text_hour.text = 0
        }
        let minute = parseInt(text_minute.text)
        if(!(minute>=0&&minute<60)){
            minute = 0
            text_minute.text = 0
        }
        let second = parseInt(text_second.text)
        if(!(second>=0&&second<60)){
            second = 0
            text_second.text = 0
        }
        return {
            hour,minute,second
        }
    }
    function setMonth(m){
        var newYear = currentDate.getFullYear()
        var newDay = currentDate.getDay()
        currentDate = new Date(newYear, m, newDay)
    }
    function setYear(y){
        var newMonth = currentDate.getMonth()
        var newDay = currentDate.getDay()
        currentDate = new Date(y, newMonth, newDay)
    }
    function addMonth(m){
        var newMonth = currentDate.getMonth()
        var newYear = currentDate.getFullYear()
        var newDay = currentDate.getDate()
        currentDate = new Date(newYear, newMonth + m, newDay)
    }

    Popup{
        id:componet_datepicker
        width: 400
        height: 380
        closePolicy: Popup.CloseOnEscape
        margins: 0
        padding: 12
        focus: true
        background: Rectangle{
			color: $theme.panel_bg
        }

        Rectangle{
            anchors.fill: parent
            id: theJWDMDatePicker
			color: $theme.panel_bg

            RowLayout{
                id: r1
                width: parent.width
                height: 36
                anchors.top: parent.top
                Rectangle{
                	color: "transparent"
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("日期时间选择")
                        color: $theme.color_text_inactive
                    }
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    MouseArea {
                        property point clickPoint: "0,0"
                        cursorShape: Qt.SizeAllCursor
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton
                        onPressed: (mouse)=>{
                            clickPoint  = Qt.point(mouse.x, mouse.y)
                        }
                        onPositionChanged: (mouse)=>{
                           let offset = Qt.point(mouse.x - clickPoint.x, mouse.y - clickPoint.y)
                           componet_datepicker.x = componet_datepicker.x + offset.x
                           componet_datepicker.y = componet_datepicker.y + offset.y
                        }
                    }
                }
                Button{
                    text: "\ue781"
                    font.family: $iconfont.family
                    font.pixelSize: 14
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 60
                    onClicked:function(){
                        clear()
                        componet_datepicker.close()
                    }
                }
                Button{
                	Material.theme: Material.Light
                    highlighted: true
                    text:"\ue8bd"
                    font.family: $iconfont.family
                    font.pixelSize: 14
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 60
                    onClicked:function(){
                        complete()
                    }
                }
            }

            RowLayout{
                id: r2
                width: parent.width
                height: 40
                anchors.top: r1.bottom
                anchors.topMargin: 8
                Text{
                    Layout.fillWidth: true
                    text: qsTr("时间：")
                    color: $theme.color_text_inactive
                    Layout.leftMargin: 8
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                TextField {
                    Layout.fillWidth: true
                    id: text_hour
                    renderType: Text.QtRendering
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    selectByMouse: true
                    clip: true
                    color: $theme.color_primary
//                    validator: IntValidator{bottom: 0; top: 23}
                    validator: RegularExpressionValidator{regularExpression:/^(\d{1})|([1]\d)|([2][0-3])$/}

                }
                Text{
                    Layout.leftMargin: 8
                    Layout.rightMargin: 8
                    text: ":"
                    color: $theme.color_text_inactive
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                TextField {
                    Layout.fillWidth: true
                    id: text_minute
                    renderType: Text.QtRendering
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    selectByMouse: true
                    color: $theme.color_primary
                    clip: true
//                    validator: IntValidator{bottom: 0; top: 59;}
                    validator: RegularExpressionValidator{regularExpression:/^(\d{1})|([1-5]\d)$/}
                }
                Text{
                    text: ":"
                    color: $theme.color_text_inactive
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.leftMargin: 8
                    Layout.rightMargin: 8
                }
                TextField {
                    Layout.fillWidth: true
                    height: parent.height
                    id: text_second
                    renderType: Text.QtRendering
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    selectByMouse: true
                    clip: true
                    color: $theme.color_primary
                    validator: RegularExpressionValidator{regularExpression:/^(\d{1})|([1-5]\d)$/}
                }

            }

            Column {
                id: theColumn
                width: parent.width
                anchors.top: r2.bottom
                anchors.topMargin: 8
                anchors.bottom: parent.bottom
                Item{
                    id: monthYear
                    width: parent.width
                    height: width / 10
                    Text{
                        id: leftKlick
                        font.family: $iconfont.family
                        font.pixelSize: 20
                        text: "\ue77f"
                        color: $theme.color_text_inactive
                        height: parent.height
                        width: height

                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                monthSelect.opacity = 0
                                yearSelect.opacity = 0
                                addMonth(-1)
                            }

                        }
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    Text{
                        id: monthText
                        text: qsTr(monthMap[currentDate.toLocaleDateString(Qt.locale(), "M")])
                        color: $theme.color_text
                        anchors.left: leftKlick.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        height: parent.height
                        anchors.right: yearText.left

                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                yearSelect.opacity = 0
                                if (monthSelect.opacity > 0){
                                    monthSelect.opacity = 0
                                }
                                else{
                                    monthSelect.opacity = 1
                                }
                            }
                        }
                    }
                    Text{
                        id: yearText
                        text: currentDate.getFullYear()
                        anchors.right: rightKlick.left
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        height: parent.height
                        width: contentWidth + rightKlick.width / 2
                        color: $theme.color_text
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                yearSelect.currentIndex = currentDate.getFullYear() - yearStart
                                monthSelect.opacity = 0
                                if (yearSelect.opacity > 0){
                                    yearSelect.opacity = 0
                                }
                                else{
                                    yearSelect.opacity = 1
                                }
                            }
                        }
                    }
                    Text{
                        id: rightKlick
                        font.family: $iconfont.family
                        font.pixelSize: 20
                        text: "\ue783"
                       	color: $theme.color_text_inactive
                        anchors.right: parent.right
                        height: parent.height
                        width: height
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                monthSelect.opacity = 0
                                yearSelect.opacity = 0
                                addMonth(1)
                            }
                        }
                    }

                }
                Rectangle{
                    height: 1
                    width: parent.width
                    id: line2
                    color: $color.gray500
                }
                Item{
                    width: parent.width
                    height: dayMonthYear.height
                    Column{
                        id: dayMonthYear
                        height: weekDays.height + line.height + daySelect.height
                        width: parent.width
                        Row{
                            visible: opacity > 0
                            opacity: daySelect.opacity
                            id: weekDays
                            width: parent.width
                            height: monthYear.height / 3 * 2
                            Repeater{
                                model: 7
                                delegate: Text{
                                    text: (new Date(1978, 5, 23 + index - 4)).toLocaleDateString(Qt.locale(), "ddd")
                                    width: weekDays.width / 7
                                    height: weekDays.height
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    color: $theme.color_text
                                }
                            }
                        }
                        Rectangle{
                            visible: opacity > 0
                            opacity: daySelect.opacity
                            id: line
                            color: $theme.color_text_inactive
                            height: 1
                            width: parent.width
                        }
                        Grid{
                            visible: opacity > 0
                            opacity: 1 - yearSelect.opacity - monthSelect.opacity
                            columns: 7
                            id: daySelect
                            width: parent.width
                            height: theColumn.height - theJWDMDatePicker.border.width * 2 - line.height - line2.height - weekDays.height  - monthYear.height
                            Repeater{
                                id: theRepeater
                                property int rows: (monthStartWeekDay == 0 ? 0 : 1) + (daysInMonth > 28 ? 5 : 4)
                                model: 7 * rows
                                delegate: Text{
                                    width: daySelect.width / 7
                                    height: daySelect.height / theRepeater.rows
                                    property date myDate: new Date(currentDate.getFullYear(), currentDate.getMonth(), (index - monthStartWeekDay + 1))
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    text: myDate.getDate()
                                    color: myDate.getMonth() > currentDate.getMonth() ? $theme.color_text_inactive : myDate.getMonth() < currentDate.getMonth() ? $theme.color_text_inactive : $theme.color_text
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked:{
                                            currentDate = new Date(myDate.getFullYear(),myDate.getMonth(),myDate.getDate())
                                        }
                                    }
                                    Rectangle{
                                        anchors.centerIn: parent
                                        width: height
                                        height: parent.contentHeight * 1.7
                                        radius: width / 2
                                        color: "transparent"
                                        border.width: 2
                                        border.color: selectColor
                                        visible: parent.myDate.getFullYear() == currentDate.getFullYear() && parent.myDate.getMonth() == currentDate.getMonth() && parent.myDate.getDate() == currentDate.getDate()
                                    }
                                }
                            }
                        }
                    }
                    GridView{
                        z: 1
                        visible: opacity > 0
                        opacity: 0
                        Behavior on opacity {
                            NumberAnimation{
                                duration: 100
                            }
                        }

                        id: yearSelect
                        anchors.fill: parent
                        clip: true
                        model: yearRange
                        cellHeight: height / 4
                        cellWidth: width / 4
                        currentIndex: currentDate.getFullYear() - yearStart
                        delegate:  Text{
                            width: yearSelect.cellWidth
                            height: yearSelect.cellHeight
							color: $theme.color_text
                            text: yearStart + index
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            MouseArea{
                                anchors.fill: parent
                                onClicked:{
                                    setYear(yearStart + index)
                                    yearSelect.opacity = 0
                                }
                            }
                            Rectangle{
                                anchors.centerIn: parent
                                width: parent.width * 4 / 5
                                height: parent.contentHeight * 1.5
                                radius: 5
                                color: "transparent"
                                border.width: 2
                                border.color: selectColor
                                visible: parent.text === currentDate.getFullYear().toString()
                            }
                        }
                    }

                    Grid{
                        z: 1
                        visible: opacity > 0
                        opacity: 0
                        Behavior on opacity {
                            NumberAnimation{
                                duration: 100
                            }
                        }
                        id: monthSelect
                        anchors.fill: parent
                        Repeater{
                            model: 12
                            Text {
                                color: $theme.color_text
                                width: monthSelect.width / 4
                                height: monthSelect.height / 3
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                text: monthMap[(new Date(1978, index, 1)).toLocaleDateString(Qt.locale(), "M")]
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked:{
                                        setMonth(index)
                                        monthSelect.opacity = 0
                                    }
                                }
                                Rectangle{
                                    anchors.centerIn: parent
                                    width: parent.width * 4 / 5
                                    height: parent.contentHeight * 1.5
                                    radius: 5
                                    color: "transparent"
                                    border.width: 2
                                    border.color: selectColor
                                    visible: parent.text === monthMap[currentDate.toLocaleDateString(Qt.locale(), "M")]
                                }
                            }
                        }
                    }

                }
            }
        }

    }

}



