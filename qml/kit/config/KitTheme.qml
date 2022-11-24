import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

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

	// 主题色
	property var theme: Material.Light
    property color color_bg: "#393E46"
    property color color_text: "white"
    property color color_text_active: $color.blue600
    property color color_text_inactive: $color.gray600

	// temp
    property color color_primary: Material.color(Material.Blue)
    property color color_success: Material.color(Material.Green)
    property color color_info: $color.gray400
    property color color_warning: Material.color(Material.Amber)
    property color color_danger: Material.color(Material.Red)
    property color color_default:$color.gray600

	// table
    property color table_font_header_color: "black"
    property color table_font_data_color: "black"
    property color table_header_bg: $color.gray200
    // 内容部分的间隔底色
    property color table_data_bg1: "white"
    property color table_data_bg2: $color.gray100
    // 选中的底色
    property color table_select_bg: $color.blue300
    property color table_select_font_color: "white"
//    property color table_right_menu_select_bg: color_primary
//    property color table_right_menu_select_font_color: "white"
//    property color table_right_menu_font_color: "white"

    // modal
//    property color model_bg: $color.gray100

	// component collapse
	property color collapse_title_bg: $color.gray200
	property color collapse_body_bg: $color.gray200

	// button/datatimepicker 如果用自定义的话
	property color color_btn_bg: "#252A48"
	property color color_btn_border: "#383B54"
    property int color_btn_radius: 4
}
