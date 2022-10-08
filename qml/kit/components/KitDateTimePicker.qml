import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

Button{
    id: datepicker_show
    flat: true

    onClicked: function(){
        componet_datepicker.open()
    }

//    signal datePicked(date d)

    // 也是作为起始时间
    property date currentDate: new Date()
    // 作为最终的确定时间
    property var value
    property color selectColor: Material.primary

    property int yearStart: new Date().getFullYear() - 150
    property int yearRange: 300
    property int monthStartWeekDay: (new Date(currentDate.getFullYear(), currentDate.getMonth(), 1).getDay() + 6) % 7;
    property int daysInMonth: new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0).getDate();
    property int daysInPrevMonth: new Date(currentDate.getFullYear(), currentDate.getMonth(), 0).getDate();
    property var monthMap : ({"1":"一月","2":"二月","3":"三月","4":"四月","5":"五月","6":"六月","7":"七月","8":"八月","9":"九月","10":"十月","11":"十一月","12":"十二月"})

    function complete(){
        // todo 外部使用的时候直接获取property
        let {hour, minute, second} = correntHMS()
        value = new Date(currentDate.getFullYear(),currentDate.getMonth(),currentDate.getDate(),hour,minute,second)
        datepicker_show.text = Qt.formatDateTime(value, "yyyy-MM-dd HH:mm:ss")
//        datePicked(currentDate)
        componet_datepicker.close()
    }
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
        datepicker_show.text=""
    }

    // 修正时分秒
    function correntHMS(){
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

        Rectangle{
            anchors.fill: parent
            id: theJWDMDatePicker

            RowLayout{
                id: r1
                width: parent.width
                height: 36
                anchors.top: parent.top
                Rectangle{
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("日期时间选择")
                        color: "gray"
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
                    validator: IntValidator{bottom: 0; top: 23}
                }
                Text{
                    Layout.leftMargin: 8
                    Layout.rightMargin: 8
                    text: ":"
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
                    validator: IntValidator{bottom: 0; top: 59;}
                }
                Text{
                    text: ":"
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
                    validator: IntValidator{bottom: 0; top: 59;}
                }

            }

            Column {
                id: theColumn
                width: parent.width
                anchors.top: r2.bottom
                anchors.topMargin: 8
                anchors.bottom: parent.bottom
//                Rectangle{
//                    color: "gray"
//                    height: 1
//                    width: parent.width
//                    id: line0
//                }
                Item{
                    id: monthYear
                    width: parent.width
                    height: width / 10
                    Text{
                        id: leftKlick
                        font.family: $iconfont.family
                        font.pixelSize: 20
                        text: "\ue77f"
                        color: "gray"
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
                        color: "gray"
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
                                }
                            }
                        }
                        Rectangle{
                            visible: opacity > 0
                            opacity: daySelect.opacity
                            id: line
                            color: "gray"
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
                                    color: myDate.getMonth() > currentDate.getMonth() ? "gray" : myDate.getMonth() < currentDate.getMonth() ? "gray" : "black"
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
                        delegate:                    Text{
                            width: yearSelect.cellWidth
                            height: yearSelect.cellHeight

//                            color: fontColor
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
//                                color: fontColor
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



