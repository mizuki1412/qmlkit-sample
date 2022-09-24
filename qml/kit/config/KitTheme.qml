import QtQuick 2.15

QtObject {
    // 边距
    property int margin: 12
    property int margin_lg: margin+4
    property int margin_xl: margin_lg+4
    property int margin_sm: margin-4
    property int margin_xs: margin_sm-4

    // 字体大小，用pointsize
    property int fontSize: 16
    property int fontSize_lg: fontSize+2
    property int fontSize_xl: fontSize_lg+2
    property int fontSize_sm: fontSize-2
    property int fontSize_xs: fontSize_sm-2

    // 背景主题色
    property color colorBg: "#393E46"
    property color colorText: "white"
    property color colorTextActive: "yellow"
}
