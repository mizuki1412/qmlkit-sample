import QtQuick 2.12
import "../qml_UI/MyStyle"
import "../Qml/Style"

MyButton{
    id: datepicker_show

    onClicked: function(){
        componet_datepicker.open()
    }

//    signal datePicked(date d)

    // 也是作为起始时间
    property date currentDate: new Date()
    // 作为最终的确定时间
    property var value
    property color fontColor: "white"
    property color prevMonthColor: "#A9A9A9"
    property color nextMonthColor: "#A9A9A9"
    property color borderColor: "grey"
    property color backgroundColor: Theme.colorBg
    property color selectColor: "yellow"

    property int yearStart: new Date().getFullYear() - 150
    property int yearRange: 300
    property int monthStartWeekDay: (new Date(currentDate.getFullYear(), currentDate.getMonth(), 1).getDay() + 6) % 7;
    property int daysInMonth: new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0).getDate();
    property int daysInPrevMonth: new Date(currentDate.getFullYear(), currentDate.getMonth(), 0).getDate();

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

    function setMonth(m)
    {
        var newYear = currentDate.getFullYear()
        var newDay = currentDate.getDay()
        currentDate = new Date(newYear, m, newDay)
    }
    function setYear(y)
    {
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

    MyPopup{
        id:componet_datepicker
        width: 400
        height: 330

        Rectangle{
            anchors.fill: parent
            id: theJWDMDatePicker
            color: backgroundColor
            border.width: 1
            border.color: borderColor

            width: 400
            height: 300

            Row{
                width: parent.width
                height: 24
                anchors.fill:parent
                Text{
                    width: parent.width/6-15
                    height: 24
                    color: "white"
                    text: "时间："
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                Rectangle {
                    width: parent.width/6-5
                    height: 24
                    color: "#484E58"
                    border.width: 1
                    border.color: Qt.rgba(238, 238, 238, 0.3)
                    radius: 2
                    TextInput {
                        id: text_hour
                        echoMode: TextInput.Normal
                        renderType: Text.QtRendering
                        font.pixelSize: 16
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        selectByMouse: true
                        clip: true
                        color: "yellow"
                        validator: IntValidator{bottom: 0; top: 23}
                    }
                }
                Text{
                    width: 10
                    height: 24
                    color: "white"
                    text: ":"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                Rectangle {
                    width: parent.width/6-5
                    height: 24
                    color: "#484E58"
                    border.width: 1
                    border.color: Qt.rgba(238, 238, 238, 0.3)
                    radius: 2
                    TextInput {
                        id: text_minute
                        echoMode: TextInput.Normal
                        renderType: Text.QtRendering
                        font.pixelSize: 16
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        selectByMouse: true
                        clip: true
                        color: "yellow"
                        validator: IntValidator{bottom: 0; top: 59;}
                    }
                }
                Text{
                    width: 10
                    height: 24
                    color: "white"
                    text: ":"
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                Rectangle {
                    width: parent.width/6-5
                    height: 24
                    color: "#484E58"
                    border.width: 1
                    border.color: Qt.rgba(238, 238, 238, 0.3)
                    radius: 2
                    TextInput {
                        id: text_second
                        echoMode: TextInput.Normal
                        renderType: Text.QtRendering
                        font.pixelSize: 16
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        selectByMouse: true
                        clip: true
                        color: "yellow"
                        validator: IntValidator{bottom: 0; top: 59;}
                    }
                }
                Text{
                    width: 10
                    height: 24

                }
                MyButton{
                    text:"清空"
                    width: parent.width/6
                    height: 24
                    color:Theme.colorBg
                    onClicked:function(){
                        clear()
                        componet_datepicker.close()
                    }
                }
                MyButton{
                    text:"确定"
                    width: parent.width/6
                    height: 24
                    color:Theme.colorBg
                    onClicked:function(){
                        complete()
                    }
                }

            }
            Column {
                id: theColumn
                width: theJWDMDatePicker.width
                height: theJWDMDatePicker.height
                anchors.centerIn: parent
                anchors.topMargin: 25
                anchors.fill:parent
                Rectangle
                {
                    color: "grey"
                    height: 1
                    width: parent.width
                    id: line0
                }
                Item
                {
                    id: monthYear
                    width: parent.width
                    height: width / 10
                    Text
                    {
                        id: leftKlick
                        text: "<"
                        height: parent.height
                        width: height
                        color: fontColor

                        MouseArea
                        {
                            anchors.fill: parent
                            onClicked:
                            {
                                monthSelect.opacity = 0
                                yearSelect.opacity = 0
                                addMonth(-1)
                            }

                        }
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    Text
                    {
                        id: monthText
                        text: currentDate.toLocaleDateString(Qt.locale(), "MMMM")
                        anchors.left: leftKlick.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        height: parent.height
                        anchors.right: yearText.left
                        color: fontColor

                        MouseArea
                        {
                            anchors.fill: parent
                            onClicked:
                            {
                                yearSelect.opacity = 0
                                if (monthSelect.opacity > 0)
                                {
                                    monthSelect.opacity = 0
                                }
                                else
                                {
                                    monthSelect.opacity = 1
                                }
                            }
                        }
                    }
                    Text
                    {
                        id: yearText
                        text: currentDate.getFullYear()
                        anchors.right: rightKlick.left
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        height: parent.height
                        width: contentWidth + rightKlick.width / 2
                        color: fontColor

                        MouseArea
                        {
                            anchors.fill: parent
                            onClicked:
                            {
                                yearSelect.currentIndex = currentDate.getFullYear() - yearStart
                                monthSelect.opacity = 0
                                if (yearSelect.opacity > 0)
                                {
                                    yearSelect.opacity = 0
                                }
                                else
                                {
                                    yearSelect.opacity = 1
                                }
                            }
                        }
                    }
                    Text
                    {
                        id: rightKlick
                        text: ">"
                        anchors.right: parent.right
                        height: parent.height
                        width: height
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: fontColor

                        MouseArea
                        {
                            anchors.fill: parent
                            onClicked:
                            {
                                monthSelect.opacity = 0
                                yearSelect.opacity = 0
                                addMonth(1)
                            }
                        }
                    }

                }
                Rectangle
                {
                    color: "grey"
                    height: 1
                    width: parent.width
                    id: line2
                }
                Item
                {
                    width: parent.width
                    height: dayMonthYear.height
                    Column
                    {
                        id: dayMonthYear
                        height: weekDays.height + line.height + daySelect.height
                        width: parent.width
                        Row
                        {
                            visible: opacity > 0
                            opacity: daySelect.opacity
                            id: weekDays
                            width: parent.width
                            height: monthYear.height / 3 * 2
                            Repeater
                            {
                                model: 7
                                delegate: Text
                                {
                                    color: fontColor

                                    text: (new Date(1978, 5, 23 + index - 4)).toLocaleDateString(Qt.locale(), "ddd")
                                    width: weekDays.width / 7
                                    height: weekDays.height
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }
                        Rectangle
                        {
                            visible: opacity > 0
                            opacity: daySelect.opacity
                            id: line
                            color: "grey"
                            height: 1
                            width: parent.width
                        }
                        Grid
                        {
                            visible: opacity > 0
                            opacity: 1 - yearSelect.opacity - monthSelect.opacity
                            columns: 7
                            id: daySelect
                            width: parent.width
                            height: theColumn.height - theJWDMDatePicker.border.width * 2 - line.height - line2.height - weekDays.height  - monthYear.height
                            Repeater
                            {
                                id: theRepeater
                                property int rows: (monthStartWeekDay == 0 ? 0 : 1) + (daysInMonth > 28 ? 5 : 4)
                                model: 7 * rows
                                delegate: Text
                                {

                                    width: daySelect.width / 7
                                    height: daySelect.height / theRepeater.rows
                                    property date myDate: new Date(currentDate.getFullYear(), currentDate.getMonth(), (index - monthStartWeekDay + 1))
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    text: myDate.getDate()
                                    color: myDate.getMonth() > currentDate.getMonth() ? nextMonthColor :
                                                                                        myDate.getMonth() < currentDate.getMonth() ? prevMonthColor : fontColor
                                    MouseArea
                                    {
                                        anchors.fill: parent
                                        onClicked:{
                                            currentDate = new Date(myDate.getFullYear(),myDate.getMonth(),myDate.getDate())
                                        }
                                    }
                                    Rectangle
                                    {
                                        anchors.centerIn: parent
                                        width: height
                                        height: parent.contentHeight * 1.7
                                        radius: width / 2
                                        color: "transparent"
                                        border.width: 1
                                        border.color: selectColor
                                        visible: parent.myDate.getFullYear() == currentDate.getFullYear() && parent.myDate.getMonth() == currentDate.getMonth() && parent.myDate.getDate() == currentDate.getDate()
                                    }
                                }
                            }
                        }
                    }
                    GridView
                    {
                        z: 1
                        visible: opacity > 0
                        opacity: 0
                        Behavior on opacity {
                            NumberAnimation
                            {
                                duration: 200
                            }
                        }

                        id: yearSelect
                        anchors.fill: parent
                        clip: true
                        model: yearRange
                        cellHeight: height / 4
                        cellWidth: width / 4
                        currentIndex: currentDate.getFullYear() - yearStart
                        delegate:                    Text
                        {
                            width: yearSelect.cellWidth
                            height: yearSelect.cellHeight

                            color: fontColor
                            text: yearStart + index
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            MouseArea
                            {
                                anchors.fill: parent
                                onClicked:
                                {
                                    setYear(yearStart + index)
                                    yearSelect.opacity = 0
                                }
                            }
                            Rectangle
                            {
                                anchors.centerIn: parent
                                width: parent.width * 4 / 5
                                height: parent.contentHeight * 1.5
                                radius: 5
                                color: "transparent"
                                border.width: 1
                                border.color: selectColor
                                visible: parent.text == currentDate.getFullYear().toString()
                            }
                        }
                    }

                    Grid
                    {
                        z: 1
                        visible: opacity > 0
                        opacity: 0
                        Behavior on opacity {
                            NumberAnimation{
                                duration: 200
                            }
                        }
                        id: monthSelect
                        anchors.fill: parent
                        Repeater
                        {
                            model: 12
                            Text {

                                color: fontColor
                                width: monthSelect.width / 4
                                height: monthSelect.height / 3
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                text: (new Date(1978, index, 1)).toLocaleDateString(Qt.locale(), "MMM")
                                MouseArea
                                {
                                    anchors.fill: parent
                                    onClicked:
                                    {
                                        setMonth(index)
                                        monthSelect.opacity = 0
                                    }
                                }
                                Rectangle
                                {
                                    anchors.centerIn: parent
                                    width: parent.width * 4 / 5
                                    height: parent.contentHeight * 1.5
                                    radius: 5
                                    color: "transparent"
                                    border.width: 1
                                    border.color: selectColor
                                    visible: parent.text === currentDate.toLocaleDateString(Qt.locale(), "MMM")
                                }
                            }
                        }
                    }

                }
            }
        }

    }

}



