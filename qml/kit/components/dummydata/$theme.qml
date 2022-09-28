import QtQuick 2.15

QtObject {
    // 边距
    property int margin: 12
    property int margin_lg: margin+4
    property int margin_xl: margin_lg+4
    property int margin_sm: margin-4
    property int margin_xs: margin_sm-4

    // 字体大小，用pointsize
    property int font_base: 16
    property int font_lg: font_base+2
    property int font_xl: font_lg+2
    property int font_sm: font_base-2
    property int font_xs: font_sm-2

    property color color_bg: "#393E46"
    property color color_text: "white"
    property color color_text_active: $color.blue600

    property color color_primary: $color.blue600
    property color color_primary_plain: $color.blue300
    property color color_primary_hover: $color.blue500
    property color color_primary_click: $color.blue700
    property color color_success: $color.green600
    property color color_success_plain: $color.green300
    property color color_success_hover:$color.green500
    property color color_success_click:$color.green700
    property color color_info: $color.gray500
    property color color_info_plain: $color.gray300
    property color color_info_hover:$color.gray400
    property color color_info_click:$color.gray600
    property color color_warning: $color.yellow500
    property color color_warning_plain: $color.yellow300
    property color color_warning_hover:$color.yellow400
    property color color_warning_click:$color.yellow600
    property color color_danger: $color.red500
    property color color_danger_plain: $color.red300
    property color color_danger_hover:$color.red400
    property color color_danger_click:$color.red600
    property color color_default:$color.gray800
}
